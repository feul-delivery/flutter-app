import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'ClientProvider.dart';
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
import 'package:shimmer/shimmer.dart';
import 'explore_cl.dart';
import 'package:FD_flutter/shared/custom_alert_dialog.dart';

import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:FD_flutter/modules/user.dart';
import 'commanderPages/cmd_client.dart';

class IndexCl extends StatefulWidget {
  @override
  _IndexClState createState() => _IndexClState();
}

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
// ignore: missing_return
Future<Coordinates> _getCurrentLocation() async {
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

    return new Coordinates(_location.latitude, _location.longitude);
  } on PlatformException catch (e) {
    if (e.code == 'PERMISSION_DENIED') {
      return null;
    }
  }
}

final GlobalKey<ScaffoldState> _mScaffoldState = new GlobalKey<ScaffoldState>();

class _IndexClState extends State<IndexCl> {
  @override
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
                title: new Text("${Language.mapLang['areyousure']}"),
                actions: <Widget>[
                  Row(children: [
                    new FlatButton(
                      onPressed: () => exit(0),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 0.0, bottom: 0.0, top: 10),
                        child: Text(
                          "oui",
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
      child: RefreshIndicator(
        onRefresh: () async {
          return await Future.delayed(Duration(seconds: 1)).then((value) {
            setState(() {});
          });
        },
        child: Scaffold(
          backgroundColor: scaffoldBackground, key: _mScaffoldState,
          // appBar: AppBar(
          //   title: ,
          //   backgroundColor: scaffoldBackground,
          //   elevation: 0,
          // ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    color: scaffoldBackground,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top),
                    padding: EdgeInsets.all(15),
                    child:
                        Text('${Language.mapLang['home']}', style: pageTitleO)),
                // Container(
                //   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                //   width: MediaQuery.of(context).size.width,
                //   decoration: BoxDecoration(color: Colors.red[700]),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         'you have a working request',
                //         style: textStyle.copyWith(color: Colors.white),
                //       ),
                //       Row(
                //         children: [
                //           Container(
                //             padding: EdgeInsets.fromLTRB(5, 4, 5, 4),
                //             decoration: BoxDecoration(
                //                 color: Colors.white,
                //                 borderRadius: BorderRadius.circular(20)),
                //             child: Material(
                //               borderRadius: BorderRadius.circular(20),
                //               color: Colors.transparent,
                //               child: InkWell(
                //                 borderRadius: BorderRadius.circular(20),
                //                 child: Text(
                //                   'accept',
                //                   style:
                //                       buttonStyle.copyWith(color: Colors.black),
                //                 ),
                //                 onTap: () {
                //                   print("accepted");
                //                 },
                //               ),
                //             ),
                //           ),
                //           SizedBox(width: 7),
                //           InkWell(
                //               child: Icon(Icons.clear, color: Colors.white),
                //               onTap: () => null),
                //         ],
                //       )
                //     ],
                //   ),
                // ),
                Container(
                  color: buttonColor,
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 5.0),
                  margin: EdgeInsets.only(bottom: 2),
                  child: Center(
                    child: Text(
                      '${Language.mapLang['bestweek']}'.toUpperCase(),
                      style: pageTitleXW,
                    ),
                  ),
                ),

                Stack(
                  children: [
                    Container(
                      child: ClipRRect(
                        child: Image.asset(
                          'assets/s3.jpg',
                          alignment: Alignment.center,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 15, left: 10, right: 10, bottom: 10),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment(-0.02,
                              .8), // 10% of the width, so there are ten blinds.
                          colors: <Color>[
                            Colors.transparent,
                            buttonColor
                          ], // red to yellow
                          // tileMode: TileMode
                          //     .repeated, // repeats the gradient over the canvas
                        )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //'${document['titre']}',
                            Text('Total Maroc',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Gotham',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 24,
                                )),
                            SizedBox(height: 5),
                            Text(
                              // '${document['adresse']}',
                              'Route sefrou, marjane 30000',
                              style: TextStyle(
                                color: Colors.white,
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
                ), // decoration: BoxDecoration(
                //     color: Colors.white,
                //     border: Border(
                //       bottom: BorderSide(width: 1, color: Colors.grey[300]),
                //       top: BorderSide(width: 1, color: Colors.grey[300]),
                //     )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 35,
                      color: scaffoldBackground,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ExploreCl()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(5),
                                margin: EdgeInsets.only(left: 10, right: 10),
                                child: Text(
                                  '${Language.mapLang['closetoyou']}',
                                  style: pageTitleW,
                                ),
                              ),
                              Opacity(
                                opacity: 0.8,
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  margin: EdgeInsets.all(5),
                                  child: Text(
                                    '${Language.mapLang['viewall']}'
                                        .toUpperCase(),
                                    style: TextStyle(
                                      fontFamily: 'Quarion',
                                      fontSize: 12,
                                      color: buttonColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Provider.of<ClientProvider>(context).locationCoordinates ==
                            null
                        ? Container(
                            height: MediaQuery.of(context).size.width,
                            child: Center(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                  Text(
                                    '${Language.mapLang['accesslocation']}',
                                    style:
                                        textStyle.copyWith(color: Colors.white),
                                  ),
                                  TextButton.icon(
                                      onPressed: () async {
                                        Provider.of<ClientProvider>(context,
                                                listen: false)
                                            .setCoordinates(
                                                await _getCurrentLocation());
                                      },
                                      icon: Icon(OMIcons.myLocation,
                                          color: buttonColor),
                                      label: Text(
                                        '${Language.mapLang['locateme']}',
                                        style: buttonStyleO,
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
                                  return _shimmerCards(context);
                                case ConnectionState.none:
                                  return Container(child: customErrorWidget);
                                default:
                                  return new ListView(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      children: snapshot.data?.documents
                                          ?.map((DocumentSnapshot document) {
                                        inspect(document['coordinates']);

                                        return _createSmallCard(
                                            document, context);
                                      })?.toList());
                              }
                            },
                          ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _createSmallCard(DocumentSnapshot document, BuildContext context) {
  return document['coordinates'] != null
      ? Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
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
                        color: buttonColor,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.4,
                      )),
                  trailingIcon:
                      Icon(OMIcons.accountBalanceWallet, color: buttonColor),
                  onPressed: () {
                    Firestore.instance
                        .collection('livreur')
                        .where('uidentreprise', isEqualTo: document.documentID)
                        .getDocuments()
                        .then((value) {
                      if (value.documents.length > 0) {
                        Navigator.of(context).push(PageTransition(
                            type: PageTransitionType.fade,
                            child: new ClientOrder(doc: document)));
                      } else {
                        showInSnackBar("${Language.mapLang['stnolv']}");
                      }
                    });
                  }),
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
                      builder: (context) =>
                          StationProfilCl(doc: document, fromWhere: 'index')));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    document['photoURL'] != null
                        ? Hero(
                            tag: '${document.documentID}index',
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
                          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                          child: Center(
                              child: Row(children: [
                            Icon(OMIcons.locationOn, color: buttonColor),
                            Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: FutureBuilder(
                                future: _getDistance(
                                    Provider.of<ClientProvider>(context)
                                        .locationCoordinates,
                                    document['coordinates']),
                                builder: (BuildContext context,
                                    AsyncSnapshot<String> snapshot) {
                                  return Text(
                                    "${snapshot.data} Km",
                                    style: buttonStyleO,
                                  );
                                },
                              ),
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
        )
      : Container();
}

void showInSnackBar(String value) {
  SnackBar snackBar = new SnackBar(
      backgroundColor: Colors.white,
      content: new Text(value, style: textStyle));
  _mScaffoldState.currentState.showSnackBar(snackBar);
}

_shimmerCards(BuildContext ctx) {
  return Shimmer(
    enabled: true,
    gradient: LinearGradient(
      colors: <Color>[darkGray, scaffoldBackground],
    ),
    child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          for (int i = 0; i < 4; i++)
            Container(height: 200, width: MediaQuery.of(ctx).size.width)
        ]),
  );
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
