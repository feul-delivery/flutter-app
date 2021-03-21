import 'package:FD_flutter/pages/livreur/bbar_liv.dart';
import 'package:FD_flutter/pages/livreur/index_lv.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:flutter/material.dart';

class SettingsLiv extends StatefulWidget {
  SettingsLiv({Key key}) : super(key: key);

  @override
  _SettingsLivState createState() => _SettingsLivState();
}

class _SettingsLivState extends State<SettingsLiv> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Settings",
            style: pageTitle,
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  ButtomBarLiv.selectedIndex = 0;
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => IndexLv()));
                })
          ],
          centerTitle: true,
          backgroundColor: Colors.red[900],
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
                    color: Colors.red[900],
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
                    color: Colors.red[900],
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
                    color: Colors.red[900],
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Droits",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
            return AlertDialog(
              title: Text(title),
              content: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
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
                            style: TextStyle(color: Colors.red[900]))),
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancel",
                            style: TextStyle(color: Colors.red[900]))),
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
            color: Colors.grey[100],
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
            return AlertDialog(
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
                            image: AssetImage('assets/Fueldelivery.png'))),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Build by the Flutter framework.',
                    style: TextStyle(fontSize: 10),
                  ),
                  Text(
                    'Developped by:',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '',
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    '',
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
                      "Fermer",
                      style: TextStyle(color: Colors.red[900]),
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
            return AlertDialog(
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
                        child: Text("Annuler",
                            style: TextStyle(color: Colors.red[900]))),
                    FlatButton(
                        onPressed: () {},
                        child: Text("Envoyer",
                            style: TextStyle(color: Colors.red[900]))),
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
            return AlertDialog(
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
                    child: Text("Fermer")),
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
