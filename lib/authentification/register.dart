import 'dart:io';

import 'package:FD_flutter/authentification/type_compte.dart';
import 'package:FD_flutter/services/auth.dart';
import 'package:FD_flutter/shared/FadeAnimation.dart';
import 'package:FD_flutter/shared/loading.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

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
            body: Container(
              padding: EdgeInsets.only(top: 40),
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                Colors.black87,
                Colors.black54,
                Colors.black45
              ])),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FadeAnimation(
                            1,
                            Text(
                              "Sign up",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 40),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        FadeAnimation(
                            1.3,
                            Text(
                              "Create an account, it's free",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            )),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              FadeAnimation(
                                  1.4,
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black38,
                                              blurRadius: 20,
                                              offset: Offset(0, 10))
                                        ]),
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color:
                                                            Colors.grey[200]))),
                                            child: TextFormField(
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                  hintText: "Email",
                                                  hintStyle: hintStyle,
                                                  border: InputBorder.none),
                                              validator: (val) {
                                                if (val.isEmpty ||
                                                    !val.contains('@') ||
                                                    !val.contains('.')) {
                                                  return 'Please enter a valid email address.';
                                                }
                                                return null;
                                              },
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              onChanged: (val) {
                                                setState(() => email = val);
                                              },
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color:
                                                            Colors.grey[200]))),
                                            child: TextFormField(
                                              textInputAction:
                                                  TextInputAction.next,
                                              obscureText: _isObscure,
                                              decoration: InputDecoration(
                                                  hintText: "Password",
                                                  suffixIcon: IconButton(
                                                      icon: Icon(
                                                        _isObscure
                                                            ? Icons.visibility
                                                            : Icons
                                                                .visibility_off,
                                                        color: _isObscure
                                                            ? Colors.black54
                                                            : Colors.black,
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          _isObscure =
                                                              !_isObscure;
                                                        });
                                                      }),
                                                  hintStyle: hintStyle,
                                                  border: InputBorder.none),
                                              validator: (val) => val.length < 6
                                                  ? 'enter a password 8+ chars long.'
                                                  : null,
                                              onChanged: (val) {
                                                setState(() => password = val);
                                              },
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color:
                                                            Colors.grey[200]))),
                                            child: TextFormField(
                                              obscureText: true,
                                              decoration: InputDecoration(
                                                  hintText: "Confirmation",
                                                  hintStyle: hintStyle,
                                                  border: InputBorder.none),
                                              validator: (val) => val !=
                                                      password
                                                  ? 'confirmation do not match the password.'
                                                  : null,
                                            ),
                                          ),
                                        ],
                                      ),
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
                                          final result =
                                              await InternetAddress.lookup(
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
                                                error =
                                                    'Please supply a valid email';
                                              });
                                            } else {
                                              Navigator.pushReplacement(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType
                                                          .fade,
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
                                      height: 50,
                                      width: MediaQuery.of(context).size.width *
                                          1 /
                                          3,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.black),
                                      child: Center(
                                        child: Text(
                                          "Register",
                                          style: buttonStyle,
                                        ),
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                height: 30,
                              ),
                              FadeAnimation(
                                  1.2,
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        "Already have an account?",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: 'Gotham',
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      FlatButton(
                                        onPressed: () => widget.toggleView(),
                                        child: Text(
                                          "Login",
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontFamily: 'Gotham',
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 1.2),
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }

  void showInSnackBar(String value) {
    SnackBar snackBar = new SnackBar(content: new Text(value));
    _mScaffoldState.currentState.showSnackBar(snackBar);
  }
}
