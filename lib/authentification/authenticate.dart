import 'dart:io';
import 'dart:ui';

import 'package:FD_flutter/authentification/register.dart';
import 'package:FD_flutter/authentification/sign_in.dart';
import 'package:FD_flutter/shared/lang.dart';
import 'package:FD_flutter/shared/splash.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackground,
      appBar: AppBar(
        leading: SizedBox.shrink(),
        backgroundColor: scaffoldBackground,
        elevation: 0,
        actions: [
          Container(
              margin: EdgeInsets.all(5),
              child: InkWell(
                borderRadius: BorderRadius.circular(50.0),
                onTap: () async {
                  Language.lang == 'FR'
                      ? _langChangeState('EN')
                      : _langChangeState('FR');
                  Navigator.of(context).push(PageTransition(
                      type: PageTransitionType.fade, child: SplashScreen()));
                },
                child: Container(
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.all(5),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(OMIcons.language, color: Colors.white),
                        Container(
                          margin: EdgeInsets.only(top: 2.2),
                          child: Text(Language.lang == 'FR' ? 'FR' : 'US',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 15,
                                  decorationColor: Colors.white)),
                        ),
                      ]),
                ),
              )),
        ],
      ),
      body: WillPopScope(
        onWillPop: () {
          exit(0);
        },
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                    margin: EdgeInsets.fromLTRB(
                        20, MediaQuery.of(context).size.height * 0.25, 20, 20),
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: MediaQuery.of(context).size.width * 0.45,
                    child: Hero(
                      tag: 'logo',
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: MediaQuery.of(context).size.width * 0.45,
                        child: Image(
                          image: AssetImage('assets/splash.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    )),
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
                          borderRadius: BorderRadius.circular(5.0),
                          onTap: () async {
                            Navigator.of(context).push(PageTransition(
                                type: PageTransitionType.fade,
                                child: SignIn()));
                          },
                          child: Center(
                            child: Text(
                              "${Language.mapLang['signin']}".toUpperCase(),
                              style: buttonStyle,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.fromLTRB(
                          15, 7, 15, MediaQuery.of(context).size.width * 0.15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(5.0),
                          onTap: () async {
                            Navigator.of(context).push(PageTransition(
                                type: PageTransitionType.fade,
                                child: Register()));
                          },
                          child: Center(
                            child: Text(
                              "${Language.mapLang['register']}".toUpperCase(),
                              style: buttonStyleBlack,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _langChangeState(String lang) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('lang', lang);
}
