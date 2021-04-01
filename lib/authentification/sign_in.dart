import 'dart:io';

import 'package:FD_flutter/services/auth.dart';
import 'package:FD_flutter/shared/FadeAnimation.dart';
import 'package:FD_flutter/shared/loading.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  final GlobalKey<ScaffoldState> _mScaffoldState =
      new GlobalKey<ScaffoldState>();
  // text field state
  String email = '';
  String password = '';
  String errorMessage = '';
  bool _isObscure = true;
  int _password = 0;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            key: _mScaffoldState,
            body: Container(
              padding: EdgeInsets.only(top: 80),
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
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FadeAnimation(
                            0.2,
                            Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontFamily: 'Gotham',
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        FadeAnimation(
                            0.2,
                            Text(
                              "Welcome back",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Gotham',
                                fontWeight: FontWeight.w300,
                              ),
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
                          padding: EdgeInsets.all(30),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              _password == 3
                                  ? Container(
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Forgot your password?",
                                            style: textStyle,
                                          ),
                                          SizedBox(
                                            height: 20.0,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black38,
                                                      blurRadius: 20,
                                                      offset: Offset(0, 10))
                                                ]),
                                            child: TextFormField(
                                              textInputAction:
                                                  TextInputAction.done,
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
                                          SizedBox(
                                            height: 20.0,
                                          ),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                FlatButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        _password = 0;
                                                      });
                                                    },
                                                    child: Text(
                                                      'Close',
                                                      style: hintStyle,
                                                    )),
                                                InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    height: 30,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            1 /
                                                            5,
                                                    padding:
                                                        EdgeInsets.fromLTRB(0.0,
                                                            10.0, 0.0, 10.0),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        color: Colors.black),
                                                    child: Center(
                                                      child: Text(
                                                        "Submit",
                                                        style: buttonStyle,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                        ],
                                      ))
                                  : Column(
                                      children: <Widget>[
                                        FadeAnimation(
                                            0.2,
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
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
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                          border: Border(
                                                              bottom: BorderSide(
                                                                  color: Colors
                                                                          .grey[
                                                                      200]))),
                                                      child: TextFormField(
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        decoration:
                                                            InputDecoration(
                                                                hintText:
                                                                    "Email",
                                                                hintStyle:
                                                                    hintStyle,
                                                                border:
                                                                    InputBorder
                                                                        .none),
                                                        validator: (val) {
                                                          if (val.isEmpty ||
                                                              !val.contains(
                                                                  '@') ||
                                                              !val.contains(
                                                                  '.')) {
                                                            return 'Please enter a valid email address.';
                                                          }
                                                          return null;
                                                        },
                                                        keyboardType:
                                                            TextInputType
                                                                .emailAddress,
                                                        onChanged: (val) {
                                                          setState(() =>
                                                              email = val);
                                                        },
                                                      ),
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                          border: Border(
                                                              bottom: BorderSide(
                                                                  color: Colors
                                                                          .grey[
                                                                      200]))),
                                                      child: TextFormField(
                                                        obscureText: _isObscure,
                                                        decoration:
                                                            InputDecoration(
                                                                hintText:
                                                                    "Password",
                                                                hintStyle:
                                                                    hintStyle,
                                                                suffixIcon:
                                                                    IconButton(
                                                                        icon:
                                                                            Icon(
                                                                          _isObscure
                                                                              ? Icons.visibility
                                                                              : Icons.visibility_off,
                                                                          color: _isObscure
                                                                              ? Colors.black54
                                                                              : Colors.black,
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            _isObscure =
                                                                                !_isObscure;
                                                                          });
                                                                        }),
                                                                border:
                                                                    InputBorder
                                                                        .none),
                                                        validator: (val) => val
                                                                    .length <
                                                                6
                                                            ? 'Enter a password 6+ chars long'
                                                            : null,
                                                        onChanged: (val) {
                                                          setState(() =>
                                                              password = val);
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        errorMessage == ''
                                            ? SizedBox(
                                                height: 15,
                                              )
                                            : FadeAnimation(
                                                0.2,
                                                Text(
                                                  errorMessage,
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontFamily: 'Gotham',
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        FadeAnimation(
                                            0.2,
                                            InkWell(
                                              onTap: () async {
                                                if (_formKey.currentState
                                                    .validate()) {
                                                  try {
                                                    final result =
                                                        await InternetAddress
                                                            .lookup(
                                                                'google.com');
                                                    if (result.isNotEmpty &&
                                                        result[0]
                                                            .rawAddress
                                                            .isNotEmpty) {
                                                      setState(
                                                          () => loading = true);
                                                      dynamic user = await _auth
                                                          .signInWithEmailAndPassword(
                                                              email, password);
                                                      if (user == null) {
                                                        errorMessage =
                                                            AuthService.error;
                                                        if (errorMessage ==
                                                            "Your password is wrong.") {
                                                          setState(() {
                                                            _password++;
                                                          });
                                                        }

                                                        setState(() {
                                                          loading = false;
                                                        });
                                                      }
                                                      setState(() {
                                                        loading = false;
                                                      });
                                                    }
                                                  } on SocketException catch (_) {

                                                    showInSnackBar(
                                                        "you don\'t have a internet connection");
                                                  }
                                                }
                                              },
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    1 /
                                                    3,
                                                padding: EdgeInsets.fromLTRB(
                                                    20.0, 20.0, 20.0, 20.0),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    color: Colors.black),
                                                child: Center(
                                                  child: Text(
                                                    "Log in",
                                                    style: buttonStyle,
                                                  ),
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  FadeAnimation(
                                      0.2,
                                      Text(
                                        "you are new here?",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: 'Gotham',
                                          fontWeight: FontWeight.w300,
                                        ),
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  FadeAnimation(
                                      0.2,
                                      InkWell(
                                        hoverColor: Colors.black,
                                        onTap: () => widget.toggleView(),
                                        child: Container(
                                          height: 50,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              2 /
                                              3,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Colors.blue[900]),
                                          child: Center(
                                              child: Text(
                                                  "Create a new account",
                                                  style: buttonRegisterStyle)),
                                        ),
                                      ))
                                ],
                              )
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
