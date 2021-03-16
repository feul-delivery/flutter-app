import 'package:flutter/cupertino.dart';

class User with ChangeNotifier {
  String uid;
  String account;
  String email;

  User({this.uid, this.account, this.email});
  setAll(String uid, String account, String email) {
    this.uid = uid;
    this.account = account;
    this.email = email;
  }

  setUid(String uid) {
    this.uid = uid;
  }

  setAccount(String account) {
    this.account = account;
  }

  String getuid() {
    return uid;
  }

  String getEmail() {
    return email;
  }

  String getAccount() {
    return this.account;
  }
}
