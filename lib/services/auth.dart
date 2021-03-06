import 'package:FD_flutter/modules/user.dart';
import 'package:FD_flutter/shared/lang.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  AuthResult _result;
  static String type;
  static String error = "An undefined Error happened.";
  // create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null
        ? User(uid: user.uid, account: AuthService.type, email: user.email)
        : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    FirebaseUser _user;
    try {
      type = await _getAccountType(email).whenComplete(() async {
        _result = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      });
    } catch (error) {
      _findError(error.code);
      return null;
    }
    _user = _result.user;
    return _userFromFirebaseUser(_user);
  }

//  Update elail of the current user
  Future updateEmail(String email, String oldEmail) async {
    FirebaseUser _firebaseUser = await _auth.currentUser();
    String _uid = _firebaseUser.uid;
    Firestore.instance
        .collection(type)
        .document(_uid)
        .updateData({'email': email});
    Firestore.instance.collection('user').document(oldEmail).delete();
    Firestore.instance
        .collection('user')
        .document(email)
        .setData({'account': type});
  }

  _findError(dynamic code) {
    switch (code) {
      case "ERROR_INVALID_EMAIL":
        error = "${Language.mapLang['ERROR_INVALID_EMAIL']}";
        break;
      case "ERROR_WRONG_PASSWORD":
        error = "${Language.mapLang['ERROR_WRONG_PASSWORD']}";
        break;
      case "ERROR_USER_NOT_FOUND":
        error = "${Language.mapLang['ERROR_USER_NOT_FOUND']}";
        break;
      case "ERROR_USER_DISABLED":
        error = "${Language.mapLang['ERROR_USER_DISABLED']}";
        break;
      case "ERROR_TOO_MANY_REQUESTS":
        error = "${Language.mapLang['ERROR_TOO_MANY_REQUESTS']}";
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
        error = "${Language.mapLang['ERROR_OPERATION_NOT_ALLOWED']}";
        break;
      default:
        error = "${Language.mapLang['UNDEFINED_ERROR']}";
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
      type = null;
      _typeAccountChangeStateSharedPrefs();
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> _typeAccountChangeStateSharedPrefs() async {
    print("shared pref");
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('typeAccount', null);
  }

  Future<String> _getAccountType(String email) async {
    String _typeAccount = '';
    await Firestore.instance
        .collection('user')
        .document(email)
        .get()
        .then((value) async {
      if (value.exists) {
        _typeAccount = value.data['account'].toString();
      }
    });
    return _typeAccount;
  }

  Future<String> currentUser() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    return user.uid;
  }

  Future<bool> changeClientToLivreur(
      DocumentSnapshot document, String uidEntreprise) async {
    String _clientUID = document.documentID;
    String _nom = await document['nom'];
    String _prenom = await document['prenom'];
    String _email = await document['email'];
    String _cin = await document['cin'];
    String _sexe = await document['sexe'];
    String _tele = document['tele'];
    String _photoURL = await document['photoURL'];

    await Firestore.instance
        .collection('livreur')
        .document(_clientUID)
        .setData({
      'nom': _nom.toLowerCase(),
      'prenom': _prenom.toLowerCase(),
      'email': _email.toLowerCase(),
      'cin': _cin.toLowerCase(),
      'sexe': _sexe.toLowerCase(),
      'tele': _tele.toLowerCase(),
      'photoURL': _photoURL.toLowerCase(),
      'dateajoute': DateTime.now().toString(),
      'statut': 'inactif',
      'uidentreprise': uidEntreprise,
    }).whenComplete(() async => await _clientRemoval(_email, _clientUID));

    return true;
  }

  _clientRemoval(String email, String uid) async {
    await Firestore.instance
        .collection('user')
        .document(email)
        .updateData({'account': 'livreur'});
    await Firestore.instance.collection('client').document(uid).delete();
    await Firestore.instance
        .collection('order')
        .where('uidclient', isEqualTo: uid)
        .getDocuments()
        .then((value) async {
      for (DocumentSnapshot doc in value.documents) {
        await Firestore.instance
            .collection('order')
            .document(doc.documentID)
            .delete();
      }
    });
  }
}
