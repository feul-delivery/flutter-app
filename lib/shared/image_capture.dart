import 'dart:io';

import 'package:FD_flutter/shared/text_styles.dart';
import 'package:FD_flutter/shared/uploader.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

/// Widget to capture and crop the image
class ImageCapture extends StatefulWidget {
  final String dateAjoute;
  final String filePath;
  final String collection;
  final bool manyPics;
  ImageCapture(
      {@required this.filePath,
      @required this.collection,
      @required this.manyPics,
      this.dateAjoute});

  createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  /// Active image file
  File _imageFile;

  /// Cropper plugin
  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      aspectRatioPresets: [CropAspectRatioPreset.square],
      maxWidth: 512,
      maxHeight: 512,
    );

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  /// Select an image via gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = selected;
    });
  }

  /// Remove image
  void _clear() {
    setState(() => _imageFile = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackground,
      // Select an image from the camera or gallery
      bottomNavigationBar: BottomAppBar(
        color: buttonColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                IconButton(
                  icon: Icon(Icons.photo_camera, color: Colors.white),
                  onPressed: () => _pickImage(ImageSource.camera),
                ),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                  icon: Icon(Icons.photo_library, color: Colors.white),
                  onPressed: () => _pickImage(ImageSource.gallery),
                ),
              ],
            ),
            _imageFile != null
                ? Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.crop, color: Colors.white),
                        onPressed: _cropImage,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      IconButton(
                        icon: Icon(Icons.refresh, color: Colors.white),
                        onPressed: _clear,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),

      // Preview the image and crop it
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: <Widget>[
            if (_imageFile != null) ...[
              Image.file(_imageFile),
              Uploader(
                file: _imageFile,
                filePath: widget.filePath,
                collection: widget.collection,
                isMany: widget.manyPics,
                dateAjoute: widget.dateAjoute,
              )
            ]
          ],
        ),
      ),
    );
  }
}
