import 'package:feul_delivery/pages/client/bbar_cl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'index_cl.dart';

class SettingCl extends StatefulWidget {
  SettingCl({Key key}) : super(key: key);

  @override
  _SettingClState createState() => _SettingClState();
}

class _SettingClState extends State<SettingCl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Paramètres",
            style: TextStyle(),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  selectedIndex = 0;
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => Cl()));
                })
          ],
          centerTitle: true,
          backgroundColor: Colors.orange[900],
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
                    color: Colors.orange[900],
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Compte",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Divider(
                height: 15,
                thickness: 2,
              ),
              InkWell(
                  onTap: () {},
                  child: buildChangePasswordRow(
                      context, "Changer le mot de passe")),
              InkWell(
                  onTap: () {},
                  child:
                      buildAccountOptionRow(context, "Supprimer votre compte")),
              Row(
                children: [
                  Icon(
                    Icons.phone_iphone,
                    color: Colors.orange[900],
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
                thickness: 2,
              ),
              InkWell(
                  onTap: () {}, child: buildRateUsRow(context, "Évaluez nous")),
              InkWell(
                  onTap: () {},
                  child: buildAboutUsRow(context, "À propos de nous")),
              Row(
                children: [
                  Icon(
                    Icons.security,
                    color: Colors.orange[900],
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
                thickness: 2,
              ),
              InkWell(
                  onTap: () {},
                  child: buildAccountOptionRow(
                      context, "Confidentialité et sécurité")),
              SizedBox(
                height: 40,
              ),
            ]),
          ),
        ));
  }
}

GestureDetector buildChangePasswordRow(BuildContext context, String title) {
  return GestureDetector(
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
                            hintText: "Ancien mot de passe",
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
                            hintText: "Nouveau mot de passe",
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
                            hintText: "Confirmation:",
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
                            style: TextStyle(color: Colors.orange[900]))),
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Annuler",
                            style: TextStyle(color: Colors.orange[900]))),
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

GestureDetector buildAboutUsRow(BuildContext context, String title) {
  return GestureDetector(
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
                            image: AssetImage('assets/Feuldelivery.png'))),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Construire par le framework Flutter.',
                    style: TextStyle(fontSize: 10),
                  ),
                  Text(
                    'Développé par:',
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
                      "Fermer",
                      style: TextStyle(color: Colors.orange[900]),
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

GestureDetector buildRateUsRow(BuildContext context, String title) {
  return GestureDetector(
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
                            style: TextStyle(color: Colors.orange[900]))),
                    FlatButton(
                        onPressed: () {},
                        child: Text("Envoyer",
                            style: TextStyle(color: Colors.orange[900]))),
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

GestureDetector buildAccountOptionRow(BuildContext context, String title) {
  return GestureDetector(
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
