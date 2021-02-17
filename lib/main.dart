import 'package:feul_delivery/shared/splash.dart';
import 'package:flutter/material.dart';
import 'package:feul_delivery/pages/StarterPage.dart';

String username = "";
void main() => runApp(MaterialApp(
        title: 'Fuel Delivery',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => Splash(),
          '/start': (context) => StarterPage(),
        }));
