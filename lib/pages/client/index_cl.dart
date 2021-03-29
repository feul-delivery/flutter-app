import 'dart:io';
import 'package:FD_flutter/modules/client.dart';
import 'package:FD_flutter/pages/client/favoris_cl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:FD_flutter/pages/client/station_cl.dart';
import 'package:FD_flutter/pages/client/drawer_cl.dart';
import 'bbar_cl.dart';
import 'explore_cl.dart';

class IndexCl extends StatefulWidget {
  static Client client;
  @override
  _IndexClState createState() => _IndexClState();
}

class _IndexClState extends State<IndexCl> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return showDialog(
              context: context,
              builder: (context) => new AlertDialog(
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
          title: Text(
            "Home",
            style: pageTitle,
          ),
          backgroundColor: Colors.black,
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.favorite),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => FavorisCl()));
                })
          ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            margin: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
            child: Column(
              children: <Widget>[
                _bigStation(context),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Close to you',
                            style: subTitleStyle,
                          ),
                          Opacity(
                            opacity: 0.6,
                            child: GestureDetector(
                              onTap: () {
                                ButtomBarCl.selectedIndex = 1;
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ExploreCl()));
                              },
                              child: Text(
                                'View all',
                                style: moreStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 1,
                        height: 10,
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: Firestore.instance
                            .collection('entreprise')
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
                              return Icon(Icons.error_outline,
                                  color: Colors.black);
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
                                                      StationProfilCl(
                                                          doc: document)));
                                        },
                                        child: _createSmallCard(document));
                                  })?.toList());
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: ButtomBarCl(),
        drawer: DrawerCL(),
      ),
    );
  }
}

GestureDetector _bigStation(BuildContext context) {
  return GestureDetector(
    onTap: () {
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => StationProfilCl()));
    },
    child: Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'The best of the week',
                style: subTitleStyle,
              ),
            ],
          ),
          Divider(
            height: 10,
            thickness: 1,
          ),
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image.asset(
                'assets/s3.jpg',
                alignment: Alignment.center,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width - 150,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Container _createSmallCard(DocumentSnapshot document) {
  return Container(
    height: 220,
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Ink.image(
                      height: 100,
                      image: AssetImage(
                        'assets/s4.png',
                      ),
                      fit: BoxFit.fitWidth,
                    ),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      top: 10,
                      right: 10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {},
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '${document['titre']}',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${document['adresse']}',
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ]),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FlatButton.icon(
                              onPressed: () {},
                              icon: Icon(
                                Icons.near_me,
                                color: Colors.blue[800],
                              ),
                              label: Text(
                                'Order',
                                style: TextStyle(color: Colors.blue[800]),
                              ),
                            ),
                            FlatButton.icon(
                              onPressed: () {},
                              icon: Icon(
                                Icons.read_more,
                              ),
                              label: Text(
                                'Details',
                              ),
                            ),
                            Container(
                              height: 25,
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5.0),
                                child: Center(
                                    child: Row(children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "15 Km",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ])),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
