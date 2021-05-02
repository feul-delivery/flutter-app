import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:FD_flutter/shared/lang.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:FD_flutter/pages/client/station_cl.dart';
import 'package:flutter/services.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:geocoder/model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'explore_cl.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:FD_flutter/modules/user.dart';
import 'commanderPages/cmd_client.dart';

class IndexCl extends StatefulWidget {
  @override
  _IndexClState createState() => _IndexClState();
}

Coordinates _locationCoordinates;
Future<String> _getDistance(
    Coordinates locationFrom, Map<dynamic, dynamic> locationTo) async {
  return (Geolocator.distanceBetween(
            locationTo['latitude'],
            locationTo['longitude'],
            locationFrom.latitude,
            locationFrom.longitude,
          ) /
          1000)
      .toStringAsFixed(0);
}

StreamSubscription _locationSubscription;
Location _locationTracker = Location();
Future<void> _getCurrentLocation() async {
  var _location;
  try {
    _location = await _locationTracker.getLocation();

    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }

    _locationSubscription =
        _locationTracker.onLocationChanged().listen((newLocalData) {
      _location = newLocalData;
    });
    _locationCoordinates =
        new Coordinates(_location.latitude, _location.longitude);
  } on PlatformException catch (e) {
    if (e.code == 'PERMISSION_DENIED') {
      return null;
    }
  }
}

class _IndexClState extends State<IndexCl> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => exit(0),
      child: Scaffold(
        backgroundColor: scaffoldBackground,
        appBar: AppBar(
          title: Text('${Language.mapLang['home']}', style: pageTitleX),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            return await Future.delayed(Duration(seconds: 1)).then((value) {
              setState(() {});
            });
          },
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blue[500],
                        border: Border(
                            bottom:
                                BorderSide(width: 1, color: Colors.grey[300]))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 5.0),
                          margin:
                              EdgeInsets.only(left: 10, right: 10, bottom: 2),
                          child: Text(
                            '${Language.mapLang['bestweek']}'.toUpperCase(),
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
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
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
                            bottom:
                                BorderSide(width: 1, color: Colors.grey[300]),
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
                                  '${Language.mapLang['closetoyou']}',
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
                                      '${Language.mapLang['viewall']}'
                                          .toUpperCase(),
                                      style: TextStyle(
                                        fontFamily: 'Quarion',
                                        fontSize: 12,
                                        color: Colors.blue[700],
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          _locationCoordinates == null
                              ? Container(
                                  height: MediaQuery.of(context).size.width,
                                  child: Center(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                        Text(
                                          '${Language.mapLang['accesslocation']}',
                                          style: textStyle,
                                        ),
                                        TextButton.icon(
                                            onPressed: () async {
                                              await _getCurrentLocation();
                                              setState(() {});
                                            },
                                            icon: Icon(OMIcons.myLocation,
                                                color: Colors.blue[700]),
                                            label: Text(
                                              '${Language.mapLang['locateme']}',
                                              style: buttonStyleBlue,
                                            ))
                                      ])))
                              : StreamBuilder<QuerySnapshot>(
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
                                            child: Center(
                                                child:
                                                    customeCircularProgress));
                                      case ConnectionState.none:
                                        return Container(
                                            child: customErrorWidget);
                                      default:
                                        return new ListView(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            physics: BouncingScrollPhysics(),
                                            children: snapshot.data?.documents
                                                ?.map((DocumentSnapshot
                                                    document) {
                                              inspect(document['coordinates']);

                                              return _createSmallCard(
                                                  document, context);
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
        ),
      ),
    );
  }
}

Widget _createSmallCard(DocumentSnapshot document, BuildContext context) {
  return document['coordinates'] != null
      ? Material(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(width: 1, color: Colors.grey[300]),
                )),
            child: FocusedMenuHolder(
              // radius: 20,
              // menuWidth: MediaQuery.of(context).size.width,
              // blurSize: 5.0,
              // menuItemExtent: 45,
              // menuBoxDecoration: BoxDecoration(
              //     color: Colors.grey,
              //     borderRadius: BorderRadius.all(Radius.circular(15.0))),
              // duration: Duration(milliseconds: 100),
              // animateMenuItems: true,
              // blurBackgroundColor: Colors.black54,
              // bottomOffsetHeight: 100,
              // openWithTap: true,
              menuItems: <FocusedMenuItem>[
                FocusedMenuItem(
                    title: Text('${Language.mapLang['order']}',
                        style: TextStyle(
                          color: Colors.blue[700],
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.4,
                        )),
                    trailingIcon: Icon(OMIcons.accountBalanceWallet,
                        color: Colors.blue[700]),
                    onPressed: () => Navigator.of(context).push(PageTransition(
                        type: PageTransitionType.fade,
                        child: new ClientOrder(doc: document)))),
                FocusedMenuItem(
                    title: Text("${Language.mapLang['open']}"),
                    trailingIcon: Icon(Icons.open_in_new),
                    onPressed: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>ScreenTwo()));
                    }),
                // FocusedMenuItem(
                //     title: Text("Share"),
                //     trailingIcon: Icon(Icons.share),
                //     onPressed: () {}),
                FocusedMenuItem(
                    title: Text("${Language.mapLang['favorite']}"),
                    trailingIcon: Icon(Icons.favorite_border),
                    onPressed: () => _addStToFav(
                        document.documentID, Provider.of<User>(context).uid)),
                // FocusedMenuItem(
                //     title: Text(
                //       "Delete",
                //       style: TextStyle(color: Colors.redAccent),
                //     ),
                //     trailingIcon: Icon(
                //       Icons.delete,
                //       color: Colors.redAccent,
                //     ),
                //     onPressed: () {}),
              ],
              onPressed: () {
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
                                imageBuilder: (context, imageProvider) =>
                                    Material(
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
                                    child:
                                        Icon(Icons.error, color: Colors.black),
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
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 30.0, sigmaY: 30.0),
                                    child: Text(
                                      '${document['titre']}'.toUpperCase(),
                                      style: buttonStyle,
                                    ),
                                  ),
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
                            padding:
                                const EdgeInsets.only(left: 5.0, right: 5.0),
                            child: Center(
                                child: Row(children: [
                              Icon(OMIcons.locationOn, color: Colors.blue[700]),
                              FutureBuilder(
                                future: _getDistance(_locationCoordinates,
                                    document['coordinates']),
                                builder: (BuildContext context,
                                    AsyncSnapshot<String> snapshot) {
                                  return Text(
                                    "${snapshot.data} Km",
                                    style: TextStyle(color: Colors.blue[700]),
                                  );
                                },
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
        )
      : Container();
}

void _addStToFav(String documentID, String uid) async {
  try {
    await Firestore.instance.collection('client').document(uid).setData({
      'favorite': FieldValue.arrayUnion([documentID])
    }, merge: true);
  } catch (e) {
    print(e);
  }
}
