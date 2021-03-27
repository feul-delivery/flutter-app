import 'package:FD_flutter/pages/admin/livreur_admin.dart';
import 'package:FD_flutter/pages/admin/profile_admin.dart';
import 'package:FD_flutter/pages/admin/settings_admin.dart';
import 'package:FD_flutter/pages/admin/station_admin.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:FD_flutter/authentification/sign_in.dart';
import 'package:page_transition/page_transition.dart';

class DrawerAdmin extends StatelessWidget {
  const DrawerAdmin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width * 2 / 3,
      child: Column(children: [
        Container(
          child: Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage('assets/profile.png'),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "Admin",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "contact@admin.com",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        ListTile(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade, child: ProfileAdmin()));
          },
          leading: Icon(
            Icons.person,
            color: Colors.yellow[700],
          ),
          title: Text("Mon Profile"),
        ),
        ListTile(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade, child: StationsPage()));
          },
          leading: Icon(
            Icons.business,
            color: Colors.yellow[700],
          ),
          title: Text("Businesses"),
        ),
        ListTile(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade, child: LiveursPage()));
          },
          leading: Icon(
            Icons.group,
            color: Colors.yellow[700],
          ),
          title: Text("Deliverymen"),
        ),
        ListTile(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade, child: SettingsAdmin()));
          },
          leading: Icon(
            Icons.settings,
            color: Colors.yellow[700],
          ),
          title: Text("Settings"),
        ),
        Expanded(
            child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 40,
            margin: EdgeInsets.symmetric(horizontal: 45, vertical: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.yellow[700]),
            child: Center(
              child: FlatButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => SignIn()));
                },
                child: Text(
                  "Sign out",
                  style: buttonStyle,
                ),
              ),
            ),
          ),
        ))
      ]),
    );
  }
}
