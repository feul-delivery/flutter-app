import 'package:FD_flutter/shared/image_capture.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:FD_flutter/wrapper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class ImagesSt extends StatefulWidget {
  final String userUID;

  const ImagesSt({@required this.userUID});
  @override
  _ImagesStState createState() => _ImagesStState();
}

List<Map<dynamic, dynamic>> _imagesList;

void _deleteImage(
    Map<dynamic, dynamic> image, String uid, BuildContext context) {
  Firestore.instance.collection('entreprise').document(uid).updateData({
    'images': FieldValue.arrayRemove([image])
  }).whenComplete(() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Wrapper()));
  });
}

class _ImagesStState extends State<ImagesSt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFF0F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
            icon: Icon(AntDesign.arrowleft, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        actions: [
          IconButton(
            icon: Icon(OMIcons.addAPhoto, color: Colors.black),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ImageCapture(
                        filePath: 'images/${widget.userUID}/',
                        dateAjoute: DateTime.now().toString(),
                        collection: 'entreprise',
                        manyPics: true,
                      )));
            },
          ),
          SizedBox(
            width: 10,
          ),
          IconButton(
            icon: Icon(
              OMIcons.done,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => Wrapper()));
            },
          )
        ],
        title: Text('Images', style: pageTitleX),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection('entreprise')
            .document(widget.userUID)
            .get()
            .asStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container(
              width: MediaQuery.of(context).size.height * 1 / 5,
              child: Center(
                child: Icon(
                  OMIcons.error,
                  color: Color(0xFF1763B9),
                ),
              ),
            );
          }
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Container(
                width: MediaQuery.of(context).size.height * 1 / 5,
                child: Center(
                  child: Icon(
                    OMIcons.error,
                    color: Color(0xFF1763B9),
                  ),
                ),
              );

            case ConnectionState.waiting:
              return Container(
                height: MediaQuery.of(context).size.height * 1 / 5,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: customeCircularProgress,
                ),
              );
            case ConnectionState.active:
              return Container(
                height: MediaQuery.of(context).size.height * 1 / 5,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: customeCircularProgress,
                ),
              );
            default:
              _imagesList =
                  List<Map<dynamic, dynamic>>.from(snapshot.data['images'])
                      .toList();
              return GridView.count(
                crossAxisCount: 1,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 16 / 9,
                children: _imagesList
                    .map((e) => CachedNetworkImage(
                          imageUrl: e['photoURL'],
                          imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover)),
                              child: IconButton(
                                onPressed: () async {
                                  _deleteImage(
                                      e, snapshot.data.documentID, context);
                                },
                                icon: Icon(Icons.delete),
                                color: Colors.white,
                                iconSize: 40.0,
                              )),
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  Center(child: customeCircularProgress),
                        ))
                    .toList(),
              );
          }
        },
      ),
    );
  }
}
