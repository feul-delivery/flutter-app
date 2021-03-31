import 'package:FD_flutter/shared/custom_alert_dialog.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsCl extends StatefulWidget {
  SettingsCl({Key key}) : super(key: key);

  @override
  _SettingsClState createState() => _SettingsClState();
}

class _SettingsClState extends State<SettingsCl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Settings",
            style: pageTitle,
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          elevation: 1,
        ),
        body: Container(
          padding: EdgeInsets.only(left: 16, top: 25, right: 16),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(children: [
              Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Account",
                    style: tileTitleStyle,
                  ),
                ],
              ),
              Divider(
                height: 15,
                thickness: 1,
              ),
              buildChangePasswordRow(context, " Change Password"),
              buildAccountOptionRow(context, " Delete your account"),
              Row(
                children: [
                  Icon(
                    Icons.phone_iphone,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Application",
                    style: tileTitleStyle,
                  ),
                ],
              ),
              Divider(
                height: 15,
                thickness: 1,
              ),
              buildRateUsRow(context, " Rate us"),
              buildAboutUsRow(context, " About Us"),
              Row(
                children: [
                  Icon(
                    Icons.security,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Droits",
                    style: tileTitleStyle,
                  ),
                ],
              ),
              Divider(
                height: 15,
                thickness: 1,
              ),
              buildAccountOptionRow(context, " Privacy and Security"),
              SizedBox(
                height: 40,
              ),
            ]),
          ),
        ));
  }
}

InkWell buildChangePasswordRow(BuildContext context, String title) {
  return InkWell(
    borderRadius: BorderRadius.circular(5.0),
    onTap: () {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomAlertDialog(
              title: Text(title, style: smallTileGray),
              content: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey[200]))),
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
                          border: Border(
                              bottom: BorderSide(color: Colors.grey[200]))),
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
                          border: Border(
                              bottom: BorderSide(color: Colors.grey[200]))),
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
              ),
              actions: [
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
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: smallTileGray,
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.black45,
            size: 14,
          ),
        ],
      ),
    ),
  );
}

InkWell buildAboutUsRow(BuildContext context, String title) {
  return InkWell(
    borderRadius: BorderRadius.circular(5.0),
    onTap: () {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomAlertDialog(
              title: Text(
                title,
                style: smallTileGray,
              ),
              content: Column(
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
              actions: [
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
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: smallTileGray,
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.black45,
            size: 14,
          ),
        ],
      ),
    ),
  );
}

InkWell buildRateUsRow(BuildContext context, String title) {
  return InkWell(
    borderRadius: BorderRadius.circular(5.0),
    onTap: () {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomAlertDialog(
              title: Text(title, style: smallTileGray),
              content: Column(
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
              actions: [
                Row(
                  children: [
                    FlatButton(
                        onPressed: () {},
                        child: Text("Envoyer", style: buttonStyleBlack)),
                  ],
                ),
              ],
            );
          });
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: smallTileGray),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.black45,
            size: 14,
          ),
        ],
      ),
    ),
  );
}

InkWell buildAccountOptionRow(BuildContext context, String title) {
  return InkWell(
    borderRadius: BorderRadius.circular(5.0),
    onTap: () {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomAlertDialog(
              title: Text(title, style: smallTileGray),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [],
              ),
              actions: [
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
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: smallTileGray,
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.black45,
            size: 14,
          ),
        ],
      ),
    ),
  );
}
