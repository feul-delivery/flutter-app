import 'package:FD_flutter/authentification/register.dart';
import 'package:FD_flutter/authentification/sign_in.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFEFF0F5),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                  margin: EdgeInsets.fromLTRB(
                      20, MediaQuery.of(context).size.height * 0.25, 20, 20),
                  width: MediaQuery.of(context).size.width * 1 / 2,
                  height: MediaQuery.of(context).size.width * 1 / 2,
                  child: Hero(
                      tag: 'logo', child: Image.asset('assets/splash.png'))),
            ),
            Expanded(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () async {
                      Navigator.of(context).push(PageTransition(
                          type: PageTransitionType.fade, child: SignIn()));
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
                          "Sign in".toUpperCase(),
                          style: buttonStyle,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      Navigator.of(context).push(PageTransition(
                          type: PageTransitionType.fade, child: Register()));
                    },
                    child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.fromLTRB(
                          15, 7, 15, MediaQuery.of(context).size.width * 0.15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white),
                      child: Center(
                        child: Text(
                          "Register".toUpperCase(),
                          style: buttonStyleBlack,
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
    );
  }
}
