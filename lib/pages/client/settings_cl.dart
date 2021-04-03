import 'package:FD_flutter/pages/client/profile_mdf.dart';
import 'package:FD_flutter/services/auth.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:FD_flutter/wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class SettingsCl extends StatefulWidget {
  SettingsCl({Key key}) : super(key: key);

  @override
  _SettingsClState createState() => _SettingsClState();
}

AuthService _auth = AuthService();

class _SettingsClState extends State<SettingsCl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackground,
      appBar: AppBar(
        title: Text(
          "Settings",
          style: pageTitleX,
        ),
        leading: IconButton(
            icon: Icon(
              OMIcons.arrowBack,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(scrollDirection: Axis.vertical, children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(width: 1, color: Colors.grey[300]))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                child: Text(
                  'Account',
                  style: pageTitleX,
                ),
              ),
              Material(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ProfileCLModifier()));
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Colors.blue[700],
                    ),
                    title: Text(
                      "Edit profile",
                      style: textStyle,
                    ),
                  ),
                ),
              ),
              Material(
                child: InkWell(
                  onTap: () {
                    _modalChangePasswordRow(context);
                  },
                  child: ListTile(
                    leading: Icon(
                      OMIcons.lock,
                      color: Colors.blue[700],
                    ),
                    title: Text(
                      "Change password",
                      style: textStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(width: 1, color: Colors.grey[300]))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
                child: Text(
                  'Application',
                  style: pageTitleX,
                ),
              ),
              Material(
                child: InkWell(
                  onTap: () {
                    _showModalBottomRateUs(context);
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.rate_review,
                      color: Colors.blue[700],
                    ),
                    title: Text(
                      "Rate us",
                      style: textStyle,
                    ),
                  ),
                ),
              ),
              Material(
                child: InkWell(
                  onTap: () {
                    _buildModalAboutUsRow(context);
                  },
                  child: ListTile(
                    leading: Icon(
                      OMIcons.info,
                      color: Colors.blue[700],
                    ),
                    title: Text(
                      "About us",
                      style: textStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Material(
          child: InkWell(
              onTap: () async {
                _auth.signOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => Wrapper()));
              },
              child: ListTile(
                leading: Icon(
                  OMIcons.exitToApp,
                  color: Colors.blue[700],
                ),
                title: Text(
                  "Sign out",
                  style: textStyle,
                ),
              )),
        )
      ]),
    );
  }
}

Future<void> _showModalBottomRateUs(BuildContext context) {
  return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (BuildContext context, setState) {
          return Container(
              height: MediaQuery.of(context).size.height * 1 / 4,
              child: ListView(
                children: [
                  Text('Rate us', style: smallTileGray),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.star_border_outlined),
                          Icon(Icons.star_border_outlined),
                          Icon(Icons.star_border_outlined),
                          Icon(Icons.star_border_outlined),
                          Icon(Icons.star_border_outlined),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      FlatButton(
                          onPressed: () {},
                          child: Text("Envoyer", style: buttonStyleBlack)),
                    ],
                  ),
                ],
              ));
        });
      });
}

Future<void> _modalChangePasswordRow(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: [
            Text('Change password', style: smallTileGray),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.grey[200]))),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "Old Password",
                        hintStyle: hintStyle,
                        border: InputBorder.none),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.grey[200]))),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "New Password",
                        hintStyle: hintStyle,
                        border: InputBorder.none),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.grey[200]))),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Confirmation",
                        hintStyle: hintStyle,
                        border: InputBorder.none),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                FlatButton(
                    onPressed: () {},
                    child: Text("Change", style: buttonStyleBlack)),
              ],
            ),
          ],
        );
      });
}

Future<void> _buildModalAboutUsRow(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: [
            Text(
              'About us',
              style: smallTileGray,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 10,
                          color: Theme.of(context).scaffoldBackgroundColor),
                      boxShadow: [],
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/Fueldelivery.png'))),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  'Build by the Flutter framework.',
                  style: textStyle,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Developped by:',
                  style: textStyle,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'ELHESSBI Imad',
                  style: textStyle,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'ZAMOURI Iliyass',
                  style: textStyle,
                ),
              ],
            ),
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Close",
                  style: buttonStyleBlack,
                )),
          ],
        );
      });
}
