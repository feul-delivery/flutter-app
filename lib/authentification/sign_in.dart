import 'dart:io';
import 'package:FD_flutter/services/auth.dart';
import 'package:FD_flutter/shared/FadeAnimation.dart';
import 'package:FD_flutter/shared/loading.dart';
import 'package:FD_flutter/shared/lang.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:FD_flutter/wrapper.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
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
            backgroundColor: scaffoldBackground,
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
                        "${Language.mapLang['welcomeback']}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.w900),
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
                                    '${Language.mapLang['forgetpassword']}',
                                    style: subTitleStyle,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(15, 7, 15, 7),
                                  child: TextFormField(
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
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
                                        return '${Language.mapLang['emailvalidator']}';
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
                                      Container(
                                        height: 45,
                                        margin: EdgeInsets.fromLTRB(5, 7, 5, 7),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.white),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            onTap: () {
                                              setState(() {
                                                _password = 0;
                                              });
                                            },
                                            child: Center(
                                              child: Text(
                                                "${Language.mapLang['cancel']}"
                                                    .toUpperCase(),
                                                style: buttonStyleBlack,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 45,
                                        margin: EdgeInsets.fromLTRB(5, 7, 5, 7),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: buttonColor),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            onTap: () {
                                              showInSnackBar("email sent");
                                            },
                                            child: Center(
                                              child: Text(
                                                "${Language.mapLang['sendemail']}"
                                                    .toUpperCase(),
                                                style: buttonStyle,
                                              ),
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
                                              cursorColor: grayColor,
                                              cursorHeight: 25,
                                              cursorWidth: 1,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                prefixIcon: Icon(OMIcons.person,
                                                    color: grayColor),
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
                                                  return '${Language.mapLang['emailvalidator']}';
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
                                              cursorColor: grayColor,
                                              cursorHeight: 25,
                                              cursorWidth: 1,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                              obscureText: _isObscure,
                                              decoration: InputDecoration(
                                                prefixIcon: password.length < 8
                                                    ? Icon(OMIcons.lock,
                                                        color: grayColor)
                                                    : Icon(OMIcons.lockOpen,
                                                        color: buttonColor),
                                                hintText:
                                                    "${Language.mapLang['password']}",
                                                hintStyle: hintStyle,
                                                suffixIcon: IconButton(
                                                    icon: Icon(
                                                      _isObscure
                                                          ? Icons.visibility
                                                          : Icons
                                                              .visibility_off,
                                                      color: _isObscure
                                                          ? grayColor
                                                          : buttonColor,
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
                                                  ? '${Language.mapLang['passwordvalidator']}'
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
                                    Container(
                                      margin: EdgeInsets.fromLTRB(15, 7, 15, 7),
                                      height: 45,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: buttonColor),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          onTap: () async {
                                            if (_formKey.currentState
                                                .validate()) {
                                              try {
                                                final result =
                                                    await InternetAddress
                                                        .lookup('google.com');
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
                                                        "${Language.mapLang['ERROR_WRONG_PASSWORD']}") {
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
                                                            builder:
                                                                (context) =>
                                                                    Wrapper()));
                                                  }
                                                  setState(() {
                                                    loading = false;
                                                  });
                                                }
                                              } on SocketException catch (_) {
                                                showInSnackBar(
                                                    "${Language.mapLang['nointernet']}");
                                              }
                                            }
                                          },
                                          child: Center(
                                            child: Text(
                                              "${Language.mapLang['login']}"
                                                  .toUpperCase(),
                                              style: buttonStyle,
                                            ),
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
