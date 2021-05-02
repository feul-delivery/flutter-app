import 'dart:developer';
import 'package:FD_flutter/modules/user.dart';
import 'package:FD_flutter/pages/client/profile_mdf.dart';
import 'package:FD_flutter/services/auth.dart';
import 'package:FD_flutter/shared/map_api.dart';
import 'package:FD_flutter/shared/lang.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:FD_flutter/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:FD_flutter/shared/splash.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsCl extends StatefulWidget {
  SettingsCl({Key key}) : super(key: key);

  @override
  _SettingsClState createState() => _SettingsClState();
}

AuthService _auth = AuthService();

class _SettingsClState extends State<SettingsCl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackground,
      appBar: AppBar(
        title: Text(
          "${Language.mapLang['settings']}",
          style: pageTitleX,
        ),
        leading: IconButton(
            icon: Icon(
              Icons.west,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: [
          InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Maps(
                          title: "Google Maps",
                        )));
              },
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: Icon(OMIcons.myLocation, color: Colors.black)))
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(scrollDirection: Axis.vertical, children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(width: 1, color: Colors.grey[300]))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                child: Text(
                  '${Language.mapLang['account']}',
                  style: pageTitleX,
                ),
              ),
              Material(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ProfileCLModifier()));
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Colors.blue[700],
                    ),
                    title: Text(
                      "${Language.mapLang['editprofile']}",
                      style: textStyle,
                    ),
                  ),
                ),
              ),
              Material(
                child: InkWell(
                  onTap: () {
                    _modalChangeEmailRow(context);
                  },
                  child: ListTile(
                    leading: Icon(
                      OMIcons.email,
                      color: Colors.blue[700],
                    ),
                    title: Text(
                      "${Language.mapLang['changeemail']}",
                      style: textStyle,
                    ),
                  ),
                ),
              ),
              Material(
                child: InkWell(
                  onTap: () {
                    _modalChangePasswordRow(context);
                  },
                  child: ListTile(
                    leading: Icon(
                      OMIcons.lock,
                      color: Colors.blue[700],
                    ),
                    title: Text(
                      "${Language.mapLang['changepassword']}",
                      style: textStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(width: 1, color: Colors.grey[300]))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
                child: Text(
                  'Application',
                  style: pageTitleX,
                ),
              ),
              Material(
                child: InkWell(
                  onTap: () {
                    _buildModalChangeLang(context);
                  },
                  child: ListTile(
                    leading: Icon(
                      OMIcons.language,
                      color: Colors.blue[700],
                    ),
                    title: Text(
                      "${Language.mapLang['changelang']}",
                      style: textStyle,
                    ),
                  ),
                ),
              ),
              Material(
                child: InkWell(
                  onTap: () {
                    _showModalBottomRateUs(context);
                  },
                  child: ListTile(
                    leading: Icon(
                      OMIcons.rateReview,
                      color: Colors.blue[700],
                    ),
                    title: Text(
                      "${Language.mapLang['rateus']}",
                      style: textStyle,
                    ),
                  ),
                ),
              ),
              Material(
                child: InkWell(
                  onTap: () {
                    _buildModalAboutUsRow(context);
                  },
                  child: ListTile(
                    leading: Icon(
                      OMIcons.info,
                      color: Colors.blue[700],
                    ),
                    title: Text(
                      "${Language.mapLang['aboutus']}",
                      style: textStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Material(
          child: InkWell(
              onTap: () async {
                _auth.signOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => Wrapper()));
              },
              child: ListTile(
                leading: Icon(OMIcons.exitToApp, color: Colors.redAccent),
                title: Text(
                  "${Language.mapLang['signout']}",
                  style: TextStyle(
                      fontFamily: 'Quarion',
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.3),
                ),
              )),
        )
      ]),
    );
  }
}

