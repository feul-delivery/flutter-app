import 'package:FD_flutter/services/auth.dart';
import 'package:FD_flutter/shared/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'modules/user.dart';

void main() => runApp(FuelDeliveryApp());

class FuelDeliveryApp extends StatelessWidget {
  const FuelDeliveryApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        title: 'Fuel Delivery',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
      ),
    );
  }
}
