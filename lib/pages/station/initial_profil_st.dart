import 'package:FD_flutter/modules/user.dart';
import 'package:FD_flutter/pages/station/type_st.dart';
import 'package:FD_flutter/services/database.dart';
import 'package:FD_flutter/shared/lang.dart';
import 'package:FD_flutter/shared/text_styles.dart';
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.west),
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
        body: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Container(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
              child: Form(
                key: _formKey,
                child: new Column(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: new Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            new Flexible(
                              child: new TextFormField(
                                cursorColor: grayColor,
                                cursorHeight: 25,
                                cursorWidth: 1,
                                style: hintStyleB,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 15.0),
                                    border: OutlineInputBorder(),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, top: 15.0, bottom: 10.0),
                                      child: Text('+212', style: hintStyleB),
                                    ),
                                    hintText: "${Language.mapLang['phone']}",
                                    hintStyle: hintStyleB),
                                validator: (val) => _validateNumber(val),
                                onChanged: (val) {
                                  setState(() => tele = val);
                                },
                              ),
                            ),
                          ],
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: new Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            new Flexible(
                              child: new TextFormField(
                                cursorColor: grayColor,
                                cursorHeight: 25,
                                cursorWidth: 1,
                                style: hintStyleB,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 15.0),
                                    border: OutlineInputBorder(),
                                    hintText: '${Language.mapLang['title']}',
                                    hintStyle: hintStyleB),
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
                        padding: EdgeInsets.only(top: 15.0),
                        child: new Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            new Flexible(
                              child: new TextFormField(
                                cursorColor: grayColor,
                                cursorHeight: 25,
                                cursorWidth: 1,
                                style: hintStyleB,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 15.0),
                                    border: OutlineInputBorder(),
                                    hintStyle: hintStyleB,
                                    hintText: "${Language.mapLang['address']}"),
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
                        padding: EdgeInsets.only(top: 15.0),
                        child: new Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            new Flexible(
                              child: new TextFormField(
                                maxLines: 3,
                                cursorColor: grayColor,
                                cursorHeight: 25,
                                cursorWidth: 1,
                                style: hintStyleB,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 15.0),
                                    border: OutlineInputBorder(),
                                    hintText: "Description",
                                    hintStyle: hintStyleB),
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
          ],
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }
}

String _validateNumber(String val) {
  if (val.isEmpty) return "${Language.mapLang['required']}";
  if (val.length != 9) return "${Language.mapLang['invalidnumber']}";
  if (RegExp("[0-9]").hasMatch(val)) {
    switch (val.substring(0, 1)) {
      case '6':
        return null;
        break;
      case '7':
        return null;
        break;
      case '5':
        return null;
        break;
      case '8':
        return null;
        break;
      default:
        return "${Language.mapLang['invalidnumber']}";
    }
  } else {
    return "${Language.mapLang['invalidnumber']}";
  }
}
