import 'package:FD_flutter/modules/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  static String type;
  static String error = "An undefined Error happened.";
  // create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null
        ? User(uid: user.uid, account: type, email: user.email)
        : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    FirebaseUser user;
    AuthResult result;
    try {
      type = await _getAccountType(email);
      result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (error) {
      _findError(error.code);
      return null;
    }
    user = result.user;

    print(type);
    return _userFromFirebaseUser(
      user,
    );
  }

  _findError(dynamic code) {
    switch (code) {
      case "ERROR_INVALID_EMAIL":
        error = "Your email address appears to be malformed.";
        break;
      case "ERROR_WRONG_PASSWORD":
        error = "Your password is wrong.";
        break;
      case "ERROR_USER_NOT_FOUND":
        error = "User with this email doesn't exist.";
        break;
      case "ERROR_USER_DISABLED":
        error = "User with this email has been disabled.";
        break;
      case "ERROR_TOO_MANY_REQUESTS":
        error = "Too many requests. Try again later.";
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
        error = "Signing in with Email and Password is not enabled.";
        break;
      default:
        error = "An undefined Error happened.";
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      // create a new document for the user with the uid
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      type = '';
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
    }
  }

  Future<String> _getAccountType(String uid) async {
    String typeAccount = '';
    await Firestore.instance
        .collection('user')
        .document(uid)
        .get()
        .then((value) async {
      if (value.exists) {
        typeAccount = value.data['account'].toString();
      }
    });
    return typeAccount;
  }
}
