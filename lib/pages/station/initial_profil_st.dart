import 'package:FD_flutter/modules/user.dart';
import 'package:FD_flutter/pages/station/type_st.dart';
import 'package:FD_flutter/services/database.dart';
import 'package:FD_flutter/shared/image_capture.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class InitialProfileSt extends StatefulWidget {
  @override
  _initialProfileStState createState() => _initialProfileStState();
}

// ignore: camel_case_types
class _initialProfileStState extends State<InitialProfileSt>
    with SingleTickerProviderStateMixin {
  final FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  String titre = '';
  String description = '';
  String tele = '';
  String email = '';
  String address = '';

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text(
            "My profile",
            style: pageTitle,
          ),
          actions: <Widget>[
            FlatButton(
              child: new Text(
                "Next",
                style: buttonStyle,
              ),
              textColor: Colors.white,
              color: Colors.black,
              onPressed: () async {
                final FirebaseAuth auth = FirebaseAuth.instance;
                final FirebaseUser user = await auth.currentUser();
                final uid = user.uid;
                final DatabaseService _auth = DatabaseService(uid: uid);
                if (_formKey.currentState.validate()) {
                  setState(() => loading = true);
                  email = user.email;
                  List<dynamic> _initTypes = [];
                  await _auth.updateEntrepriseData(
                      titre: titre,
                      description: description,
                      tele: tele,
                      email: email,
                      address: address,
                      types: _initTypes);
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade, child: TypeSt()));
                }
              },
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0)),
            )
          ],
          centerTitle: false,
          backgroundColor: Colors.black,
          elevation: 1,
        ),
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
                                      image: new ExactAssetImage(
                                          'assets/profile.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                                padding:
                                    EdgeInsets.only(top: 90.0, right: 100.0),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new CircleAvatar(
                                      backgroundColor: Colors.black,
                                      radius: 25.0,
                                      child: new IconButton(
                                        onPressed: () {
                                          String _uid = Provider.of<User>(
                                                  context,
                                                  listen: true)
                                              .uid;
                                          Navigator.of(context).push(
                                              PageTransition(
                                                  type: PageTransitionType
                                                      .leftToRight,
                                                  child: ImageCapture(
                                                    filePath:
                                                        'images/profile/$_uid',
                                                  )));
                                        },
                                        icon: Icon(Icons.camera),
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
                      child: Form(
                        key: _formKey,
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 17.0, right: 17.0, top: 15.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: new TextFormField(
                                        decoration: const InputDecoration(
                                          border: const OutlineInputBorder(),
                                          labelText: "Title",
                                        ),
                                        validator: (val) => val.isEmpty
                                            ? 'This field is required'
                                            : null,
                                        onChanged: (val) {
                                          setState(() => titre = val);
                                        },
                                      ),
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 17.0, right: 17.0, top: 15.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: new TextFormField(
                                        decoration: const InputDecoration(
                                          border: const OutlineInputBorder(),
                                          labelText: "Phone",
                                        ),
                                        validator: (val) => val.isEmpty
                                            ? 'This field is required'
                                            : null,
                                        onChanged: (val) {
                                          setState(() => tele = val);
                                        },
                                      ),
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 17.0, right: 17.0, top: 15.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: new TextFormField(
                                        decoration: const InputDecoration(
                                            border: const OutlineInputBorder(),
                                            labelText: "Address"),
                                        validator: (val) => val.isEmpty
                                            ? 'This field is required'
                                            : null,
                                        onChanged: (val) {
                                          setState(() => address = val);
                                        },
                                      ),
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 17.0, right: 17.0, top: 15.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: new TextFormField(
                                        maxLines: 3,
                                        decoration: const InputDecoration(
                                          border: const OutlineInputBorder(),
                                          labelText: "Description",
                                        ),
                                        onChanged: (val) {
                                          setState(() => description = val);
                                        },
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
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
}
