import 'package:feul_delivery/pages/client/profile_mdf.dart';
import 'package:feul_delivery/pages/client/settings_cl.dart';
import 'package:feul_delivery/pages/client/commandes_cl.dart';
import 'package:feul_delivery/pages/login.dart';
import 'package:feul_delivery/styles/textStyles.dart';
import 'package:flutter/material.dart';
import 'favoris_cl.dart';
import 'index_cl.dart';
import 'bbar_cl.dart';

// ignore: camel_case_types
class DrawerCL extends StatelessWidget {
  const DrawerCL({Key key}) : super(key: key);

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
                  backgroundImage: NetworkImage(
                    "https://images.unsplash.com/photo-1594616838951-c155f8d978a0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80",
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "Nom Prénom",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "Contact@gmail.com",
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
            selectedIndex = 0;
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => IndexCl()));
          },
          leading: Icon(
            Icons.home,
            color: Colors.red[900],
          ),
          title: Text(
            "Acceuil",
            style: textStyle,
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => profileCLModifier()));
          },
          leading: Icon(
            Icons.person,
            color: Colors.red[900],
          ),
          title: Text(
            "Mon Profile",
            style: textStyle,
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => FavorisCl()));
          },
          leading: Icon(
            Icons.favorite,
            color: Colors.red[900],
          ),
          title: Text(
            "Mes favoris",
            style: textStyle,
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => CommandeCl()));
          },
          leading: Icon(
            Icons.receipt,
            color: Colors.red[900],
          ),
          title: Text(
            "Mes commandes",
            style: textStyle,
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => SettingsCl()));
          },
          leading: Icon(
            Icons.settings,
            color: Colors.red[900],
          ),
          title: Text(
            "Paramètres",
            style: textStyle,
          ),
        ),
        Expanded(
            child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 35,
            margin: EdgeInsets.symmetric(horizontal: 55, vertical: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red[700]),
            child: Center(
              child: FlatButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()));
                },
                child: Text(
                  "Se déconnecter",
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
