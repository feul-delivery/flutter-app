import 'package:FD_flutter/pages/client/commandes_cl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:FD_flutter/pages/client/profile_mdf.dart';
import 'package:FD_flutter/pages/client/settings_cl.dart';
import 'package:FD_flutter/services/auth.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:FD_flutter/wrapper.dart';
import 'package:flutter/material.dart';

import 'favoris_cl.dart';
import 'index_cl.dart';
import 'bbar_cl.dart';

// ignore: camel_case_types
class DrawerCL extends StatefulWidget {
  @override
  _DrawerCLState createState() => _DrawerCLState();
}

class _DrawerCLState extends State<DrawerCL> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width * 2 / 3,
      child: Column(children: [
        Container(
          child: Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IndexCl.client?.photoURL == null
                      ? CircleAvatar(
                          radius: 35.0,
                          backgroundImage: AssetImage('assets/profile.png'),
                        )
                      : CachedNetworkImage(
                          imageUrl: IndexCl.client.photoURL,
                          imageBuilder: (context, imageProvider) =>
                              CircleAvatar(
                                  radius: 35.0, backgroundImage: imageProvider),
                          placeholder: (context, url) => CircleAvatar(
                              radius: 35.0, child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => CircleAvatar(
                              radius: 35.0, child: Icon(Icons.error)),
                        ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Column(
                      children: [
                        Text(
                            "${IndexCl.client?.nom?.toUpperCase()} ${IndexCl.client?.prenom?.toUpperCase()}",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Gotham',
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                            )),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          "${IndexCl.client?.email}",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Gotham',
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        ListTile(
          onTap: () {
            ButtomBarCl.selectedIndex = 0;
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => IndexCl()));
          },
          leading: Icon(
            Icons.home,
            color: Colors.black,
          ),
          title: Text(
            "Home",
            style: textStyle,
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => ProfileCLModifier()));
          },
          leading: Icon(
            Icons.person,
            color: Colors.black,
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
            color: Colors.black,
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
            color: Colors.black,
          ),
          title: Text(
            "My orders",
            style: textStyle,
          ),
        ),
        Expanded(
            child: Container(
          margin: EdgeInsets.fromLTRB(10, 10, 20, 10),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Container(
                  height: 40,
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.black),
                  child: Center(
                    child: FlatButton(
                      onPressed: () async {
                        await _auth.signOut();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => new Wrapper()));
                      },
                      child: Text(
                        "Sign out",
                        style: buttonStyle,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => SettingsCl()));
                  },
                )
              ],
            ),
          ),
        ))
      ]),
    );
  }
}
