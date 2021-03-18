import 'dart:io';
import 'package:FD_flutter/services/auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<String> uploadFile(File image) async {
  final AuthService _auth = AuthService();
  final String uid = await _auth.currentUser();
  StorageReference storageReference =
      FirebaseStorage.instance.ref().child("images/profile/" + uid);
  StorageUploadTask storageUploadTask = storageReference.putFile(image);
  StorageTaskSnapshot storageTaskSnapshot = await storageUploadTask.onComplete;
  storageTaskSnapshot.ref.getDownloadURL().then((value) {
    if (value != null) {
      print('naaaaani');
      return value;
    }
  });
  print('naaaaani');
  return null;
}

Future<String> readImage() async {
  final AuthService _auth = AuthService();
  final String uid = await _auth.currentUser();
  try {
    String snapshot = await FirebaseStorage.instance
        .ref()
        .child("images/profile/" + uid)
        .getDownloadURL();
    print(snapshot);
    return snapshot;
  } catch (e) {
    return null;
  }
}
