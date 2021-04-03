import 'dart:developer';

import 'package:FD_flutter/modules/user.dart';
import 'package:FD_flutter/pages/client/commandes_cl.dart';
import 'package:FD_flutter/pages/client/settings_cl.dart';
import 'package:FD_flutter/pages/client/station_cl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'bbar_cl.dart';
import 'index_cl.dart';
import 'package:page_transition/page_transition.dart';

// ignore: camel_case_types
class ProfileCl extends StatefulWidget {
  @override
  _ProfileClState createState() => _ProfileClState();
}

List<String> _favList;

class _ProfileClState extends State<ProfileCl> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        ButtomBarCl.selectedIndex = 0;
        Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => IndexCl()));
      },
      child: Scaffold(
          backgroundColor: Color(0xFFEFF0F5),
          appBar: AppBar(
            actions: <Widget>[
              IconButton(
                  icon: Icon(OMIcons.settings, color: Color(0xFF1763B9)),
                  onPressed: () {
                    Navigator.of(context).push(PageTransition(
                        type: PageTransitionType.bottomToTop,
                        child: SettingsCl()));
                  })
            ],
            backgroundColor: Color(0xFFFFFFFF),
            elevation: 0,
          ),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: 2,
              onTap: (value) {
                if (value == 0) {}
              },
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(OMIcons.home),
                    title: Text('Home', style: TextStyle())),
                BottomNavigationBarItem(
                    icon: Icon(OMIcons.explore),
                    title: Text('Explore', style: TextStyle())),
                BottomNavigationBarItem(
                    icon: Icon(OMIcons.person),
                    title: Text('Profile', style: TextStyle())),
              ]),
          body: StreamBuilder<DocumentSnapshot>(
              stream: Firestore.instance
                  .collection('client')
                  .document(Provider.of<User>(context).uid)
                  .get()
                  .asStream(),
              builder: (context, snapshot) {
                _favList = List.from(snapshot.data['favorite']);
                return ListView(children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.5, color: Colors.grey[300]),
                      ),
                      color: Color(0xFFFFFFFF),
                    ),
                    padding: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            snapshot.data['photoURL'] == null
                                ? Container(
                                    width: 70,
                                    height: 70,
                                    child: CircleAvatar(
                                      radius: 35.0,
                                      backgroundImage:
                                          AssetImage('assets/profile.png'),
                                    ),
                                  )
                                : CachedNetworkImage(
                                    imageUrl: snapshot.data['photoURL'],
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      width: 70,
                                      height: 70,
                                      child: CircleAvatar(
                                          radius: 35.0,
                                          backgroundImage: imageProvider),
                                    ),
                                    placeholder: (context, url) => Container(
                                      width: 70,
                                      height: 70,
                                      child: CircleAvatar(
                                          radius: 35.0,
                                          child: CircularProgressIndicator(
                                            backgroundColor: Colors.black,
                                            valueColor:
                                                new AlwaysStoppedAnimation<
                                                    Color>(Colors.white),
                                          )),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      width: 70,
                                      height: 70,
                                      child: CircleAvatar(
                                          radius: 35.0,
                                          child: Icon(Icons.error)),
                                    ),
                                  ),
                            SizedBox(width: 20),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${toBeginningOfSentenceCase(snapshot.data['prenom'])} ${toBeginningOfSentenceCase(snapshot.data['nom'])}',
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  '${snapshot.data['email']}'.toLowerCase(),
                                  style: TextStyle(
                                      color: Color(0xFF71747E),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(OMIcons.phoneIphone, color: Color(0xFF71747E)),
                            SizedBox(width: 5),
                            Center(
                              child: Text(
                                '${snapshot.data['tele']}'.toLowerCase(),
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(OMIcons.accountBox, color: Color(0xFF71747E)),
                            SizedBox(width: 5),
                            Center(
                              child: Text(
                                '${snapshot.data['cin']}'.toLowerCase(),
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(OMIcons.locationOn, color: Color(0xFF71747E)),
                            SizedBox(width: 5),
                            Center(
                              child: Text(
                                '${toBeginningOfSentenceCase(snapshot.data['ville'])}',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 1.5, color: Colors.grey[300]),
                        bottom: BorderSide(width: 1.5, color: Colors.grey[300]),
                      ),
                      color: Color(0xFFFFFFFF),
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        _favList.length != 0
                            ? Padding(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 10, bottom: 0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(OMIcons.starBorder,
                                        color: Color(0xFF53555E), size: 25),
                                    SizedBox(width: 10),
                                    Text(
                                      'Favoris',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                              )
                            : Container(),
                        StreamBuilder<QuerySnapshot>(
                            stream: Firestore.instance
                                .collection('entreprise')
                                .getDocuments()
                                .asStream(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Container(
                                  width: MediaQuery.of(context).size.height *
                                      1 /
                                      5,
                                  child: Center(
                                    child: Icon(
                                      OMIcons.error,
                                      color: Color(0xFF1763B9),
                                    ),
                                  ),
                                );
                              }
                              switch (snapshot.connectionState) {
                                case ConnectionState.none:
                                  return Container(
                                    width: MediaQuery.of(context).size.height *
                                        1 /
                                        5,
                                    child: Center(
                                      child: Icon(
                                        OMIcons.error,
                                        color: Color(0xFF1763B9),
                                      ),
                                    ),
                                  );

                                case ConnectionState.waiting:
                                  return Container(
                                    height: MediaQuery.of(context).size.height *
                                        1 /
                                        5,
                                    width: MediaQuery.of(context).size.width,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                          valueColor:
                                              new AlwaysStoppedAnimation<Color>(
                                                  Color(0xFF1763B9)),
                                          backgroundColor: Colors.transparent),
                                    ),
                                  );
                                default:
                                  return _favList.length != 0
                                      ? Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              1 /
                                              5,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: new ListView(
                                              scrollDirection: Axis.horizontal,
                                              children: snapshot.data?.documents
                                                  ?.map((DocumentSnapshot doc) {
                                                inspect(_favList);
                                                return _favList.contains(
                                                        doc.documentID)
                                                    ? InkWell(
                                                        radius: 50,
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      StationProfilCl(
                                                                          doc:
                                                                              doc)));
                                                        },
                                                        child:
                                                            _createFavCard(doc))
                                                    : Container();
                                              })?.toList()),
                                        )
                                      : Container();
                              }
                            }),
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                            top:
                                BorderSide(width: 1.5, color: Colors.grey[300]),
                          )),
                          child: Column(
                            children: [
                              StreamBuilder<QuerySnapshot>(
                                  stream: Firestore.instance
                                      .collection('orders')
                                      .where('uidclient',
                                          isEqualTo:
                                              Provider.of<User>(context).uid)
                                      .getDocuments()
                                      .asStream(),
                                  builder: (context, snapshotOrders) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            PageTransition(
                                                type: PageTransitionType
                                                    .rightToLeft,
                                                child: CommandeCl(
                                                  querySnapshot: snapshotOrders,
                                                )));
                                      },
                                      child: ListTile(
                                        leading: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1 /
                                              12,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1 /
                                              12,
                                          decoration: BoxDecoration(
                                              color: Color(0xFF41434F),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Center(
                                              child: Icon(OMIcons.list,
                                                  color: Colors.white)),
                                        ),
                                        title: Text(
                                          'Orders',
                                          style: TextStyle(
                                              color: Color(0xFF050505),
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        trailing: Text(
                                          '${snapshotOrders.data.documents.length}'
                                              .toLowerCase(),
                                          style: TextStyle(
                                              color: Color(0xFF71747E),
                                              fontSize: 17,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    );
                                  }),
                              InkWell(
                                onTap: () {},
                                child: ListTile(
                                    leading: Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              1 /
                                              12,
                                      width: MediaQuery.of(context).size.width *
                                          1 /
                                          12,
                                      decoration: BoxDecoration(
                                          color: Color(0xFFF8C513),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Center(
                                          child: Icon(OMIcons.star,
                                              color: Colors.white)),
                                    ),
                                    title: Text(
                                      'Favoris',
                                      style: TextStyle(
                                          color: Color(0xFF050505),
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    trailing: Text(
                                      '${_favList.length}'.toLowerCase(),
                                      style: TextStyle(
                                          color: Color(0xFF71747E),
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400),
                                    )),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ]);
              })),
    );
  }

  Container _createFavCard(DocumentSnapshot document) {
    return Container(
      width: MediaQuery.of(context).size.width - 80,
      margin: EdgeInsets.only(left: 15, top: 15, bottom: 15),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(width: 1.5, color: Colors.grey[300]),
          right: BorderSide(width: 1.5, color: Colors.grey[300]),
          top: BorderSide(width: 1.5, color: Colors.grey[300]),
          bottom: BorderSide(width: 1.5, color: Colors.grey[300]),
        ),
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${document.data['titre']}'.toUpperCase(),
            style: TextStyle(
                color: Color(0xFF050505),
                fontSize: 17,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
