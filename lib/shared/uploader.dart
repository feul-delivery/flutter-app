import 'dart:io';
import 'package:FD_flutter/wrapper.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:FD_flutter/modules/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Uploader extends StatefulWidget {
  final String dateAjoute;
  final File file;
  final String filePath;
  final String collection;
  final bool isMany;
  Uploader(
      {@required this.file,
      @required this.filePath,
      @required this.collection,
      @required this.isMany,
      this.dateAjoute});

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

  void addToImages() async {
    String _uid = Provider.of<User>(context).uid;
    Map<dynamic, dynamic> _imageSet = {
      'photoURL': _photoURL,
      'dateAjoute': widget.dateAjoute
    };
    await Firestore.instance
        .collection(widget.collection)
        .document(_uid)
        .updateData({
      'images': FieldValue.arrayUnion([_imageSet])
    });
  }

  /// Starts an upload task
  void _startUpload() {
    String _filePath = widget.filePath;
    if (widget.isMany) {
      _filePath = _filePath + widget.dateAjoute;
    }

    _reference = _storage.ref().child(_filePath);

    setState(() {
      _uploadTask = _reference.putFile(widget.file);
    });
  }

  _addFileToFirestore(BuildContext context) async {
    _photoURL = await (await _uploadTask.onComplete).ref.getDownloadURL();
    if (widget.isMany) {
      addToImages();
    } else {
      updateUser();
    }
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Wrapper()));
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
            if (_uploadTask.isComplete) _addFileToFirestore(context);
            return Column(
              children: [
                if (_uploadTask.isPaused)
                  FlatButton(
                    child: Icon(AntDesign.upload),
                    onPressed: _uploadTask.resume,
                  ),

                if (_uploadTask.isInProgress)
                  FlatButton(
                    child: Icon(AntDesign.pause),
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
