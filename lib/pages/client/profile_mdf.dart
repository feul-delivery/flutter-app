import 'dart:io';
import 'package:FD_flutter/modules/user.dart';
import 'package:FD_flutter/services/database.dart';
import 'package:FD_flutter/services/profile_picture.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'bbar_cl.dart';
import 'drawer_cl.dart';
import 'index_cl.dart';

String profileURL;

class ProfileCLModifier extends StatefulWidget {
  @override
  _ProfileCLModifierState createState() => _ProfileCLModifierState();
}

// ignore: camel_case_types
class _ProfileCLModifierState extends State<ProfileCLModifier>
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
  var email;
  var uid;
  void initState() {
    super.initState();
    _getEntData();
  }

  Future _getEntData() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    uid = user.uid;
    email = user.email;

    Firestore.instance
        .collection('client')
        .document(uid)
        .get()
        .then((value) async {
      print(uid);
      if (value.exists) {
        var key1 = await value.data['cin'];
        var key2 = await value.data['ville'];
        var key3 = await value.data['nom'];
        var key4 = await value.data['prenom'];
        var key5 = await value.data['sexe'];
        var key6 = await value.data['tele'];
        setState(() {
          this.cin = key1;
          this.ville = key2;
          this.nom = key3;
          this.prenom = key4;
          this.sexe = key5;
          this.tele = key6;
        });
      }
    });
  }

  final picker = ImagePicker();

  Future<File> getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    print('naaaaani');
    return null;
  }

  void _showImageSettingsPanel() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            margin: EdgeInsets.all(50),
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    File profileImage = await getImage(ImageSource.camera);
                    if (profileImage != null) {
                      profileURL = await uploadFile(profileImage);
                      setState(() {
                        IndexCl.client.photoURL = profileURL;
                      });
                    }
                  },
                  child: Material(
                      color: Colors.red[900],
                      borderRadius: BorderRadius.circular(10.0),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Icon(Icons.camera_alt,
                            color: Colors.white, size: 40.0),
                      ))),
                ),
                InkWell(
                  onTap: () async {
                    File profileImage = await getImage(ImageSource.gallery);
                    if (profileImage != null) {
                      profileURL = await uploadFile(profileImage);
                      setState(() {
                        IndexCl.client.photoURL = profileURL;
                      });
                    }
                  },
                  child: Material(
                      color: Colors.red[900],
                      borderRadius: BorderRadius.circular(10.0),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child:
                            Icon(Icons.photo, color: Colors.white, size: 40.0),
                      ))),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text(
            "My profile",
            style: pageTitle,
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  ButtomBarCl.selectedIndex = 0;
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => IndexCl()));
                })
          ],
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.red[900],
          elevation: 1,
        ),
        drawer: DrawerCL(),
        body: new Container(
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
                        Padding(
                            padding: EdgeInsets.only(left: 20.0, top: 20.0),
                            child: new Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[],
                            )),
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child:
                              new Stack(fit: StackFit.loose, children: <Widget>[
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Container(
                                    width: 140.0,
                                    height: 140.0,
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                        image: IndexCl.client?.photoURL == null
                                            ? new AssetImage(
                                                'assets/profile.png')
                                            : new NetworkImage(
                                                IndexCl.client.photoURL),
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                              ],
                            ),
                            Padding(
                                padding:
                                    EdgeInsets.only(top: 90.0, right: 100.0),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new CircleAvatar(
                                      backgroundColor: Colors.red[900],
                                      radius: 25.0,
                                      child: new IconButton(
                                        onPressed: () async {
                                          _showImageSettingsPanel();
                                        },
                                        icon: Icon(Icons.camera_alt),
                                        color: Colors.white,
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
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                    mainAxisAlignment: MainAxisAlignment.end,
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Last name:',
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
                                      controller: _controller1,
                                      decoration: InputDecoration(
                                        hintText: '$nom',
                                      ),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'First name:',
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
                                      controller: _controller2,
                                      decoration: InputDecoration(
                                        hintText: "$prenom",
                                      ),
                                      enabled: !_status,
                                      autofocus: !_status,
                                      onChanged: (val) {
                                        setState(() => prenomTmp = val);
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
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                      controller: _controller4,
                                      decoration:
                                          InputDecoration(hintText: "$tele"),
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
                                mainAxisAlignment: MainAxisAlignment.start,
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child: new TextField(
                                        controller: _controller5,
                                        decoration:
                                            InputDecoration(hintText: "$cin"),
                                        enabled: !_status,
                                        onChanged: (val) {
                                          setState(() => cinTmp = val);
                                        },
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                  Flexible(
                                    child: new TextField(
                                      controller: _controller6,
                                      decoration:
                                          InputDecoration(hintText: "$ville"),
                                      enabled: !_status,
                                      onChanged: (val) {
                                        setState(() => villeTmp = val);
                                      },
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              )),
                          !_status ? _getActionButtons() : new Container(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0, left: 10),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Save"),
                textColor: Colors.white,
                color: Colors.red[900],
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
                  final FirebaseAuth auth = FirebaseAuth.instance;
                  final FirebaseUser user = await auth.currentUser();
                  final uid = user.uid;
                  final DatabaseService _auth = DatabaseService(uid: uid);
                  email = Provider.of<User>(context, listen: true).email;
                  await _auth.updateClientData(
                      nom, prenom, email, sexe, cin, tele, ville);
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                child: new RaisedButton(
                  child: new Text("Cancel"),
                  textColor: Colors.red[900],
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
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red[900],
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
