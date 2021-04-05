import 'dart:io';

import 'package:FD_flutter/authentification/type_compte.dart';
import 'package:FD_flutter/services/auth.dart';
import 'package:FD_flutter/shared/FadeAnimation.dart';
import 'package:FD_flutter/shared/loading.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<ScaffoldState> _mScaffoldState =
      new GlobalKey<ScaffoldState>();
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  String email = '';
  String password = '';
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            key: _mScaffoldState,
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FadeAnimation(
                    0.1,
                    Container(
                      margin: EdgeInsets.all(15),
                      child: Text(
                        "Create an account,",
                        style: TextStyle(
                          color: Colors.blue[700],
                          fontSize: 50,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    )),
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      FadeAnimation(
                          0.1,
                          Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.fromLTRB(15, 7, 15, 7),
                                  child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      hintText: "Email",
                                      hintStyle: hintStyle,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 15.0),
                                    ),
                                    validator: (val) {
                                      if (val.isEmpty ||
                                          !val.contains('@') ||
                                          !val.contains('.')) {
                                        return 'Please enter a valid email address.';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    onChanged: (val) {
                                      setState(() => email = val);
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(15, 7, 15, 7),
                                  child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    obscureText: _isObscure,
                                    decoration: InputDecoration(
                                      hintText: "Password",
                                      suffixIcon: IconButton(
                                          icon: Icon(
                                            _isObscure
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: _isObscure
                                                ? Color(0xFFB9BAC3)
                                                : Colors.blue[700],
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _isObscure = !_isObscure;
                                            });
                                          }),
                                      hintStyle: hintStyle,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 15.0),
                                    ),
                                    validator: (val) => val.length < 6
                                        ? 'enter a password 8+ chars long.'
                                        : null,
                                    onChanged: (val) {
                                      setState(() => password = val);
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(15, 7, 15, 7),
                                  child: TextFormField(
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      hintText: "Confirmation",
                                      hintStyle: hintStyle,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 15.0),
                                    ),
                                    validator: (val) => val != password
                                        ? 'confirmation do not match the password.'
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        error,
                        style: TextStyle(
                            color: Colors.red,
                            fontFamily: 'Gotham',
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FadeAnimation(
                          1.2,
                          InkWell(
                            onTap: () async {
                              if (_formKey.currentState.validate()) {
                                try {
                                  final result = await InternetAddress.lookup(
                                      'google.com');
                                  if (result.isNotEmpty &&
                                      result[0].rawAddress.isNotEmpty) {
                                    setState(() => loading = true);
                                    dynamic result = await _auth
                                        .registerWithEmailAndPassword(
                                            email, password);
                                    if (result == null) {
                                      setState(() {
                                        loading = false;
                                        error = 'Please supply a valid email';
                                      });
                                    } else {
                                      Navigator.pushReplacement(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType.fade,
                                              child: TypeCompte()));
                                    }
                                  }
                                } on SocketException catch (_) {
                                  showInSnackBar(
                                      "you don\'t have a internet connection");
                                }
                              }
                            },
                            child: Container(
                              height: 45,
                              margin: EdgeInsets.fromLTRB(15, 7, 15, 7),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.blue[700]),
                              child: Center(
                                child: Text(
                                  "Register".toUpperCase(),
                                  style: buttonStyle,
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  void showInSnackBar(String value) {
    SnackBar snackBar = new SnackBar(content: new Text(value));
    _mScaffoldState.currentState.showSnackBar(snackBar);
  }
}
