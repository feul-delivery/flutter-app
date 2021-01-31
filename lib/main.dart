import 'package:flutter/material.dart';
import 'package:feul_delivery/pages/login.dart';
import 'package:feul_delivery/pages/StarterPage.dart';
import 'package:feul_delivery/pages/singup.dart';
import 'package:feul_delivery/pages/client/accueil_cl.dart';

void main() => runApp(MaterialApp(
    initialRoute: '/',
    debugShowCheckedModeBanner: false,
    routes: {
      '/':(context) => StarterPage(),
      '/login': (context) =>LoginPage(),
      '/singup': (context) =>SignupPage(),
      '/accueilcl' : (context) =>Cl()
      
    }
));