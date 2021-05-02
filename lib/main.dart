import 'package:FD_flutter/pages/client/index_cl.dart';
import 'package:FD_flutter/pages/livreur/index_lv.dart';
import 'package:FD_flutter/pages/station/index_st.dart';
import 'package:FD_flutter/services/auth.dart';
import 'package:FD_flutter/shared/splash.dart';
import 'package:FD_flutter/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'authentification/authenticate.dart';
import 'authentification/type_compte.dart';
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
        routes: {
          '/': (context) => SplashScreen(),
          '/wrapper': (context) => Wrapper(),
          '/wrapper/authenticate': (context) => Authenticate(),
          '/wrapper/cl': (context) => IndexCl(),
          '/wrapper/lv': (context) => IndexLv(),
          '/wrapper/st': (context) => IndexSt(),
          '/wrapper/typecpt': (context) => TypeCompte(),
        },
      ),
    );
  }
}
