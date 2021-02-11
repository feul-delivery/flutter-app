import 'package:feul_delivery/pages/admin/livreur_admin.dart';
import 'package:feul_delivery/pages/admin/profile_admin.dart';
import 'package:feul_delivery/pages/admin/settings_admin.dart';
import 'package:feul_delivery/pages/admin/station_admin.dart';
import 'package:flutter/material.dart';
import 'package:feul_delivery/pages/login.dart';
import 'package:page_transition/page_transition.dart';

class DrawerAdmin extends StatelessWidget {
  const DrawerAdmin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 260,
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
            color: Colors.red[900],
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
            color: Colors.red[900],
          ),
          title: Text("Entreprises"),
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
            color: Colors.red[900],
          ),
          title: Text("Livreurs"),
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
            color: Colors.red[900],
          ),
          title: Text("Paramètres"),
        ),
        Expanded(
            child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 35,
            margin: EdgeInsets.symmetric(horizontal: 65, vertical: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red[900]),
            child: Center(
              child: FlatButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()));
                },
                child: Text(
                  "Se déconnecter",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ))
      ]),
    );
  }
}
