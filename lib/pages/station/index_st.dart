import 'dart:io';
import 'package:FD_flutter/modules/entreprise.dart';
import 'package:FD_flutter/modules/user.dart';
import 'package:FD_flutter/pages/station/cartCommandes.dart';
import 'package:FD_flutter/pages/station/command_st.dart';
import 'package:FD_flutter/shared/custom_alert_dialog.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:FD_flutter/wrapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
                      style: buttonStyleBlack,
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
                        style: buttonStyleBlack,
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
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            return await Future.delayed(Duration(seconds: 2)).then((val) {
              setState(() {
                Navigator.of(context).pushReplacement(PageTransition(
                    type: PageTransitionType.fade, child: Wrapper()));
              });
            });
          },
          child: SingleChildScrollView(
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
        ),
        drawer: DrawerSt(),
        bottomNavigationBar: ButtomBarSt(),
      ),
    );
  }
}
