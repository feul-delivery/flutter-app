import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';

import 'widgets/StationWidget.dart';
import 'ClientProvider.dart';
import 'package:latlng/latlng.dart';
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
import 'home.dart';
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

Future<Coordinates> _getCurrentLocation(BuildContext ctx) async {
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
          backgroundColor: scaffoldBackground,
          key: _mScaffoldState,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    color: scaffoldBackground,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text('${Language.mapLang['home']}',
                              style: pageTitleO),
                        ),
                        StreamBuilder<DocumentSnapshot>(
                            stream: Firestore.instance
                                .collection('client')
                                .document(Provider.of<User>(context).uid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return SizedBox.shrink();
                              }
                              switch (snapshot.connectionState) {
                                case ConnectionState.none:
                                  return SizedBox.shrink();

                                case ConnectionState.waiting:
                                  return SizedBox.shrink();
                                default:
                                  List requestList = List.from(
                                      snapshot?.data['requests'] == null
                                          ? []
                                          : snapshot?.data['requests']);
                                  if (requestList.length == 0)
                                    return SizedBox.shrink();
                                  else
                                    return Material(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.transparent,
                                      child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Stack(
                                              children: [
                                                Icon(
                                                    Icons
                                                        .notifications_active_rounded,
                                                    color:
                                                        Colors.yellow.shade600),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 2,
                                                      horizontal: 4),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      color: Colors.red),
                                                  child: Center(
                                                    child: Text(
                                                      '${requestList.length}',
                                                      style: textStyle.copyWith(
                                                          fontSize: 10,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          onTap: () =>
                                              _showModalBottomNotifications(
                                                  context, requestList)),
                                    );
                              }
                            })
                      ],
                    )),
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
                          end: Alignment(-0.02, .8),
                          colors: <Color>[Colors.transparent, buttonColor],
                        )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Total Maroc',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Gotham',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 24,
                                )),
                            SizedBox(height: 5),
                            Text(
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
                ),
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
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                                    builder: (BuildContext context) => HomeCl(
                                          index: 1,
                                        )));
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
                                                await _getCurrentLocation(
                                                    context));
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
                  title: Text("${Language.mapLang['favorite']}"),
                  trailingIcon: Icon(Icons.favorite_border),
                  onPressed: () => _addStToFav(
                      document.documentID, Provider.of<User>(context).uid)),
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

Future<void> _showModalBottomNotifications(BuildContext context, List reqList) {
  return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (BuildContext context, setState) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: buttonColor,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.all(15),
                        child: Text(
                          '${Language.mapLang['workrequest']}',
                          style: pageTitleX.copyWith(color: Colors.white),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.info,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => new AlertDialog(
                              title: Wrap(
                                children: [
                                  Icon(Icons.info),
                                  SizedBox(width: 10),
                                  Container(
                                    margin: EdgeInsets.only(top: 3),
                                    child: Text('Info',
                                        style: pageTitle.copyWith(
                                            color: Colors.black)),
                                  ),
                                ],
                              ),
                              content: Container(
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: Text(
                                  "ces demandes de travaux sont envoyées par l'entreprise si elle ne vous concerne pas ou vous sont envoyées par erreur les refuser",
                                  style:
                                      textStyle.copyWith(color: Colors.black),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              actions: <Widget>[
                                new GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      'Ok',
                                      style: buttonStyle.copyWith(
                                          color: buttonColor),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
                Container(
                    color: scaffoldBackground,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: reqList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return StationWidget(
                          id: reqList[index],
                          scaffoldKey: _mScaffoldState,
                        );
                      },
                    )),
              ],
            ),
          );
        });
      });
}
