import 'dart:io';

import 'package:FD_flutter/services/auth.dart';
import 'package:FD_flutter/shared/FadeAnimation.dart';
import 'package:FD_flutter/shared/loading.dart';
import 'package:FD_flutter/shared/splash.dart';
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
                        "${SplashScreen.mapLang['welcomeback']}",
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
                                    '${SplashScreen.mapLang['forgetpassword']}',
                                    style: pageTitleX,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(15, 7, 15, 7),
                                  child: TextFormField(
                                    style: TextStyle(fontSize: 18),
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      hintText: "email",
                                      hintStyle: hintStyle,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 15),
                                    ),
                                    validator: (val) {
                                      if (val.isEmpty ||
                                          !val.contains('@') ||
                                          !val.contains('.')) {
                                        return '${SplashScreen.mapLang['emailvalidator']}';
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
                                              "${SplashScreen.mapLang['cancel']}"
                                                  .toUpperCase(),
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
                                              "${SplashScreen.mapLang['sendemail']}"
                                                  .toUpperCase(),
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
                                              style: TextStyle(fontSize: 18),
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                hintText: "email",
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
                                                  return '${SplashScreen.mapLang['emailvalidator']}';
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
                                              style: TextStyle(fontSize: 18),
                                              obscureText: _isObscure,
                                              decoration: InputDecoration(
                                                hintText:
                                                    "${SplashScreen.mapLang['password']}",
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
                                                  ? '${SplashScreen.mapLang['passwordvalidator']}'
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
                                          style: errorTextStyle,
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
                                                    "${SplashScreen.mapLang['ERROR_WRONG_PASSWORD']}") {
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
                                                "${SplashScreen.mapLang['nointernet']}");
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
                                            "${SplashScreen.mapLang['login']}"
                                                .toUpperCase(),
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
