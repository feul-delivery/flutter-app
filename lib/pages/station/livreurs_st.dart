import 'package:FD_flutter/pages/station/add_livreur.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:FD_flutter/pages/station/drawer_st.dart';
import 'package:FD_flutter/pages/station/bbar_st.dart';

import 'index_st.dart';

class LivreurSt extends StatefulWidget {
  @override
  _LivreurStState createState() => _LivreurStState();
}

class _LivreurStState extends State<LivreurSt> {
  var uid;

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
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => AddLivreur()));
              },
              icon: Icon(Icons.group_add),
            )
          ],
          title: Text(
            "Livreurs",
            style: pageTitle,
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          elevation: 1,
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            margin: const EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 0.0),
            child: Column(
              children: <Widget>[
                StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection('livreur')
                      .where('uidentreprise', isEqualTo: uid)
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
                                  onTap: () {}, child: livreurList(document));
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

  Container livreurList(DocumentSnapshot document) {
    DateTime date = DateTime.parse(document['dateajoute']);
    Color col;
    if (document['statut'] == 'actif') {
      col = Colors.green;
    } else {
      col = Colors.red;
    }
    print(date);
    return Container(
      decoration: new BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 20,
                offset: Offset(0, 10))
          ]),
      margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                height: MediaQuery.of(context).size.width / 5,
                width: MediaQuery.of(context).size.width / 5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: document['photoURL'] == ""
                      ? CircleAvatar(
                          radius: 50.0,
                          backgroundImage: AssetImage('assets/profile.png'),
                        )
                      : CachedNetworkImage(
                          imageUrl: document['photoURL'],
                          imageBuilder: (context, imageProvider) =>
                              CircleAvatar(
                                  radius: 30.0, backgroundImage: imageProvider),
                          placeholder: (context, url) => CircleAvatar(
                              radius: 30.0, child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => CircleAvatar(
                              radius: 30.0, child: Icon(Icons.error)),
                        ),
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 25,
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                        child: Center(
                            child: Text(
                          'Since: ${date.day}/${date.month}/${date.year}',
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(document['nom'] + ' ' + document['prenom'],
                          style: TextStyle(color: Colors.black, fontSize: 15))),
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text('CIN: ',
                                      style:
                                          TextStyle(color: Colors.grey[800])),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Container(
                                  child: Text(document['cin'],
                                      style:
                                          TextStyle(color: Colors.grey[600])),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Text('Phone:',
                                  style: TextStyle(color: Colors.grey[800])),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              child: Text(document['tele'],
                                  style: TextStyle(color: Colors.grey[600])),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text('Status:',
                                  style: TextStyle(color: Colors.grey[800])),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              child: Text(document['statut'],
                                  style: TextStyle(color: col)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
