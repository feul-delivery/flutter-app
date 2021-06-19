import 'package:FD_flutter/modules/user.dart';
import 'package:FD_flutter/pages/livreur/bbar_liv.dart';
import 'package:FD_flutter/pages/livreur/index_lv.dart';
import 'package:FD_flutter/services/database.dart';
import 'package:FD_flutter/shared/image_capture.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'drawer_liv.dart';
import 'package:page_transition/page_transition.dart';

String profileURL;

class ProfileLivModifier extends StatefulWidget {
  @override
  _ProfileLivModifierState createState() => _ProfileLivModifierState();
}

// ignore: camel_case_types
class _ProfileLivModifierState extends State<ProfileLivModifier>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();
  TextEditingController _controller5 = TextEditingController();
  TextEditingController _controller6 = TextEditingController();

  String cin;
  String ville;
  String nom;
  String prenom;
  String sexe;
  String tele;

  String cinTmp;
  String villeTmp;
  String nomTmp;
  String prenomTmp;
  String sexeTmp;
  String teleTmp;
  String photo;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Mon profil", style: pageTitleO),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.home, color: buttonColor),
                onPressed: () {
                  ButtomBarLiv.selectedIndex = 0;
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => IndexLv()));
                })
          ],
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.menu,
                color: buttonColor,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.5,
        ),
        drawer: DrawerLiv(),
        body: StreamBuilder<DocumentSnapshot>(
            stream: Firestore.instance
                .collection('livreur')
                .document(Provider.of<User>(context, listen: false).uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Icon(Icons.cancel, color: buttonColor));
              }

              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: customeCircularProgress);
                case ConnectionState.none:
                  return Center(
                      child: Icon(Icons.error_outline, color: Colors.white54));

                default:
                  return new Container(
                    color: Colors.white,
                    child: new ListView(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            new Container(
                              height: 250.0,
                              color: Colors.white,
                              child: new Column(
                                children: <Widget>[
                                  SizedBox(height: 30),
                                  Padding(
                                    padding: EdgeInsets.only(top: 20.0),
                                    child: new Stack(children: <Widget>[
                                      Center(
                                        child: CachedNetworkImage(
                                          imageUrl: photo == null ? '' : photo,
                                          imageBuilder: (context,
                                                  imageProvider) =>
                                              new Container(
                                                  width: 140.0,
                                                  height: 140.0,
                                                  decoration: new BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: new DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )),
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              CircularProgressIndicator(
                                                  value: downloadProgress
                                                      .progress),
                                          errorWidget: (context, url, error) =>
                                              Container(
                                            width: 150.0,
                                            height: 150.0,
                                            decoration: BoxDecoration(
                                                color: darkGray,
                                                borderRadius:
                                                    BorderRadius.circular(75)),
                                            child: Center(
                                              child: Container(
                                                margin: EdgeInsets.only(top: 7),
                                                child: Text(
                                                    snapshot.data['prenom']
                                                            .substring(0, 1)
                                                            .toUpperCase() +
                                                        snapshot.data['nom']
                                                            .substring(0, 1)
                                                            .toUpperCase(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 70,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily: 'Quarion')),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Positioned(
                                          bottom: 0,
                                          child: new CircleAvatar(
                                            radius: 100,
                                            backgroundColor: Colors.transparent,
                                            child: new IconButton(
                                              onPressed: () {
                                                String _uid = Provider.of<User>(
                                                        context,
                                                        listen: true)
                                                    .uid;
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                        PageTransition(
                                                            type:
                                                                PageTransitionType
                                                                    .leftToRight,
                                                            child: ImageCapture(
                                                              filePath:
                                                                  'images/profile/$_uid',
                                                              collection:
                                                                  'livreur',
                                                              manyPics: false,
                                                            )));
                                              },
                                              icon: Icon(Icons.camera_alt,
                                                  color: Colors.white),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                  )
                                ],
                              ),
                            ),
                            new Container(
                              color: Color(0xffFFFFFF),
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 25.0),
                                child: new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                new Text(
                                                  'Informations personnelles',
                                                  style: subTitleStyle,
                                                ),
                                              ],
                                            ),
                                            new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                _status
                                                    ? _getEditIcon()
                                                    : new Container(),
                                              ],
                                            )
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                new Text(
                                                  'Nom:',
                                                  style: tileTitleStyle,
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Flexible(
                                              child: new TextField(
                                                controller: _controller1,
                                                decoration: InputDecoration(
                                                    hintText:
                                                        '${snapshot.data['nom']}',
                                                    hintStyle: hintStyleB),
                                                enabled: !_status,
                                                autofocus: !_status,
                                                onChanged: (val) {
                                                  setState(() => nomTmp = val);
                                                },
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                new Text(
                                                  'Prénom:',
                                                  style: tileTitleStyle,
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Flexible(
                                              child: new TextField(
                                                controller: _controller2,
                                                decoration: InputDecoration(
                                                    hintText:
                                                        "${snapshot.data['prenom']}",
                                                    hintStyle: hintStyleB),
                                                enabled: !_status,
                                                autofocus: !_status,
                                                onChanged: (val) {
                                                  setState(
                                                      () => prenomTmp = val);
                                                },
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                new Text(
                                                  'Tél:',
                                                  style: tileTitleStyle,
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Flexible(
                                              child: new TextField(
                                                controller: _controller4,
                                                decoration: InputDecoration(
                                                    hintText:
                                                        "+212${snapshot.data['tele']}",
                                                    hintStyle: hintStyleB),
                                                enabled: !_status,
                                                onChanged: (val) {
                                                  setState(() => teleTmp = val);
                                                },
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                child: new Text(
                                                  'Cin:',
                                                  style: tileTitleStyle,
                                                ),
                                              ),
                                              flex: 2,
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: new Text(
                                                  'Ville:',
                                                  style: tileTitleStyle,
                                                ),
                                              ),
                                              flex: 2,
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    right: 10.0),
                                                child: new TextField(
                                                  controller: _controller5,
                                                  decoration: InputDecoration(
                                                      hintText:
                                                          "${snapshot.data['cin']}",
                                                      hintStyle: hintStyleB),
                                                  enabled: !_status,
                                                  onChanged: (val) {
                                                    setState(
                                                        () => cinTmp = val);
                                                  },
                                                ),
                                              ),
                                              flex: 2,
                                            ),
                                            Flexible(
                                              child: new TextField(
                                                controller: _controller6,
                                                decoration: InputDecoration(
                                                    hintText:
                                                        "${snapshot.data['ville']}",
                                                    hintStyle: hintStyleB),
                                                enabled: !_status,
                                                onChanged: (val) {
                                                  setState(
                                                      () => villeTmp = val);
                                                },
                                              ),
                                              flex: 2,
                                            ),
                                          ],
                                        )),
                                    !_status
                                        ? _getActionButtons()
                                        : new Container(),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
              }
            }));
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
                child: new RaisedButton(
              child: new Text("Save"),
              textColor: Colors.white,
              color: buttonColor,
              onPressed: () async {
                setState(() {
                  _status = true;
                  FocusScope.of(context).requestFocus(new FocusNode());

                  if (nomTmp != null) {
                    nom = nomTmp;
                  }
                  if (prenomTmp != null) {
                    prenom = prenomTmp;
                  }
                  if (teleTmp != null) {
                    tele = teleTmp;
                  }
                  if (cinTmp != null) {
                    cin = cinTmp;
                  }
                  if (villeTmp != null) {
                    ville = villeTmp;
                  }
                  _controller1.clear();
                  _controller2.clear();
                  _controller3.clear();
                  _controller4.clear();
                  _controller5.clear();
                  _controller6.clear();
                });

                final DatabaseService _auth =
                    DatabaseService(uid: Provider.of<User>(context).uid);

                await _auth.updateLivreurData(
                    nom, prenom, cin, sexe, tele, ville);
              },
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0)),
            )),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                child: new RaisedButton(
                  child: new Text(
                    "Cancel",
                    style: buttonStyle,
                  ),
                  textColor: Colors.black,
                  color: Colors.white,
                  onPressed: () {
                    setState(() {
                      _status = true;
                      FocusScope.of(context).requestFocus(new FocusNode());
                    });
                  },
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0)),
                ),
              ),
              //flex: 2,
            ),
          )
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new IconButton(
      color: Colors.black26,
      icon: new Icon(
        Icons.edit,
        color: buttonColor,
        size: 16.0,
      ),
      onPressed: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}
