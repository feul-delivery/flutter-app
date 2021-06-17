import 'package:FD_flutter/pages/livreur/bbar_liv.dart';
import 'package:FD_flutter/pages/livreur/index_lv.dart';
import 'package:FD_flutter/shared/custom_alert_dialog.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:flutter/material.dart';

class SettingsLiv extends StatefulWidget {
  @override
  _SettingsLivState createState() => _SettingsLivState();
}

class _SettingsLivState extends State<SettingsLiv> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.west, color: buttonColor),
              onPressed: () => Navigator.of(context).pop()),
          title: Text(
            "Paramètres",
            style: pageTitleO,
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.home, color: buttonColor),
                onPressed: () {
                  ButtomBarLiv.selectedIndex = 0;
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => IndexLv()));
                })
          ],
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.5,
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
                    color: buttonColor,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Compte",
                    style: subTitleStyle,
                  ),
                ],
              ),
              Divider(
                height: 15,
                thickness: 1,
              ),
              buildChangerPasswordRow(context, " Changer Mot de passe"),
              buildAccountOptionRow(context, " Supprimer votre compte"),
              Row(
                children: [
                  Icon(
                    Icons.phone_iphone,
                    color: buttonColor,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Application",
                    style: subTitleStyle,
                  ),
                ],
              ),
              Divider(
                height: 15,
                thickness: 1,
              ),
              buildRateUsRow(context, " Évaluez nous"),
              buildAboutUsRow(context, " À propos de nous"),
              Row(
                children: [
                  Icon(
                    Icons.security,
                    color: buttonColor,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Droits",
                    style: subTitleStyle,
                  ),
                ],
              ),
              Divider(
                height: 15,
                thickness: 1,
              ),
              buildAccountOptionRow(context, " Confidentialité et sécurité"),
              SizedBox(
                height: 40,
              ),
            ]),
          ),
        ));
  }
}

InkWell buildChangerPasswordRow(BuildContext context, String title) {
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
                            hintText: "ancien mot de passe",
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
                            hintText: "nouveau mot de passe",
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
                        child: Text("Changer",
                            style: TextStyle(color: buttonColor))),
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Annuler",
                            style: TextStyle(color: buttonColor))),
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
            color: Colors.grey[500],
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
                              color: buttonColor.withOpacity(0.1),
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
                      style: TextStyle(color: buttonColor),
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
                        child: Text("Annuler",
                            style: TextStyle(color: buttonColor))),
                    FlatButton(
                        onPressed: () {},
                        child: Text("Envoyer",
                            style: TextStyle(color: buttonColor))),
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
