import 'dart:developer';
import 'package:FD_flutter/modules/user.dart';
import 'package:FD_flutter/pages/client/commandes_cl.dart';
import 'package:FD_flutter/pages/client/favoris_cl.dart';
import 'package:FD_flutter/pages/client/settings_cl.dart';
import 'package:FD_flutter/pages/client/station_cl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:FD_flutter/shared/lang.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

// ignore: camel_case_types
class ProfileCl extends StatefulWidget {
  @override
  _ProfileClState createState() => _ProfileClState();
}

List<String> _favList;
QuerySnapshot _snapshotFavoris;

class _ProfileClState extends State<ProfileCl> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(Duration(seconds: 1)).then((value) {
          setState(() {});
        });
      },
      child: Scaffold(
          backgroundColor: darkGray,
          // appBar: AppBar(
          //   actions: <Widget>[
          //     IconButton(
          //         icon: Icon(AntDesign.setting, color: buttonColor),
          //         onPressed: () {
          //           Navigator.of(context).push(PageTransition(
          //               type: PageTransitionType.bottomToTop,
          //               child: SettingsCl()));
          //         })
          //   ],
          //   backgroundColor: Color(0xFFe5e5e5),
          //   elevation: 0,
          // ),
          body: StreamBuilder<DocumentSnapshot>(
              stream: Firestore.instance
                  .collection('client')
                  .document(Provider.of<User>(context).uid)
                  .snapshots(),
              builder: (context, snapshotClient) {
                if (snapshotClient.hasError) {
                  return Container(
                    width: MediaQuery.of(context).size.height * 1 / 5,
                    child: Center(
                      child: Icon(
                        OMIcons.error,
                        color: Color(0xFF1763B9),
                      ),
                    ),
                  );
                }
                switch (snapshotClient.connectionState) {
                  case ConnectionState.none:
                    return Container(
                      color: darkGray,
                      child: Center(
                        child: Icon(OMIcons.error, color: Colors.white54),
                      ),
                    );

                  case ConnectionState.waiting:
                    return Container(
                      color: darkGray,
                      child: Center(
                        child: customeCircularProgress,
                      ),
                    );

                  default:
                    _favList = List.from(snapshotClient.data['favorite']);
                    return ListView(shrinkWrap: true, children: [
                      Container(
                        decoration: BoxDecoration(
                          color: scaffoldBackground,
                          border: Border(
                            bottom:
                                BorderSide(width: 1, color: Colors.grey[500]),
                          ),
                        ),
                        padding: EdgeInsets.only(left: 20, bottom: 20),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.centerRight,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                    borderRadius: BorderRadius.circular(50),
                                    onTap: () {
                                      Navigator.of(context).push(PageTransition(
                                          type: PageTransitionType.bottomToTop,
                                          child: SettingsCl()));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Icon(AntDesign.setting,
                                          color: buttonColor),
                                    )),
                              ),
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                CachedNetworkImage(
                                  imageUrl:
                                      snapshotClient?.data['photoURL'] == null
                                          ? ''
                                          : snapshotClient?.data['photoURL'],
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
                                    child: Center(
                                        child: CircleAvatar(
                                            radius: 35.0,
                                            child: customeCircularProgress)),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    width: 70,
                                    height: 70,
                                    child: Center(
                                        child: CircleAvatar(
                                            radius: 35.0,
                                            backgroundColor: darkGray,
                                            child: Container(
                                              margin: EdgeInsets.only(top: 5),
                                              child: Text(
                                                  '${snapshotClient.data['prenom']}'
                                                          .substring(0, 1)
                                                          .toUpperCase() +
                                                      '${snapshotClient.data['nom']}'
                                                          .substring(0, 1)
                                                          .toUpperCase(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 35,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily: 'Quarion')),
                                            ))),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${toBeginningOfSentenceCase(snapshotClient.data['prenom'])} ${toBeginningOfSentenceCase(snapshotClient.data['nom'])}',
                                      style: titleStyleNew,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      '${snapshotClient.data['email']}'
                                          .toLowerCase(),
                                      style: TextStyle(
                                          color: Color(0xFF71747E),
                                          fontSize: 15,
                                          fontFamily: 'Quarion',
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
                                Icon(OMIcons.phone,
                                    color: Color(0xFFB9BAC3), size: 20),
                                SizedBox(width: 5),
                                Container(
                                  padding: EdgeInsets.only(top: 2),
                                  child: Text(
                                      '+212${snapshotClient.data['tele']}'
                                          .toLowerCase(),
                                      style: smallTileP),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(OMIcons.accountBox,
                                    color: Color(0xFFB9BAC3), size: 20),
                                SizedBox(width: 5),
                                Center(
                                    child: Text(
                                        '${snapshotClient.data['cin']}'
                                            .toUpperCase(),
                                        style: smallTileP)),
                              ],
                            ),
                            SizedBox(height: 15),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(OMIcons.locationOn,
                                    color: Color(0xFFB9BAC3), size: 20),
                                SizedBox(width: 5),
                                Center(
                                  child: Text(
                                      '${toBeginningOfSentenceCase(snapshotClient.data['ville'])}',
                                      style: smallTileP),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        decoration: BoxDecoration(
                          color: scaffoldBackground,
                          border: Border(
                            top: BorderSide(width: 1, color: Colors.grey[500]),
                            bottom:
                                BorderSide(width: 1, color: Colors.grey[500]),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            _favList.length != 0
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 10,
                                        bottom: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(OMIcons.starBorder,
                                            color: Color(0xFF53555E), size: 25),
                                        SizedBox(width: 10),
                                        Container(
                                          margin: EdgeInsets.only(top: 2.0),
                                          child: Text(
                                            '${Language.mapLang['favorite']}',
                                            textAlign: TextAlign.left,
                                            style: pageTitleW,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : Container(),
                            StreamBuilder<QuerySnapshot>(
                                stream: Firestore.instance
                                    .collection('entreprise')
                                    .snapshots(),
                                builder: (context, snapshotFavoris) {
                                  if (snapshotFavoris.hasError) {
                                    return Container(
                                      width:
                                          MediaQuery.of(context).size.height *
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
                                  switch (snapshotFavoris.connectionState) {
                                    case ConnectionState.none:
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.height *
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
                                        height:
                                            MediaQuery.of(context).size.height *
                                                1 /
                                                5,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Center(
                                          child: customeCircularProgress,
                                        ),
                                      );
                                    default:
                                      _snapshotFavoris = snapshotFavoris.data;
                                      return _favList.length != 0
                                          ? Container(
                                              color: darkGray,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.25,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: new ListView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  children: snapshotFavoris
                                                      .data?.documents
                                                      ?.map((DocumentSnapshot
                                                          doc) {
                                                    inspect(_favList);
                                                    return _favList.contains(
                                                            doc.documentID)
                                                        ? _createFavCard(doc)
                                                        : Container();
                                                  })?.toList()),
                                            )
                                          : Container();
                                  }
                                }),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      // top: BorderSide(
                                      //     width: 1, color: Colors.grey[300]),
                                      )),
                              child: SingleChildScrollView(
                                child: ListView(
                                  shrinkWrap: true,
                                  children: [
                                    StreamBuilder<QuerySnapshot>(
                                        stream: Firestore.instance
                                            .collection('orders')
                                            .where('uidclient',
                                                isEqualTo:
                                                    Provider.of<User>(context)
                                                        .uid)
                                            .snapshots(),
                                        builder: (context, snapshotOrders) {
                                          if (snapshotOrders.hasError) {
                                            return customErrorWidget;
                                          }
                                          switch (
                                              snapshotOrders.connectionState) {
                                            case ConnectionState.none:
                                              return Container();
                                            case ConnectionState.waiting:
                                              return Container();

                                            default:
                                              return new Container(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        PageTransition(
                                                            type:
                                                                PageTransitionType
                                                                    .rightToLeft,
                                                            child:
                                                                CommandeCl()));
                                                  },
                                                  child: ListTile(
                                                    leading: Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              1 /
                                                              12,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              1 /
                                                              12,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xFF7648C7),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                      child: Center(
                                                          child: Icon(
                                                              OMIcons.list,
                                                              color: Colors
                                                                  .white)),
                                                    ),
                                                    title: Text(
                                                      '${Language.mapLang['orders']}',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    trailing: Text(
                                                      '${snapshotOrders.data.documents.length}'
                                                          .toLowerCase(),
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF71747E),
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                ),
                                              );
                                          }
                                        }),
                                    new Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              PageTransition(
                                                  type:
                                                      PageTransitionType
                                                          .rightToLeft,
                                                  child: FavorisCl(
                                                      favList: _favList,
                                                      snapshotFavoris:
                                                          _snapshotFavoris)));
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
                                                  color: Color(0xFFF8C513),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Center(
                                                  child: Icon(OMIcons.star,
                                                      color: Colors.white)),
                                            ),
                                            title: Text(
                                              '${Language.mapLang['favorite']}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            trailing: Text(
                                              '${_favList.length}'
                                                  .toLowerCase(),
                                              style: TextStyle(
                                                  color: Color(0xFF71747E),
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w400),
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ]);
                }
              })),
    );
  }

  Widget _createFavCard(DocumentSnapshot document) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: MediaQuery.of(context).size.width * 0.40,
        width: MediaQuery.of(context).size.width * 0.75,
        margin: EdgeInsets.only(left: 15, top: 15, bottom: 15),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        StationProfilCl(doc: document, fromWhere: 'profile')));
          },
          child: Stack(
            children: [
              Hero(
                tag: '${document.documentID}profile',
                child: CachedNetworkImage(
                  imageUrl:
                      document['photoURL'] == null ? '' : document['photoURL'],
                  imageBuilder: (context, imageProvider) => Ink.image(
                    image: imageProvider,
                    fit: BoxFit.fill,
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
              ),
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment(
                      -0.02, 1.0), // 10% of the width, so there are ten blinds.
                  colors: <Color>[
                    darkGray,
                    Colors.transparent,
                  ], // red to yellow
                  // tileMode: TileMode
                  //     .repeated, // repeats the gradient over the canvas
                )),
                child: Padding(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
