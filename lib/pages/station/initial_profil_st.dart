import 'package:FD_flutter/modules/user.dart';
import 'package:FD_flutter/pages/station/type_st.dart';
import 'package:FD_flutter/services/database.dart';
import 'package:FD_flutter/shared/lang.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
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
        backgroundColor: scaffoldBackground,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(OMIcons.arrowBack),
              onPressed: () => Navigator.of(context).pop()),
          title: Text(
            "${Language.mapLang['profile']}",
            style: pageTitleW,
          ),
          actions: <Widget>[
            FlatButton(
              child: new Text(
                "${Language.mapLang['next']}",
                style: buttonStyle,
              ),
              textColor: Colors.white,
              color: Colors.black,
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  final uid = Provider.of<User>(context).uid;
                  final email = Provider.of<User>(context).email;
                  final DatabaseService _auth = DatabaseService(uid: uid);
                  setState(() => loading = true);
                  await DatabaseService(uid: uid)
                      .updateUserType("entreprise", email);
                  List<dynamic> _initTypes = [];
                  await _auth.updateEntrepriseData(
                      titre: titre,
                      description: description,
                      tele: tele.toLowerCase(),
                      email: email.toLowerCase(),
                      address: address,
                      types: _initTypes,
                      images: _initTypes);
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade, child: TypeSt()));
                }
              },
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
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText:
                                              '${Language.mapLang['title']}',
                                        ),
                                        validator: (val) => val.isEmpty
                                            ? '${Language.mapLang['required']}'
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
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText:
                                              "${Language.mapLang['phone']}",
                                        ),
                                        validator: (val) => val.isEmpty
                                            ? '${Language.mapLang['required']}'
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
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText:
                                                "${Language.mapLang['address']}"),
                                        validator: (val) => val.isEmpty
                                            ? '${Language.mapLang['required']}'
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
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
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
