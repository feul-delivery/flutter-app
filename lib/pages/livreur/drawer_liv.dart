import 'package:FD_flutter/services/auth.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:FD_flutter/wrapper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'bbar_liv.dart';
import 'index_lv.dart';
import 'profile_liv_mdf.dart';
import 'setting_liv.dart';

class DrawerLiv extends StatefulWidget {
  @override
  _DrawerLivState createState() => _DrawerLivState();
}

class _DrawerLivState extends State<DrawerLiv> {
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: IndexLv?.livreur?.photoURL == null
                      ? ''
                      : IndexLv?.livreur?.photoURL,
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                      radius: 35.0, backgroundImage: imageProvider),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Container(
                    width: 70,
                    height: 70,
                    child: Center(
                        child: CircleAvatar(
                            radius: 35.0,
                            backgroundColor: darkGray,
                            child: Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                  '${IndexLv?.livreur?.nom}'
                                          .substring(0, 1)
                                          .toUpperCase() +
                                      '${IndexLv?.livreur?.prenom}'
                                          .substring(0, 1)
                                          .toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 35,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Quarion')),
                            ))),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "${IndexLv?.livreur?.nom} ${IndexLv?.livreur?.prenom}",
                      style: subTitleStyle,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "${IndexLv?.livreur?.email}",
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
            ButtomBarLiv.selectedIndex = 0;
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => IndexLv()));
          },
          leading: Icon(
            Icons.home,
            color: buttonColor,
          ),
          title: Text(
            "Accueil",
            style: textStyle,
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => ProfileLivModifier()));
          },
          leading: Icon(
            Icons.person,
            color: buttonColor,
          ),
          title: Text(
            "Profil",
            style: textStyle,
          ),
        ),
        // ListTile(
        //   onTap: () {
        //     Navigator.of(context).push(MaterialPageRoute(
        //         builder: (BuildContext context) => RapportLiv()));
        //   },
        //   leading: Icon(
        //     Icons.receipt,
        //     color: buttonColor,
        //   ),
        //   title: Text(
        //     "Rapport",
        //     style: textStyle,
        //   ),
        // ),
        ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => SettingsLiv()));
          },
          leading: Icon(
            Icons.settings,
            color: buttonColor,
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
            height: 40,
            margin: EdgeInsets.symmetric(horizontal: 45, vertical: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: buttonColor),
            child: Material(
              borderRadius: BorderRadius.circular(20),
              color: Colors.transparent,
              child: InkWell(
                onTap: () async {
                  await _auth.signOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => new Wrapper()));
                },
                child: Center(
                  child: Text(
                    "Déconnecté",
                    style: buttonStyle,
                  ),
                ),
              ),
            ),
          ),
        ))
      ]),
    );
  }
}
