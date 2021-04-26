import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:FD_flutter/pages/client/profile_cl.dart';
import 'package:FD_flutter/shared/splash.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:FD_flutter/pages/client/station_cl.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:page_transition/page_transition.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'explore_cl.dart';

class IndexCl extends StatefulWidget {
  @override
  _IndexClState createState() => _IndexClState();
}

Coordinates _locationCoordinates;
final int _currentIndex = 0;
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
          title: Text('${SplashScreen.mapLang['home']}', style: pageTitleX),
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
                  title: Text('${SplashScreen.mapLang['home']}',
                      style: TextStyle(color: Colors.blue[700]))),
              BottomNavigationBarItem(
                  icon: Icon(OMIcons.explore, color: Color(0xFFB9BAC3)),
                  // ignore: deprecated_member_use
                  title: Text('${SplashScreen.mapLang['explore']}',
                      style: TextStyle(color: Color(0xFFB9BAC3)))),
              BottomNavigationBarItem(
                  icon: Icon(OMIcons.person, color: Color(0xFFB9BAC3)),
                  // ignore: deprecated_member_use
                  title: Text('${SplashScreen.mapLang['profile']}',
                      style: TextStyle(color: Color(0xFFB9BAC3)))),
            ]),
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
                            '${SplashScreen.mapLang['bestweek']}'.toUpperCase(),
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
                                  '${SplashScreen.mapLang['closetoyou']}',
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
                                      '${SplashScreen.mapLang['viewall']}'
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
                                          '${SplashScreen.mapLang['accesslocation']}',
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
                                              '${SplashScreen.mapLang['locateme']}',
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
