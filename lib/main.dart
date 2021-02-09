import 'package:flutter/material.dart';
import 'package:feul_delivery/pages/login.dart';
import 'package:feul_delivery/pages/StarterPage.dart';
import 'package:feul_delivery/pages/singup.dart';

String username = "user";
void main() => runApp(MaterialApp(
        title: 'Fuel Delivery',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => StarterPage(),
          '/login': (context) => LoginPage(),
          '/singup': (context) => SignupPage(),
        }));
