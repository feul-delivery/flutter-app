import 'package:FD_flutter/shared/custom_alert_dialog.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsSt extends StatefulWidget {
  SettingsSt({Key key}) : super(key: key);

  @override
  _SettingsStState createState() => _SettingsStState();
}

class _SettingsStState extends State<SettingsSt> {
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
          padding: EdgeInsets.only(left: 15, top: 25, right: 15),
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                    "Rights",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Divider(
                height: 15,
                thickness: 1,
              ),
              buildAccountOptionRow(context, " Privacy and Security"),
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
              title: Text(title),
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
                            hintStyle: TextStyle(color: Colors.grey),
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
                            hintStyle: TextStyle(color: Colors.grey),
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
                            hintStyle: TextStyle(color: Colors.grey),
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
                        child: Text("Change",
                            style: TextStyle(color: Colors.black))),
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancel",
                            style: TextStyle(color: Colors.black))),
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
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
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
              title: Text(title),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 10))
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/Feuldelivery.png'))),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Build With Love by the Flutter framework.',
                    style: TextStyle(fontSize: 10),
                  ),
                  Text(
                    'Developped by',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'ELHESSBI Imad',
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    'ZAMOURI Iliyass',
                    style: TextStyle(fontSize: 15),
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
                      style: TextStyle(color: Colors.black),
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
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
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
              title: Text(title),
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
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancel",
                            style: TextStyle(color: Colors.black))),
                    FlatButton(
                        onPressed: () {},
                        child: Text("Send",
                            style: TextStyle(color: Colors.black))),
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
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
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
              title: Text(title),
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
                      style: TextStyle(color: Colors.black),
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
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
          ),
        ],
      ),
    ),
  );
}
