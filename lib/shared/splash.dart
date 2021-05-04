import 'package:FD_flutter/services/auth.dart';
import 'package:FD_flutter/shared/StarterPage.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'package:FD_flutter/shared/lang.dart';
import '../wrapper.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isFirstTime = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () async {
//where the user type will be backapped
      String _type = await _getUserTypeFromSharedPref();
      setState(() {
        AuthService.type = _type;
      });
      Language.lang = await _getUserLangFromSharedPref();
      if (Language.lang == 'FR') {
        setState(() {
          Language.toggleLang('FR');
        });
      } else {
        setState(() {
          Language.toggleLang('EN');
        });
      }

      await _getIsFirstTimeFromSharedPref();
      if (!_isFirstTime) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Wrapper()));
      } else {
        await _isFirstTimeChangeState();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => StarterPage()));
      }
    });
  }

//user type from shared prefs
  Future<String> _getUserTypeFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('typeAccount') == null) {
      return null;
    } else {
      return prefs.getString('typeAccount');
    }
  }

  Future<String> _getUserLangFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('lang') == null) {
      return 'FR';
    } else {
      return prefs.getString('lang');
    }
  }

  Future<void> _getIsFirstTimeFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isFirstTime') == null) {
      setState(() {
        _isFirstTime = true;
      });
    } else {
      setState(() {
        _isFirstTime = prefs.getBool('isFirstTime');
      });
    }
  }

  Future<void> _isFirstTimeChangeState() async {
    final prefs = await SharedPreferences.getInstance();
    if (_isFirstTime) {
      setState(() => _isFirstTime = false);
      await prefs.setBool('isFirstTime', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackground,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              width: MediaQuery.of(context).size.width * 0.60,
              height: MediaQuery.of(context).size.width * 0.60,
              child: Hero(
                tag: 'logo',
                child: Image(
                  image: AssetImage('assets/splash.png'),
                  fit: BoxFit.fill,
                ),
//                  child:SvgPicture.asset(
//   'assets/logo.svg',
//   semanticsLabel: 'Logo'
// )
              )),
        ]),
      ),
    );
  }
}
