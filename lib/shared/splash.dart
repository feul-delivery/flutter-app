import 'package:feul_delivery/pages/StarterPage.dart';
import 'package:feul_delivery/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isFirstTime = false;

  @override
  void initState() {
    super.initState();
    _getIsFirstTimeFromSharedPref();
    Future.delayed(Duration(seconds: 5), () {
      if (isFirstTime == false) {
        Navigator.pushReplacement(context,
            PageTransition(type: PageTransitionType.fade, child: Wrapper()));
      } else {
        _isFirstTimeChangeState();
        Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.fade, child: StarterPage()));
      }
    });
  }

  Future<void> _getIsFirstTimeFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    var isFirstTime = prefs.getBool('isFirstTime');
    if (isFirstTime != null) {
      isFirstTime = true;
    } else
      isFirstTime = false;
  }

  Future<void> _isFirstTimeChangeState() async {
    final prefs = await SharedPreferences.getInstance();
    if (isFirstTime) {
      setState(() => isFirstTime = false);
      await prefs.setBool('isFirstTime', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 215, 0, 0),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              width: 200,
              height: 200,
              child: Image(
                image: AssetImage('assets/fdsplash.png'),
                fit: BoxFit.fill,
              )),
          Text(
            'Fuel Delivery',
            style: TextStyle(
                fontFamily: 'Gotham',
                fontWeight: FontWeight.w700,
                fontSize: 50,
                color: Color.fromRGBO(246, 204, 7, 1)),
          ),
        ]),
      ),
    );
  }
}
