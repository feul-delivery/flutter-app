import 'dart:io';

import 'package:FD_flutter/services/auth.dart';
import 'package:FD_flutter/shared/FadeAnimation.dart';
import 'package:FD_flutter/shared/loading.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:FD_flutter/wrapper.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
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
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FadeAnimation(
                    0.1,
                    Container(
                      margin: EdgeInsets.all(15),
                      child: Text(
                        "Welcome Back",
                        style: TextStyle(
                          color: Colors.blue[700],
                          fontSize: 50,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    )),
                SizedBox(
                  height: 15,
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      _password == 3
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  margin: EdgeInsets.only(
                                      left: 10, right: 10, bottom: 5),
                                  child: Text(
                                    'Forgot your password?',
                                    style: pageTitleX,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(15, 7, 15, 7),
                                  child: TextFormField(
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      hintText: "Email",
                                      hintStyle: hintStyle,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 15),
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
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            _password = 0;
                                          });
                                        },
                                        child: Container(
                                          height: 45,
                                          margin:
                                              EdgeInsets.fromLTRB(5, 7, 5, 7),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.45,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.white),
                                          child: Center(
                                            child: Text(
                                              "Cancel".toUpperCase(),
                                              style: buttonStyleBlack,
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          height: 45,
                                          margin:
                                              EdgeInsets.fromLTRB(5, 7, 5, 7),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.45,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.blue[700]),
                                          child: Center(
                                            child: Text(
                                              "Send Email".toUpperCase(),
                                              style: buttonStyle,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                              ],
                            )
                          : Column(
                              children: <Widget>[
                                FadeAnimation(
                                    0.1,
                                    Form(
                                      key: _formKey,
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.fromLTRB(
                                                15, 7, 15, 7),
                                            child: TextFormField(
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                hintText: "Email",
                                                hintStyle: hintStyle,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 15),
                                              ),
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
                                            margin: EdgeInsets.fromLTRB(
                                                15, 7, 15, 7),
                                            child: TextFormField(
                                              obscureText: _isObscure,
                                              decoration: InputDecoration(
                                                hintText: "Password",
                                                hintStyle: hintStyle,
                                                suffixIcon: IconButton(
                                                    icon: Icon(
                                                      _isObscure
                                                          ? Icons.visibility
                                                          : Icons
                                                              .visibility_off,
                                                      color: _isObscure
                                                          ? Color(0xFFB9BAC3)
                                                          : Colors.blue[700],
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        _isObscure =
                                                            !_isObscure;
                                                      });
                                                    }),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10.0,
                                                        vertical: 15.0),
                                              ),
                                              validator: (val) => val.length < 6
                                                  ? 'Enter a password 6+ chars long'
                                                  : null,
                                              onChanged: (val) {
                                                setState(() => password = val);
                                              },
                                            ),
                                          ),
                                        ],
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
                                        0.1,
                                        Text(
                                          errorMessage,
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontFamily: 'Gotham',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                SizedBox(
                                  height: 15,
                                ),
                                FadeAnimation(
                                    0.1,
                                    InkWell(
                                      onTap: () async {
                                        if (_formKey.currentState.validate()) {
                                          try {
                                            final result =
                                                await InternetAddress.lookup(
                                                    'google.com');
                                            if (result.isNotEmpty &&
                                                result[0]
                                                    .rawAddress
                                                    .isNotEmpty) {
                                              setState(() => loading = true);
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
                                              } else {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Wrapper()));
                                              }
                                              setState(() {
                                                loading = false;
                                              });
                                            }
                                          } on SocketException catch (_) {
                                            showInSnackBar(
                                                "Check your internet connection");
                                          }
                                        }
                                      },
                                      child: Container(
                                        height: 45,
                                        margin:
                                            EdgeInsets.fromLTRB(15, 7, 15, 7),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.blue[700]),
                                        child: Center(
                                          child: Text(
                                            "Log in".toUpperCase(),
                                            style: buttonStyle,
                                          ),
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  void showInSnackBar(String value) {
    SnackBar snackBar = new SnackBar(
        backgroundColor: Colors.white,
        content: new Text(value, style: textStyle));
    _mScaffoldState.currentState.showSnackBar(snackBar);
  }
}
