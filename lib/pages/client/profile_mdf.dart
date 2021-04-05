import 'package:FD_flutter/modules/user.dart';
import 'package:FD_flutter/services/database.dart';
import 'package:FD_flutter/shared/image_capture.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ProfileCLModifier extends StatefulWidget {
  @override
  _ProfileCLModifierState createState() => _ProfileCLModifierState();
}

// ignore: camel_case_types
class _ProfileCLModifierState extends State<ProfileCLModifier>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();

  //controller of text editing
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

//temps
  List<String> _sexeTypes = ['female', 'male'];

  User _user;
  @override
  Widget build(BuildContext context) {
    _user = Provider.of<User>(context);
    return new Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(OMIcons.arrowBack, color: Colors.black),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          title: Text(
            "Profile",
            style: pageTitleX,
          ),
          actions: <Widget>[
            !_status ? _getActionButtons() : new Container(),
          ],
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: StreamBuilder<DocumentSnapshot>(
            stream: Firestore.instance
                .collection('client')
                .document(_user.uid)
                .get()
                .asStream(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
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
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Container(
                    width: MediaQuery.of(context).size.height * 1 / 5,
                    child: Center(
                      child: Icon(
                        OMIcons.error,
                        color: Color(0xFF1763B9),
                      ),
                    ),
                  );

                case ConnectionState.waiting:
                  return Container(
                    height: MediaQuery.of(context).size.height * 1 / 5,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: customeCircularProgress,
                    ),
                  );
                default:
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
                  _controllerSexe.text = _sexe;
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
                                    child: new Stack(
                                        fit: StackFit.loose,
                                        children: <Widget>[
                                          new Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              CachedNetworkImage(
                                                imageUrl:
                                                    snapshot.data['photoURL'],
                                                imageBuilder: (context,
                                                        imageProvider) =>
                                                    new Container(
                                                        width: 150.0,
                                                        height: 150.0,
                                                        decoration:
                                                            new BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          image:
                                                              new DecorationImage(
                                                            image: imageProvider ??
                                                                AssetImage(
                                                                    'assets/profile.png'),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        )),
                                                progressIndicatorBuilder: (context,
                                                        url,
                                                        downloadProgress) =>
                                                    CircularProgressIndicator(
                                                        backgroundColor:
                                                            Colors.white,
                                                        valueColor:
                                                            new AlwaysStoppedAnimation<
                                                                    Color>(
                                                                Colors.white),
                                                        value: downloadProgress
                                                            .progress),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Icon(Icons.error,
                                                        color: Colors.black),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  top: 100.0, right: 100.0),
                                              child: new Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  new CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white,
                                                    radius: 20.0,
                                                    child: new IconButton(
                                                        onPressed: () async {
                                                          String _uid =
                                                              Provider.of<User>(
                                                                      context,
                                                                      listen:
                                                                          true)
                                                                  .uid;
                                                          Navigator.of(context)
                                                              .pushReplacement(
                                                                  PageTransition(
                                                                      type: PageTransitionType
                                                                          .leftToRight,
                                                                      child:
                                                                          ImageCapture(
                                                                        filePath:
                                                                            'images/profile/$_uid',
                                                                        collection:
                                                                            'client',
                                                                        manyPics:
                                                                            false,
                                                                      )));
                                                        },
                                                        icon: Icon(
                                                            OMIcons.camera,
                                                            size: 22),
                                                        color: Colors.black),
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
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            new Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              mainAxisSize: MainAxisSize.max,
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 2),
                                                  child: new Text(
                                                    'Personal information',
                                                    style: subTitleStyle,
                                                  ),
                                                ),
                                                _status
                                                    ? _getEditIcon()
                                                    : new Container()
                                              ],
                                            ),
                                            Divider(
                                              height: 10,
                                              thickness: 1,
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
                                                  'First name:',
                                                  style: tileTitleStyle,
                                                ),
                                              ),
                                              flex: 2,
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: new Text(
                                                  'Last name:',
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
                                              child: new TextField(
                                                style: hintStyle,
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
                                                padding: EdgeInsets.only(
                                                    right: 10.0),
                                                child: new TextField(
                                                  style: hintStyle,
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
                                                style: hintStyle,
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
                                                  style: tileTitleStyle,
                                                ),
                                              ),
                                              flex: 2,
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: new Text(
                                                  'City:',
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
                                                  style: hintStyle,
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
                                                style: hintStyle,
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
                                    //add sexe here as dropdown
                                    Container(
                                      margin: EdgeInsets.only(top: 20),
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 2.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: new Text(
                                              'Sexe:',
                                              style: tileTitleStyle,
                                            ),
                                          ),
                                          DropdownButtonFormField(
                                            value: '${snapshot.data['sexe']}',
                                            decoration: InputDecoration(
                                                enabled: !_status,
                                                border: InputBorder.none),
                                            hint: Text(
                                              '$_sexe',
                                              style: hintStyle,
                                            ),
                                            items: _status == false
                                                ? _sexeTypes.map((sexe) {
                                                    return DropdownMenuItem(
                                                      value: sexe.toLowerCase(),
                                                      child: Text(
                                                        '$sexe',
                                                        style: hintStyle,
                                                      ),
                                                    );
                                                  }).toList()
                                                : null,
                                            onChanged: (val) => _sexeTmp = val,
                                            validator: (value) => value.isEmpty
                                                ? 'Required'
                                                : null,
                                          ),
                                        ],
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
                  );
              }
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
        SizedBox(width: 5),
        new IconButton(
          icon: new Icon(OMIcons.cancel, color: Colors.black),
          onPressed: () {
            setState(() {
              _status = true;
              FocusScope.of(context).requestFocus(new FocusNode());
            });
          },
        ),
        SizedBox(width: 5),
        new IconButton(
          icon: Icon(OMIcons.save, color: Colors.black),
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
              if (_sexeTmp != null) {
                _sexe = _sexeTmp;
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
                _nom.toLowerCase(),
                _prenom.toLowerCase(),
                _user.email.toLowerCase(),
                _sexe.toLowerCase(),
                _cin.toLowerCase(),
                _tele.toLowerCase(),
                _ville.toLowerCase());
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
          OMIcons.edit,
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
