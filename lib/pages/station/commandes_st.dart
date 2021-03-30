import 'package:FD_flutter/pages/station/cartCommandes.dart';
import 'package:FD_flutter/pages/station/command_st.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:FD_flutter/pages/station/drawer_st.dart';
import 'package:FD_flutter/pages/station/bbar_st.dart';

import 'index_st.dart';

class ToutCommandesSt extends StatefulWidget {
  @override
  _ToutCommandesStState createState() => _ToutCommandesStState();
}

class _ToutCommandesStState extends State<ToutCommandesSt> {
  var uid;
  @override
  void initState() {
    super.initState();
    _getEntID();
  }

  Future _getEntID() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    uid = user.uid;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        ButtomBarSt.selectedIndexSt = 0;
        Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => IndexSt()));
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Orders"),
          backgroundColor: Colors.black,
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.refresh_rounded),
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
                StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection('orders')
                      .where('uidstation', isEqualTo: uid)
                      .where('statut', isEqualTo: 'done')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Icon(Icons.cancel, color: Colors.black);
                    }

                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return SizedBox(
                            child: Center(
                                child: CircularProgressIndicator(
                                    backgroundColor: Colors.black)));
                      case ConnectionState.none:
                        return Icon(Icons.error_outline, color: Colors.black);
                      case ConnectionState.done:
                        return Icon(
                          Icons.done,
                          color: Colors.black,
                        );
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
                                  child: ToutCommandes(document));
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
}
