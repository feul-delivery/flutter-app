import 'package:FD_flutter/services/auth.dart';
import 'package:FD_flutter/shared/splash.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'modules/user.dart';

void main() => runApp(FuelDeliveryApp());

class FuelDeliveryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fuel Delivery',
        theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            cursorColor: grayColor,
            scaffoldBackgroundColor: darkGray,
            textTheme: TextTheme(
              button: buttonStyle,
              caption: hintStyle,
              bodyText1: textStyle,
              bodyText2: textStyle,
              subtitle1: hintStyle,
              subtitle2: subTitleStyle,
            ),
            inputDecorationTheme: InputDecorationTheme(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
              labelStyle: hintStyle,
              hintStyle: hintStyle,
              border: const OutlineInputBorder(),
            )),
        home: SplashScreen(),
        // routes: {
        //   '/': (context) => ,
        //   '/wrapper': (context) => Wrapper(),
        //   // '/wrapper/authenticate': (context) => Authenticate(),
        //   // '/wrapper/cl': (context) => IndexCl(),
        //   // '/wrapper/lv': (context) => IndexLv(),
        //   // '/wrapper/st': (context) => IndexSt(),
        //   // '/wrapper/typecpt': (context) => TypeCompte(),
        // },
      ),
    );
  }
}
