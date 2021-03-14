import 'package:flutter/cupertino.dart';

class User with ChangeNotifier {
  String uid;
  String account;

  User({this.uid, this.account});
  setAll(String uid, String account) {
    this.uid = uid;
    this.account = account;
  }

  setUid(String uid) {
    this.uid = uid;
  }

  setAccount(String account) {
    this.account = account;
  }

  String getAccount() {
    return this.account;
  }
}
