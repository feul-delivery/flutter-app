import 'dart:io';
import 'package:FD_flutter/modules/livreur.dart';
import 'package:FD_flutter/pages/livreur/bbar_liv.dart';
import 'package:FD_flutter/pages/livreur/commande_details.dart';
import 'package:FD_flutter/pages/livreur/drawer_liv.dart';
import 'package:FD_flutter/shared/custom_alert_dialog.dart';
import 'package:FD_flutter/shared/lang.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../modules/user.dart';
import 'commande_widget.dart';

class IndexLv extends StatefulWidget {
  static Livreur livreur;

  @override
  _IndexLvState createState() => _IndexLvState();
}

class _IndexLvState extends State<IndexLv> {
  get child => null;
  String statut;
  bool showStatut = false;
  @override
  void initState() {
    super.initState();
  }

  bool havingCommande = false;
  DocumentSnapshot currentCommande;

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
        child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection('orders')
                .where('uidlivreur', isEqualTo: Provider.of<User>(context).uid)
                .where('statut', isEqualTo: 'waiting')
                .snapshots(),
            builder: (context, commandes) {
              if (commandes.hasError) {
                return Icon(Icons.cancel, color: Colors.black);
              }
              switch (commandes.connectionState) {
                case ConnectionState.waiting:
                  return SizedBox(
                      child: Material(
                          child: Center(
                    child: Shimmer.fromColors(
                      baseColor: buttonColor.withOpacity(0.5),
                      highlightColor: Colors.white,
                      child: Text(
                        'chargement..',
                        style: pageTitleO,
                      ),
                    ),
                  )));
                case ConnectionState.none:
                  return Icon(Icons.error_outline, color: Colors.black);

                default:
                  if (commandes.data.documents.length != 0) {
                    havingCommande = true;
                    currentCommande = commandes.data.documents.first;
                  }
                  return Scaffold(
                    key: _scaffoldKey,
                    backgroundColor: Colors.white,
                    appBar: AppBar(
                      leading: IconButton(
                        icon: Icon(Icons.menu, color: buttonColor),
                        onPressed: () => _scaffoldKey.currentState.openDrawer(),
                      ),
                      title: Text('${Language.mapLang['home']}',
                          style: pageTitleO),
                      backgroundColor: Colors.white,
                      elevation: showStatut ? 0 : 1,
                      centerTitle: true,
                      actions: <Widget>[
                        IconButton(
                            icon: Icon(
                                showStatut
                                    ? Icons.close_fullscreen_rounded
                                    : Icons.open_in_full_rounded,
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
                        margin:
                            const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                        child: Column(children: <Widget>[
                          showStatut
                              ? StreamBuilder<DocumentSnapshot>(
                                  stream: Firestore.instance
                                      .collection('livreur')
                                      .document(Provider.of<User>(context).uid)
                                      .snapshots(),
                                  builder: (context, livreurDoc) {
                                    if (livreurDoc.hasError) {
                                      return Icon(Icons.cancel,
                                          color: Colors.black);
                                    }
                                    switch (livreurDoc.connectionState) {
                                      case ConnectionState.waiting:
                                        return SizedBox(
                                            child: Center(
                                                child: Text(
                                          'chargement...',
                                          style: hintStyle,
                                        )));
                                      case ConnectionState.none:
                                        return Icon(Icons.error_outline,
                                            color: Colors.black);

                                      default:
                                        return Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 7),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text('Statut: ',
                                                      style: TextStyle(
                                                          fontSize: 18)),
                                                  Container(
                                                      width: 10,
                                                      height: 10,
                                                      decoration: BoxDecoration(
                                                          color: livreurDoc
                                                                          .data[
                                                                      'statut'] ==
                                                                  'inactif'
                                                              ? Colors.red
                                                              : Colors.green,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50)))
                                                ],
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white70,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                                child: IconButton(
                                                    icon: Icon(
                                                        Icons.sync_outlined,
                                                        color: buttonColor),
                                                    onPressed: () async {
                                                      final FirebaseAuth auth =
                                                          FirebaseAuth.instance;
                                                      final FirebaseUser user =
                                                          await auth
                                                              .currentUser();
                                                      if (livreurDoc
                                                              .data['statut'] ==
                                                          'actif') {
                                                        await Firestore.instance
                                                            .collection(
                                                                'livreur')
                                                            .document(user.uid)
                                                            .updateData({
                                                          'statut': 'inactif',
                                                        });
                                                      } else if (livreurDoc
                                                              .data['statut'] ==
                                                          'inactif') {
                                                        await Firestore.instance
                                                            .collection(
                                                                'livreur')
                                                            .document(user.uid)
                                                            .updateData({
                                                          'statut': 'actif',
                                                        });
                                                      }
                                                    }),
                                              )
                                            ],
                                          ),
                                        );
                                    }
                                  })
                              : SizedBox.shrink(),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text('Commandes disponibles:',
                                style: tileTitleStyle),
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
                                      isEqualTo:
                                          IndexLv?.livreur?.uidentreprise)
                                  .where('uidlivreur', isEqualTo: null)
                                  .where('statut', isEqualTo: 'waiting')
                                  .orderBy('dateheurec', descending: true)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Icon(Icons.cancel,
                                      color: Colors.black);
                                }
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                    return SizedBox(
                                        child: Center(
                                            child: customeCircularProgress));
                                  case ConnectionState.none:
                                    return Icon(Icons.error_outline,
                                        color: Colors.black);

                                  default:
                                    return Column(children: [
                                      for (DocumentSnapshot document
                                          in snapshot.data.documents)
                                        if (document.documentID !=
                                            currentCommande?.documentID)
                                          CommandeWidget(
                                            commande: document,
                                            scaffoldKey: _scaffoldKey,
                                            havingCommande: havingCommande,
                                          )
                                    ]);
                                }
                              })
                        ]),
                      ),
                    ),
                    drawer: DrawerLiv(),
                    bottomNavigationBar: ButtomBarLiv(),
                    floatingActionButton: havingCommande
                        ? FloatingActionButton.extended(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    CommandeDetailLv(currentCommande, true),
                              ));
                            },
                            label: Text('livrez..',
                                style: pageTitleW.copyWith(fontSize: 14)),
                            icon: CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.white),
                                backgroundColor: buttonColor),
                            backgroundColor: buttonColor,
                            elevation: 0,
                          )
                        : SizedBox.shrink(),
                  );
              }
            }));
  }

  void showInSnackBar(String value) {
    SnackBar snackBar = new SnackBar(
        backgroundColor: scaffoldBackground,
        content:
            new Text(value, style: textStyle.copyWith(color: Colors.white)));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
