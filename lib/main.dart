import 'package:FD_flutter/services/auth.dart';
import 'package:FD_flutter/shared/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'modules/user.dart';

void main() => runApp(FuelDeliveryApp());

class FuelDeliveryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        title: 'Fuesl Delivery',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.black,
        ),
      ),
    );
  }
}
