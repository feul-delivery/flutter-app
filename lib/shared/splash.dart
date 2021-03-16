import 'package:FD_flutter/modules/user.dart';
import 'package:FD_flutter/shared/StarterPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:async';
import '../wrapper.dart';

bool isFirstTime = true;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () async {
      await _getIsFirstTimeFromSharedPref();
      if (!isFirstTime) {
        Navigator.pushReplacement(context,
            PageTransition(type: PageTransitionType.fade, child: Wrapper()));
      } else {
        await _isFirstTimeChangeState();
        Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.fade, child: StarterPage()));
      }
      Provider.of<User>(context, listen: true).setAll("", "", "");
    });
  }

  Future<void> _getIsFirstTimeFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isFirstTime') == null) {
      setState(() {
        isFirstTime = true;
      });
    } else {
      setState(() {
        isFirstTime = prefs.getBool('isFirstTime');
      });
    }
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
