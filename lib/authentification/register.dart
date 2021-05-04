import 'dart:io';
import 'package:FD_flutter/authentification/type_compte.dart';
import 'package:FD_flutter/services/auth.dart';
import 'package:FD_flutter/shared/FadeAnimation.dart';
import 'package:FD_flutter/shared/loading.dart';
import 'package:FD_flutter/shared/lang.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

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
  String passwordConf = '';
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            key: _mScaffoldState,
            resizeToAvoidBottomInset: true,
            backgroundColor: scaffoldBackground,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FadeAnimation(
                    0.1,
                    Container(
                      margin: EdgeInsets.all(15),
                      child: Text(
                        "${Language.mapLang['createaccount']},",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.w900),
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
                                    cursorColor: grayColor,
                                    cursorHeight: 25,
                                    cursorWidth: 1,
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      prefixIcon: email.isEmpty ||
                                              !email.contains('@') ||
                                              !email.contains('.')
                                          ? Icon(OMIcons.personAdd,
                                              color: grayColor)
                                          : Icon(OMIcons.person,
                                              color: Colors.green),
                                      hintText: "email",
                                      hintStyle: hintStyle,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 15.0),
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
                                Container(
                                  margin: EdgeInsets.fromLTRB(15, 7, 15, 7),
                                  child: TextFormField(
                                    cursorColor: grayColor,
                                    cursorHeight: 25,
                                    cursorWidth: 1,
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                    textInputAction: TextInputAction.next,
                                    obscureText: _isObscure,
                                    decoration: InputDecoration(
                                      prefixIcon: password.length > 7
                                          ? Icon(OMIcons.lock,
                                              color: Colors.green)
                                          : Icon(OMIcons.lockOpen,
                                              color: grayColor),
                                      hintText:
                                          "${Language.mapLang['password']}",
                                      suffixIcon: IconButton(
                                          icon: Icon(
                                            _isObscure
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: _isObscure
                                                ? grayColor
                                                : buttonColor,
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
                                    validator: (val) => val.length < 8
                                        ? '${Language.mapLang['passwordvalidator']}'
                                        : null,
                                    onChanged: (val) {
                                      setState(() => password = val);
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(15, 7, 15, 7),
                                  child: TextFormField(
                                    cursorColor: grayColor,
                                    cursorHeight: 25,
                                    cursorWidth: 1,
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      prefixIcon: passwordConf != password &&
                                              passwordConf.length > 0
                                          ? Icon(OMIcons.clear,
                                              color: Colors.red)
                                          : Icon(OMIcons.done,
                                              color: Colors.green),
                                      hintText: "confirmation",
                                      hintStyle: hintStyle,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 15.0),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        passwordConf = value;
                                      });
                                    },
                                    validator: (val) => val != password ||
                                            val.length == 0
                                        ? '${Language.mapLang['passwordmatch']}'
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                          )),
                      SizedBox(height: 15),
                      Text(error, style: errorTextStyle),
                      SizedBox(height: 10),
                      FadeAnimation(
                          0.1,
                          Container(
                            height: 45,
                            margin: EdgeInsets.fromLTRB(15, 7, 15, 7),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: buttonColor),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(5),
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
                                                '${Language.mapLang['emailvalidator']}';
                                          });
                                        } else {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      TypeCompte()));
                                        }
                                      }
                                    } on SocketException catch (_) {
                                      showInSnackBar(
                                          "${Language.mapLang['nointernet']}");
                                    }
                                  }
                                },
                                child: Center(
                                  child: Text(
                                    "${Language.mapLang['register']}"
                                        .toUpperCase(),
                                    style: buttonStyle,
                                  ),
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
