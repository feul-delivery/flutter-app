import 'package:FD_flutter/pages/client/commandes_cl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:FD_flutter/pages/client/profile_mdf.dart';
import 'package:FD_flutter/pages/client/settings_cl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:FD_flutter/services/auth.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:FD_flutter/wrapper.dart';
import 'package:flutter/material.dart';
import 'favoris_cl.dart';
import 'index_cl.dart';
import 'bbar_cl.dart';

class DrawerCL extends StatefulWidget {
  static String photoURL;
  static String titre;
  static String email;
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
            padding: EdgeInsets.only(top: 30.0),
            child: Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    DrawerCL?.photoURL == null
                        ? CircleAvatar(
                            radius: 50.0,
                            backgroundImage: AssetImage('assets/profile.png'),
                          )
                        : CachedNetworkImage(
                            imageUrl: DrawerCL?.photoURL,
                            imageBuilder: (context, imageProvider) =>
                                CircleAvatar(
                                    radius: 50.0,
                                    backgroundImage: imageProvider),
                            placeholder: (context, url) => CircleAvatar(
                                radius: 50.0,
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.black,
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Colors.blue),
                                )),
                            errorWidget: (context, url, error) => CircleAvatar(
                                radius: 50.0, child: Icon(Icons.error)),
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${DrawerCL?.titre}'.toUpperCase(),
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      '${DrawerCL?.email}'.toLowerCase(),
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.w200,
                      ),
                    )
                  ],
                )),
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
            child: Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () async {
                  _auth.signOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => Wrapper()));
                },
                child: Container(
                  height: 30,
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  width: MediaQuery.of(context).size.width * 1 / 4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.black),
                  child: Center(
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
                  color: Colors.black54,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade, child: SettingsCl()));
                },
              )
            ],
          ),
        ))
      ]),
    );
  }
}
