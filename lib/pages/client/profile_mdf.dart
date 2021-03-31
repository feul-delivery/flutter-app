import 'package:FD_flutter/modules/user.dart';
import 'package:FD_flutter/services/database.dart';
import 'package:FD_flutter/shared/image_capture.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:page_transition/page_transition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'drawer_cl.dart';

class ProfileCLModifier extends StatefulWidget {
  @override
  _ProfileCLModifierState createState() => _ProfileCLModifierState();
}

// ignore: camel_case_types
class _ProfileCLModifierState extends State<ProfileCLModifier>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  TextEditingController _controllerNom = TextEditingController();
  TextEditingController _controllerPrenom = TextEditingController();
  TextEditingController _controllerSexe = TextEditingController();
  TextEditingController _controllerTele = TextEditingController();
  TextEditingController _controllerCin = TextEditingController();
  TextEditingController _controllerVille = TextEditingController();
  //main variables
  String _cin;
  String _ville;
  String _nom;
  String _prenom;
  String _sexe;
  String _tele;
  //temporary variables
  String _cinTmp;
  String _villeTmp;
  String _nomTmp;
  String _prenomTmp;
  String _sexeTmp;
  String _teleTmp;
  // void initState() {
  //   super.initState();
  //   //_getEntData();
  // }

  // Future _getEntData() async {

  //       .then((value) async {
  //     if (value.exists) {
  //       var key1 = await value.data['cin'];
  //       var key2 = await value.data['ville'];
  //       var key3 = await value.data['nom'];
  //       var key4 = await value.data['prenom'];
  //       var key5 = await value.data['sexe'];
  //       var key6 = await value.data['tele'];
  //       setState(() {
  //         this._cin = key1;
  //         this._ville = key2;
  //         this._nom = key3;
  //         this._prenom = key4;
  //         this._sexe = key5;
  //         this._tele = key6;
  //       });
  //     }
  //   });
  // }

  User _user;
  @override
  Widget build(BuildContext context) {
    _user = Provider.of<User>(context);
    return new Scaffold(
        appBar: AppBar(
          title: Text(
            "My profile",
            style: pageTitle,
          ),
          actions: <Widget>[
            !_status ? _getActionButtons() : new Container(),
          ],
          centerTitle: true,
          backgroundColor: Colors.black,
          elevation: 1,
        ),
        drawer: DrawerCL(),
        body: StreamBuilder<DocumentSnapshot>(
            stream: Firestore.instance
                .collection('client')
                .document(_user.uid)
                .get()
                .asStream(),
            builder: (context, snapshot) {
              this._cin = snapshot.data['cin'];
              this._ville = snapshot.data['ville'];
              this._nom = snapshot.data['nom'];
              this._prenom = snapshot.data['prenom'];
              this._sexe = snapshot.data['sexe'];
              this._tele = snapshot.data['tele'];
              this._sexe = snapshot.data['sexe'];
              _controllerNom.text = _nom;
              _controllerPrenom.text = _prenom;
              _controllerTele.text = _tele;
              _controllerCin.text = _cin;
              _controllerVille.text = _ville;
              return new Container(
                color: Colors.white,
                child: new ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        new Container(
                          margin: EdgeInsets.all(20),
                          height: 250.0,
                          color: Colors.white,
                          child: new Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child:
                                    new Stack(fit: StackFit.loose, children: <
                                        Widget>[
                                  new Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      CachedNetworkImage(
                                        imageUrl: snapshot.data['photoURL'],
                                        imageBuilder: (context,
                                                imageProvider) =>
                                            new Container(
                                                width: 150.0,
                                                height: 150.0,
                                                decoration: new BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: new DecorationImage(
                                                    image: imageProvider ??
                                                        AssetImage(
                                                            'assets/profile.png'),
                                                    fit: BoxFit.cover,
                                                  ),
                                                )),
                                        progressIndicatorBuilder: (context, url,
                                                downloadProgress) =>
                                            CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error,
                                                color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: 90.0, right: 100.0),
                                      child: new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          new CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 25.0,
                                            child: new IconButton(
                                              onPressed: () async {
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
                                                                  'client',
                                                              manyPics: false,
                                                            )));
                                              },
                                              icon: Icon(Icons.camera_alt),
                                              color: Colors.black,
                                            ),
                                          )
                                        ],
                                      )),
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
                                Container(
                                    padding: EdgeInsets.only(
                                        left: 25.0,
                                        right: 25.0,
                                        top: 25.0,
                                        bottom: 10.0),
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
                                              'Personal information',
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            child: new Text(
                                              'First name:',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          flex: 2,
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: new Text(
                                              'Last name:',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
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
                                          child: new TextField(
                                            controller: _controllerPrenom,
                                            enabled: !_status,
                                            autofocus: !_status,
                                            onChanged: (val) {
                                              _prenomTmp = val;
                                            },
                                          ),
                                          flex: 2,
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(right: 10.0),
                                            child: new TextField(
                                              controller: _controllerNom,
                                              enabled: !_status,
                                              autofocus: !_status,
                                              onChanged: (val) {
                                                _nomTmp = val;
                                              },
                                            ),
                                          ),
                                          flex: 2,
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
                                              'Phone:',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
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
                                            controller: _controllerTele,
                                            enabled: !_status,
                                            onChanged: (val) {
                                              _teleTmp = val;
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
                                              'CIN:',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          flex: 2,
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: new Text(
                                              'City:',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
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
                                            padding:
                                                EdgeInsets.only(right: 10.0),
                                            child: new TextField(
                                              controller: _controllerCin,
                                              enabled: !_status,
                                              onChanged: (val) {
                                                _cinTmp = val;
                                              },
                                            ),
                                          ),
                                          flex: 2,
                                        ),
                                        Flexible(
                                          child: new TextField(
                                            controller: _controllerVille,
                                            enabled: !_status,
                                            onChanged: (val) {
                                              _villeTmp = val;
                                            },
                                          ),
                                          flex: 2,
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            }));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return new Row(
      children: <Widget>[
        new IconButton(
          icon: new Icon(
            Icons.cancel,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              _status = true;
              FocusScope.of(context).requestFocus(new FocusNode());
            });
          },
        ),
        new TextButton(
          child: new Text(
            'Save',
            style: buttonStyle,
          ),
          onPressed: () async {
            setState(() {
              _status = true;
              FocusScope.of(context).requestFocus(new FocusNode());

              if (_nomTmp != null) {
                _nom = _nomTmp;
              }
              if (_prenomTmp != null) {
                _prenom = _prenomTmp;
              }
              if (_teleTmp != null) {
                _tele = _teleTmp;
              }
              if (_cinTmp != null) {
                _cin = _cinTmp;
              }
              if (_villeTmp != null) {
                _ville = _villeTmp;
              }
              _controllerNom.clear();
              _controllerPrenom.clear();
              _controllerSexe.clear();
              _controllerTele.clear();
              _controllerCin.clear();
              _controllerVille.clear();
            });
            final DatabaseService _auth = DatabaseService(uid: _user.uid);
            await _auth.updateClientData(
                _nom, _prenom, _user.email, _sexe, _cin, _tele, _ville);
          },
        )
      ],
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.black,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}
