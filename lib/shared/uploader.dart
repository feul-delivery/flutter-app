import 'dart:io';
import 'package:FD_flutter/wrapper.dart';
import 'package:page_transition/page_transition.dart';
import 'package:FD_flutter/modules/user.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Uploader extends StatefulWidget {
  final File file;
  final String filePath;
  final String collection;
  final bool isMany;
  Uploader(
      {@required this.file,
      @required this.filePath,
      @required this.collection,
      @required this.isMany});

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://fuel-delivery-bts.appspot.com');

  StorageUploadTask _uploadTask;
  StorageReference _reference;
  String _photoURL;

  void updateUser() async {
    String _uid = Provider.of<User>(context).uid;
    await Firestore.instance
        .collection(widget.collection)
        .document(_uid)
        .updateData({'photoURL': _photoURL});
  }

  /// Starts an upload task
  void _startUpload() {
    /// Unique file name for the file'images/profile/${DateTime.now()}.png'
    String filePath = widget.filePath;
    _reference = _storage.ref().child(filePath);

    setState(() {
      _uploadTask = _reference.putFile(widget.file);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {
      /// Manage the task state and event subscription with a StreamBuilder
      return StreamBuilder<StorageTaskEvent>(
          stream: _uploadTask.events,
          builder: (_, snapshot) {
            var event = snapshot?.data?.snapshot;

            double progressPercent = event != null
                ? event.bytesTransferred / event.totalByteCount
                : 0;

            return Column(
              children: [
                if (_uploadTask.isComplete)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Uploading completed successfuly',
                                style: TextStyle(fontFamily: 'Gotham')),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.done)
                          ],
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 1 / 4,
                          height: 30,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                            child: Text('Done', style: buttonStyle),
                          ),
                        ),
                        onTap: () async {
                          _photoURL = await (await _uploadTask.onComplete)
                              .ref
                              .getDownloadURL();
                          updateUser();
                          Navigator.of(context).pushReplacement(PageTransition(
                              type: PageTransitionType.fade, child: Wrapper()));
                        },
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),

                if (_uploadTask.isPaused)
                  FlatButton(
                    child: Icon(Icons.play_arrow),
                    onPressed: _uploadTask.resume,
                  ),

                if (_uploadTask.isInProgress)
                  FlatButton(
                    child: Icon(Icons.pause),
                    onPressed: _uploadTask.pause,
                  ),

                // Progress bar
                LinearProgressIndicator(value: progressPercent),
                Text(
                  '${(progressPercent * 100).toStringAsFixed(2)} % ',
                  style: TextStyle(fontFamily: 'Gotham'),
                ),
              ],
            );
          });
    } else {
      // Allows user to decide when to start the upload
      return FlatButton.icon(
        label: Text('Upload'),
        icon: Icon(Icons.cloud_upload),
        onPressed: _startUpload,
      );
    }
  }
}
