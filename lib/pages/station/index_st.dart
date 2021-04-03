import 'dart:io';
import 'package:FD_flutter/modules/entreprise.dart';
import 'package:FD_flutter/modules/user.dart';
import 'package:FD_flutter/pages/station/cartCommandes.dart';
import 'package:FD_flutter/pages/station/command_st.dart';
import 'package:FD_flutter/shared/custom_alert_dialog.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:FD_flutter/wrapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:FD_flutter/pages/station/drawer_st.dart';
import 'package:FD_flutter/pages/station/bbar_st.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class IndexSt extends StatefulWidget {
  static Entreprise entreprise;
  @override
  _IndexStState createState() => _IndexStState();
}

class _IndexStState extends State<IndexSt> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return showDialog(
              context: context,
              builder: (context) => new CustomAlertDialog(
                title: new Text('Are you sure?'),
                content: new Text("Exit the application"),
                actions: <Widget>[
                  new GestureDetector(
                    onTap: () => exit(0),
                    child: Text(
                      'Yes',
                      style: buttonStyle,
                    ),
                  ),
                  SizedBox(height: 16),
                  new GestureDetector(
                    onTap: () => Navigator.of(context).pop(false),
                    child: Container(
                        child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        'Cancel',
                        style: hintStyle,
                      ),
                    )),
                  ),
                ],
              ),
            ) ??
            false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Home", style: pageTitle),
          backgroundColor: Colors.black,
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pushReplacement(PageTransition(
                        type: PageTransitionType.fade, child: Wrapper()));
                  });
                })
          ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            margin: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Orders',
                        style: subTitleStyle,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.green,
                        ),
                        child: Text(
                          'Live',
                          style: moreStyleWhite,
                        ),
                      )
                    ]),
                Divider(
                  height: 5,
                  thickness: 1,
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection('orders')
                      .where('uidstation',
                          isEqualTo: Provider.of<User>(context).uid)
                      .where('statut', isEqualTo: 'waiting')
                      .orderBy('dateheurec', descending: true)
                      .getDocuments()
                      .asStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Icon(Icons.cancel, color: Colors.black);
                    }
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return SizedBox(
                            child: Center(
                                child: CircularProgressIndicator(
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            Colors.white),
                                    backgroundColor: Colors.black)));
                      case ConnectionState.none:
                        return Icon(Icons.error_outline, color: Colors.black);
                      default:
                        return new ListView(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            children: snapshot.data?.documents
                                ?.map((DocumentSnapshot document) {
                              return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CommandeDetailSt(document)));
                                  },
                                  child: ToutCommandes(document, 'index'));
                            })?.toList());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        drawer: DrawerSt(),
        bottomNavigationBar: ButtomBarSt(),
      ),
    );
  }

  Container commandeEnDirect(int i) {
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
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 5.0, right: 5.0),
                            child: Center(
                                child: Text(
                              items[i]['time'],
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ),
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
                ),
              )),
        ],
      ),
    );
  }

  List items = [
    {
      "nom": "Da7mad ELMAKKAWI",
      "time": "17:47",
      "etat": "en cour",
      "volume": "10L",
      "type": "Gas-oil",
      "adresse": "Monfleuri 2, Lycée Technique, Fès",
      "statut": "En attend"
    },
    {
      "nom": "Da7mad ELMAKKAWI",
      "time": "17:05",
      "etat": "en cour",
      "volume": "50L",
      "type": "Gas-oil",
      "adresse": "Monfleuri 2, Lycée Technique, Fès",
      "statut": "En attend"
    },
    {
      "nom": "Da7mad ELMAKKAWI",
      "time": "17:01",
      "etat": "en cour",
      "volume": "43L",
      "type": "Gas-oil",
      "adresse": "Monfleuri 2, Lycée Technique, Fès",
      "statut": "En attend"
    },
    {
      "nom": "Da7mad ELMAKKAWI",
      "time": "16:50",
      "etat": "en cour",
      "volume": "43L",
      "type": "Gas-oil",
      "statut": "En attend",
      "adresse": "Monfleuri 2, Lycée Technique, Fès",
    }
  ];
}
