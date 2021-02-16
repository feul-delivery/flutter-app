import 'package:feul_delivery/pages/StarterPage.dart';
import 'package:feul_delivery/pages/admin/index_admin.dart';
import 'package:feul_delivery/pages/authentification/login.dart';
import 'package:feul_delivery/pages/station/index_st.dart';
import 'package:page_transition/page_transition.dart';
import 'package:feul_delivery/main.dart';
import 'package:feul_delivery/pages/client/index_cl.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      if (username == "user") {
        Navigator.pushReplacement(context,
            PageTransition(type: PageTransitionType.fade, child: IndexCl()));
      } else if (username == "0") {
        Navigator.pushReplacement(context,
            PageTransition(type: PageTransitionType.fade, child: LoginPage()));
      } else if (username == "") {
        Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.fade, child: StarterPage()));
      } else if (username == "admin") {
        Navigator.pushReplacement(context,
            PageTransition(type: PageTransitionType.fade, child: IndexAdmin()));
      } else if (username == "st") {
        Navigator.pushReplacement(context,
            PageTransition(type: PageTransitionType.fade, child: IndexSt()));
      }
    });
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
