import 'dart:ui';
import 'package:FD_flutter/pages/client/profile_cl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:FD_flutter/pages/client/station_cl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'explore_cl.dart';

class IndexCl extends StatefulWidget {
  @override
  _IndexClState createState() => _IndexClState();
}

final int _currentIndex = 0;

class _IndexClState extends State<IndexCl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackground,
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              letterSpacing: 1.3),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      bottomNavigationBar: BottomNavigationBar(
          elevation: 1,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          currentIndex: _currentIndex,
          onTap: (value) {
            switch (value) {
              case 0:
                Navigator.of(context).pushReplacement(PageTransition(
                    type: PageTransitionType.leftToRight, child: IndexCl()));

                break;
              case 1:
                Navigator.of(context).pushReplacement(PageTransition(
                    type: PageTransitionType.fade, child: ExploreCl()));
                break;
              case 2:
                Navigator.of(context).pushReplacement(PageTransition(
                    type: PageTransitionType.fade, child: ProfileCl()));

                break;
            }
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(OMIcons.home, color: Colors.blue[700]),
                // ignore: deprecated_member_use
                title: Text('Home', style: TextStyle(color: Colors.blue[700]))),
            BottomNavigationBarItem(
                icon: Icon(OMIcons.explore, color: Color(0xFFB9BAC3)),
                // ignore: deprecated_member_use
                title: Text('Explore',
                    style: TextStyle(color: Color(0xFFB9BAC3)))),
            BottomNavigationBarItem(
                icon: Icon(OMIcons.person, color: Color(0xFFB9BAC3)),
                // ignore: deprecated_member_use
                title: Text('Profile',
                    style: TextStyle(color: Color(0xFFB9BAC3)))),
          ]),
      body: RefreshIndicator(
        onRefresh: () async {
          return await Future.delayed(Duration(seconds: 1)).then((value) {
            setState(() {});
          });
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.blue[500],
                    border: Border(
                        bottom: BorderSide(width: 1, color: Colors.grey[300]))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                      child: Text(
                        'The best of the week'.toUpperCase(),
                        style: pageTitleXW,
                      ),
                    ),
                    Material(
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Stack(
                                children: [
                                  Container(
                                    child: ClipRRect(
                                      child: Image.asset(
                                        'assets/s3.jpg',
                                        alignment: Alignment.center,
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 15,
                                    left: 15,
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          //'${document['titre']}',
                                          Text('Total Maroc',
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontFamily: 'Gotham',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 24,
                                              )),
                                          SizedBox(height: 5),
                                          Text(
                                            // '${document['adresse']}',
                                            'Route sefrou, marjane 30000',
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontFamily: 'Gotham',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(width: 1, color: Colors.grey[300]),
                        top: BorderSide(width: 1, color: Colors.grey[300]),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              'Close to you',
                              style: pageTitleX,
                            ),
                          ),
                          Opacity(
                            opacity: 0.8,
                            child: Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.all(5),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              ExploreCl()));
                                },
                                child: Text(
                                  'View all',
                                  style: moreStyle,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: Firestore.instance
                            .collection('entreprise')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return customErrorWidget;
                          }
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return SizedBox(
                                  child:
                                      Center(child: customeCircularProgress));
                            case ConnectionState.none:
                              return Container(child: customErrorWidget);
                            default:
                              return new ListView(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  children: snapshot.data?.documents
                                      ?.map((DocumentSnapshot document) {
                                    return _createSmallCard(document, context);
                                  })?.toList());
                          }
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _createSmallCard(DocumentSnapshot document, BuildContext context) {
  return Material(
    child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(width: 1, color: Colors.grey[300]),
          )),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StationProfilCl(doc: document)));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                document['photoURL'] != null
                    ? Hero(
                        tag: document.documentID,
                        child: CachedNetworkImage(
                          imageUrl: document['photoURL'],
                          imageBuilder: (context, imageProvider) => Material(
                            child: Ink.image(
                              height: 200,
                              image: imageProvider,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          placeholder: (context, url) => Container(
                            height: 200,
                            child: Center(
                              child: customeCircularProgress,
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            height: 200,
                            child: Center(
                              child: Icon(Icons.error, color: Colors.black),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        height: 200,
                        child: Center(
                          child: Icon(Icons.error, color: Colors.black),
                        ),
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
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            '${document['titre']}'.toUpperCase(),
                            style: buttonStyle,
                          ),
                        ),
                      ],
                    )),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    height: 30,
                    width: 80,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Center(
                          child: Row(children: [
                        Icon(OMIcons.locationOn, color: Colors.blue[700]),
                        Text(
                          "15 Km",
                          style: TextStyle(color: Colors.blue[700]),
                        ),
                      ])),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