Future<void> _showModalBottomRateUs(BuildContext context) {
  return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (BuildContext context, setState) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(10),
                    child: Container(
                      height: 5,
                      width: MediaQuery.of(context).size.width * 0.3,
                      // margin: EdgeInsets.symmetric(
                      //     vertical: 0,
                      //     horizontal:
                      //         MediaQuery.of(context).size.width * 0.3),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(50)),
                    )),
                Container(
                    height: MediaQuery.of(context).size.height * 1 / 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.only(
                                left: 10, right: 10, bottom: 5, top: 10),
                            child: Text('${Language.mapLang['rateus']}',
                                style: pageTitleX)),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 4 / 5,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(Icons.star_border_outlined),
                                  Icon(Icons.star_border_outlined),
                                  Icon(Icons.star_border_outlined),
                                  Icon(Icons.star_border_outlined),
                                  Icon(Icons.star_border_outlined),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () async {},
                              child: Container(
                                height: 45,
                                margin: EdgeInsets.fromLTRB(15, 7, 15, 7),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.blue[700]),
                                child: Center(
                                  child: Text(
                                    "${Language.mapLang['submit']}"
                                        .toUpperCase(),
                                    style: buttonStyle,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ],
            ),
          );
        });
      });
}

Future<void> _modalChangePasswordRow(BuildContext context) {
  bool _isObscure = true;
  final _formKey = GlobalKey<FormState>();
  String _password;
  String _passwodOld;
  String _error = "";
  return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (BuildContext context, setState) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(10),
                      child: Container(
                        height: 5,
                        width: MediaQuery.of(context).size.width * 0.3,
                        // margin: EdgeInsets.symmetric(
                        //     vertical: 0,
                        //     horizontal:
                        //         MediaQuery.of(context).size.width * 0.3),
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(50)),
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.only(
                              left: 10, right: 10, bottom: 5, top: 10),
                          child: Text('${Language.mapLang['changepassword']}',
                              style: pageTitleX)),
                      SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.fromLTRB(15, 7, 15, 7),
                                    child: TextFormField(
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        hintText:
                                            "${Language.mapLang['oldpassword']}",
                                        hintStyle: hintStyle,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 15.0),
                                      ),
                                      onChanged: (value) {
                                        _passwodOld = value;
                                      },
                                      validator: (val) => val.length < 6
                                          ? '${Language.mapLang['passwordvalidator']}'
                                          : null,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(15, 7, 15, 7),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      obscureText: _isObscure,
                                      decoration: InputDecoration(
                                        hintText:
                                            "${Language.mapLang['password']}",
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
                                          ? '${Language.mapLang['passwordvalidator']}'
                                          : null,
                                      onChanged: (val) {
                                        setState(() {
                                          _password = val;
                                        });
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
                                      validator: (val) => val != _password
                                          ? '${Language.mapLang['passwordmatch']}'
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              _error,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: 'Gotham',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () async {
                                if (_password == _passwodOld) {
                                  setState(() {
                                    _error =
                                        "${Language.mapLang['changenewpassword']}";
                                  });
                                } else {
                                  if (_formKey.currentState.validate()) {
                                    String _email =
                                        Provider.of<User>(context).email;
                                    var result;
                                    try {
                                      result = await FirebaseAuth.instance
                                          .signInWithEmailAndPassword(
                                              email: _email,
                                              password: _passwodOld);
                                    } catch (e) {
                                      setState(() {
                                        _error = "${Language.mapLang['error']}";
                                      });
                                    }
                                    inspect(result);
                                    if (result.user.email == _email) {
                                      result.user.updatePassword(_password);
                                      Navigator.of(context).pop();
                                    }
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
                                    "${Language.mapLang['validate']}"
                                        .toUpperCase(),
                                    style: buttonStyle,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
      });
}

Future<void> _modalChangeEmailRow(BuildContext context) {
  bool _isObscure = true;
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  String _error = "";
  return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (BuildContext context, setState) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(10),
                    child: Container(
                      height: 5,
                      width: MediaQuery.of(context).size.width * 0.3,
                      // margin: EdgeInsets.symmetric(
                      //     vertical: 0,
                      //     horizontal:
                      //         MediaQuery.of(context).size.width * 0.3),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(50)),
                    )),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.only(
                              left: 10, right: 10, bottom: 5, top: 10),
                          child: Text('${Language.mapLang['changeemail']}',
                              style: pageTitleX)),
                      SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.fromLTRB(15, 7, 15, 7),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        hintText:
                                            "${Language.mapLang['newemail']}",
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
                                        setState(() => _email = val);
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(15, 7, 15, 7),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        hintText: "Confirmation",
                                        hintStyle: hintStyle,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 15.0),
                                      ),
                                      validator: (val) => val != _email
                                          ? '${Language.mapLang['passwordmatch']}'
                                          : null,
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(15, 7, 15, 7),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      obscureText: _isObscure,
                                      decoration: InputDecoration(
                                        hintText:
                                            "${Language.mapLang['password']}",
                                        hintStyle: hintStyle,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 15.0),
                                      ),
                                      validator: (val) => val == null
                                          ? '${Language.mapLang['enterpassword']}'
                                          : null,
                                      onChanged: (val) {
                                        _password = val;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              _error,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: 'Gotham',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () async {
                                String _emailOld =
                                    Provider.of<User>(context).email;
                                if (_email == _emailOld) {
                                  setState(() {
                                    _error =
                                        "${Language.mapLang['changenewemail']}";
                                  });
                                } else {
                                  if (_formKey.currentState.validate()) {
                                    String _email =
                                        Provider.of<User>(context).email;
                                    var _result;
                                    try {
                                      _result = await FirebaseAuth.instance
                                          .signInWithEmailAndPassword(
                                              email: _email,
                                              password: _password);
                                    } catch (e) {
                                      setState(() {
                                        _error = "${Language.mapLang['error']}";
                                      });
                                    }
                                    inspect(_result);
                                    if (_result.user.email == _email) {
                                      AuthService _auth = AuthService();
                                      _result.user.updateEmail(_email);
                                      _auth.updateEmail(_email, _emailOld);
                                      Navigator.of(context).pop();
                                    }
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
                                    "${Language.mapLang['validate']}"
                                        .toUpperCase(),
                                    style: buttonStyle,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
      });
}

Future<void> _buildModalAboutUsRow(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            color: scaffoldBackground,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(
                        left: 10, right: 10, bottom: 5, top: 10),
                    child: Text('${Language.mapLang['aboutus']}',
                        style: pageTitleX)),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor),
                                  boxShadow: [],
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          'assets/Fueldelivery.png'))),
                            ),
                            Column(
                              children: [
                                Text("Fuel Delivery"),
                                SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  'Build by the Flutter framework.',
                                  style: textStyle,
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          'Developped by:',
                          style: textStyle,
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          'ELHESSBI Imad',
                          style: titleStyleNew,
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          'ZAMOURI Iliyass',
                          style: titleStyleNew,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

Future<void> _buildModalChangeLang(BuildContext context) {
  bool _isUsed = false;
  return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (BuildContext context, setState) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _isUsed == true
                    ? Container(
                        height: 30,
                        color: Colors.red,
                        child: Center(
                            child: Text('${Language.mapLang['usedlang']}',
                                style: textStyleWhite)))
                    : Container(),
                Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(
                        left: 10, right: 10, bottom: 5, top: 10),
                    child: Text('${Language.mapLang['changelang']}',
                        style: pageTitleX)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                        onTap: () {
                          if (Language.mapLang['en'] != 'Anglais') {
                            _langChangeState('FR');
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => SplashScreen()));
                          } else {
                            // Navigator.of(context).pop();
                            setState(() {
                              _isUsed = true;
                            });
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.all(10),
                          child: Center(
                              child: Text('🇫🇷 ${Language.mapLang['fr']}',
                                  style: buttonStyleBlack)),
                        )),
                    InkWell(
                        onTap: () {
                          if (Language.mapLang['en'] != 'English') {
                            _langChangeState('EN');
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => SplashScreen()));
                          } else {
                            // Navigator.of(context).pop();
                            setState(() {
                              _isUsed = true;
                            });
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.all(10),
                          child: Center(
                              child: Text('🇺🇸 ${Language.mapLang['en']}',
                                  style: buttonStyleBlack)),
                        ))
                  ],
                ),
              ],
            ),
          );
        });
      });
}

// void showInSnackBar(String value, BuildContext context) {
//   SnackBar snackBar = new SnackBar(
//       backgroundColor: Colors.white,
//       content: new Text(value, style: textStyle));
//   _mScaffoldState.currentState.showSnackBar(snackBar);
// }

Future<void> _langChangeState(String lang) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('lang', lang);
}
