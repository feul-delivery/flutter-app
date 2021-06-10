import 'dart:io';
import 'package:FD_flutter/modules/livreur.dart';
import 'package:FD_flutter/modules/user.dart';
import 'package:FD_flutter/pages/livreur/bbar_liv.dart';
import 'package:FD_flutter/pages/livreur/drawer_liv.dart';
import 'package:FD_flutter/shared/custom_alert_dialog.dart';
import 'package:FD_flutter/shared/lang.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'widgets/commande_widget.dart';

class IndexLv extends StatefulWidget {
  static Livreur livreur;
  IndexLv({Key key});

  @override
  _IndexLvState createState() => _IndexLvState();
}

class _IndexLvState extends State<IndexLv> {
  get child => null;
  var statut = 'N/A';
  bool showStatut = false;
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
        });
      }
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.menu, color: buttonColor),
              onPressed: () => _scaffoldKey.currentState.openDrawer(),
            ),
            title: Text('${Language.mapLang['home']}', style: pageTitleO),
            backgroundColor: Colors.white,
            elevation: 0.5,
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                  icon: Icon(showStatut ? Icons.unfold_less : Icons.unfold_more,
                      color: buttonColor),
                  onPressed: () {
                    setState(() {
                      showStatut = !showStatut;
                    });
                  })
            ],
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              margin: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
              child: Column(children: <Widget>[
                showStatut
                    ? Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text('Statut: ',
                                    style: TextStyle(fontSize: 18)),
                                Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                        color: statut == 'inactif'
                                            ? Colors.red
                                            : Colors.green,
                                        borderRadius:
                                            BorderRadius.circular(50)))
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: buttonColor,
                                  borderRadius: BorderRadius.circular(50)),
                              child: IconButton(
                                  icon: Icon(Icons.sync_outlined,
                                      color: Colors.white),
                                  onPressed: () async {
                                    final FirebaseAuth auth =
                                        FirebaseAuth.instance;
                                    final FirebaseUser user =
                                        await auth.currentUser();
                                    if (statut == 'actif') {
                                      await Firestore.instance
                                          .collection('livreur')
                                          .document(user.uid)
                                          .updateData({
                                        'statut': 'inactif',
                                      });
                                      statut = 'inactif';
                                    } else if (statut == 'inactif') {
                                      await Firestore.instance
                                          .collection('livreur')
                                          .document(user.uid)
                                          .updateData({
                                        'statut': 'actif',
                                      });
                                      statut = 'actif';
                                    }

                                    setState(() {});
                                  }),
                            )
                          ],
                        ),
                      )
                    : SizedBox.shrink(),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('Disponible commandes:', style: tileTitleStyle),
                ),
                Divider(
                  height: 5,
                  thickness: 1,
                  color: buttonColor,
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance
                        .collection('orders')
                        .where('uidstation',
                            isEqualTo: IndexLv.livreur.uidentreprise)
                        .where('statut', isEqualTo: 'waiting')
                        .orderBy('dateheurec', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Icon(Icons.cancel, color: Colors.black);
                      }
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return SizedBox(
                              child: Center(child: customeCircularProgress));
                        case ConnectionState.none:
                          return Icon(Icons.error_outline, color: Colors.black);

                        default:
                          for (int i = 0; i < items.length; i++)
                            return CommandeWidget(commande: items[i]);
                      }
                    })
              ]),
            ),
          ),
          drawer: DrawerLiv(),
          bottomNavigationBar: ButtomBarLiv(),
        ));
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
