import 'package:FD_flutter/modules/user.dart';
import 'package:FD_flutter/pages/client/commandes_cl.dart';
import 'package:FD_flutter/pages/client/profile_mdf.dart';
import 'package:FD_flutter/pages/client/settings_cl.dart';
import 'package:FD_flutter/services/auth.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:FD_flutter/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'favoris_cl.dart';
import 'index_cl.dart';
import 'bbar_cl.dart';

// ignore: camel_case_types
class DrawerCL extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 260,
      child: Column(children: [
        Container(
          child: Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 35.0,
                  backgroundImage: NetworkImage(
                    "https://images.unsplash.com/photo-1594616838951-c155f8d978a0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80",
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "Name surname",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "Contact@gmail.com",
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                )
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
            "Home",
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
            "My profile",
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
            "Favorites",
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
            "My orders",
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
            "Settings",
            style: textStyle,
          ),
        ),
        Expanded(
            child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 40,
            margin: EdgeInsets.symmetric(horizontal: 45, vertical: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red[700]),
            child: Center(
              child: FlatButton(
                onPressed: () async {
                  await _auth.signOut();
                  Provider.of<User>(context, listen: true).setAll("", "", "");
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => Wrapper()));
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
