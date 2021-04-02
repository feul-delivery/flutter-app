import 'dart:io';
import 'package:FD_flutter/modules/livreur.dart';
import 'package:FD_flutter/pages/livreur/bbar_liv.dart';
import 'package:FD_flutter/pages/livreur/drawer_liv.dart';
import 'package:FD_flutter/shared/custom_alert_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:FD_flutter/shared/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//import '../../wrapper.dart';

class IndexLv extends StatefulWidget {
  static Livreur livreur;
  IndexLv({Key key}) : super(key: key);

  @override
  _IndexLvState createState() => _IndexLvState();
}

class _IndexLvState extends State<IndexLv> {
  get child => null;
  var statut = 'N/A';
  Color cl;
  @override
  void initState() {
    super.initState();
    getStatut();
  }

  getStatut() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    await Firestore.instance
        .collection('livreur')
        .document(user.uid)
        ?.get()
        ?.then((value) async {
      if (value.exists) {
        var key1 = await value.data['statut'];
        setState(() {
          statut = key1;
          if (value.data['statut'] == 'actif') {
            cl = Colors.green;
            print('hoo');
          } else {
            print('haa');
            cl = Colors.red;
          }
          print(statut);
        });
      }
    });
  }

  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return showDialog(
                context: context,
                builder: (context) => new CustomAlertDialog(
                  title: new Text('Are you sure?'),
                  content: new Text("Exit the application"),
                  actions: <Widget>[
                    Row(children: [
                      new FlatButton(
                        onPressed: () => exit(0),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 0.0, bottom: 0.0, top: 10),
                          child: Text(
                            'Yes',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      new FlatButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 0.0, bottom: 0.0, top: 10),
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ]),
                  ],
                ),
              ) ??
              false;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text("Home"),
            backgroundColor: Colors.black,
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    setState(() {});
                  })
            ],
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              margin: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text('vous statut : ',
                              style: TextStyle(fontSize: 18)),
                          Text(statut,
                              style: TextStyle(color: cl, fontSize: 22)),
                        ],
                      ),
                      IconButton(
                          icon: Icon(Icons.sync_outlined),
                          onPressed: () async {
                            final FirebaseAuth auth = FirebaseAuth.instance;
                            final FirebaseUser user = await auth.currentUser();
                            if (statut == 'actif') {
                              await Firestore.instance
                                  .collection('livreur')
                                  .document(user.uid)
                                  .updateData({
                                'statut': 'inactif',
                              });
                              statut = 'inactif';
                              cl= Colors.red;
                            } else if (statut == 'inactif') {
                              await Firestore.instance
                                  .collection('livreur')
                                  .document(user.uid)
                                  .updateData({
                                'statut': 'actif',
                              });
                              statut = 'actif';
                              cl= Colors.green;

                            }

                            setState(() {});
                          })
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Disponible commandes:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    height: 5,
                    thickness: 1,
                  ),
                  for (int i = 0; i < items.length; i++) commandeEnLine(i),
                ],
              ),
            ),
          ),
          drawer: DrawerLiv(),
          bottomNavigationBar: ButtomBarLiv(),
        ));
  }

  Container commandeEnLine(int i) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            decoration: new BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 20,
                      offset: Offset(0, 10))
                ]),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(items[i]['nom'],
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15))),
                        ),
                        Container(
                            height: 25,
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black,
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text('Volume:',
                                      style:
                                          TextStyle(color: Colors.grey[800])),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  child: Text(items[i]['volume'],
                                      style:
                                          TextStyle(color: Colors.grey[600])),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text('Type:',
                                      style:
                                          TextStyle(color: Colors.grey[800])),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  child: Text(items[i]['type'],
                                      style:
                                          TextStyle(color: Colors.grey[600])),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text('Address:',
                                      style:
                                          TextStyle(color: Colors.grey[800])),
                                ),
                                Container(
                                  child: Text(items[i]['adresse'],
                                      style:
                                          TextStyle(color: Colors.grey[600])),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }

  List items = [
    {
      "nom": "Mr Benarafa",
      "volume": "10L",
      "type": "Gas-oil",
      "adresse": "Monfleuri 2, Lycée Technique, Fès",
      "statut": ""
    },
    {
      "nom": "Mr Bennani",
      "volume": "50L",
      "type": "Gas-oil",
      "adresse": "Monfleuri 1, Rue el karama, Fès",
      "statut": ""
    },
    {
      "nom": " Mr Wardi",
      "volume": "43L",
      "type": "Gas-oil",
      "adresse": "Monfleuri 2, Lycée Technique, Fès",
      "statut": "En attend"
    },
    {
      "nom": "Mme Twati",
      "volume": "43L",
      "type": "Gas-oil",
      "statut": "En attend",
      "adresse": "Barid Banque, Bensoda, Fès",
    },
  ];
}
