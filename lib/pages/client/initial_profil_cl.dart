import 'package:FD_flutter/modules/user.dart';
import 'package:FD_flutter/services/database.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'index_cl.dart';

// ignore: camel_case_types
class InitialProfilecl extends StatefulWidget {
  @override
  _initialProfileclState createState() => _initialProfileclState();
}

// ignore: camel_case_types
class _initialProfileclState extends State<InitialProfilecl>
    with SingleTickerProviderStateMixin {
  final FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  final DatabaseService _auth = DatabaseService();
  final _formKey = GlobalKey<FormState>();
  String nom = '';
  String prenom = '';
  String email = '';
  String sexe = '';
  String cin = '';
  String ville = '';
  String phone = '';

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
              child: Text(
                "Save",
                style: buttonStyle,
              ),
              textColor: Colors.white,
              color: Colors.red[900],
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  setState(() => loading = true);

                  email = Provider.of<User>(context, listen: true).getEmail();
                  await _auth.updateClientData(
                      nom, prenom, email, sexe, cin, phone, ville);
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade, child: IndexCl()));
                }
              },
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5.0)),
            ),
          ],
          centerTitle: false,
          backgroundColor: Colors.red[900],
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
                                      child: new Icon(
                                        Icons.camera_alt,
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
                                    left: 17.0, right: 17.0, top: 15),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: new TextFormField(
                                        decoration: const InputDecoration(
                                          border: const OutlineInputBorder(),
                                          labelText: "First name",
                                        ),
                                        validator: (val) => val.isEmpty
                                            ? 'This field is required'
                                            : null,
                                        onChanged: (val) {
                                          setState(() => prenom = val);
                                        },
                                      ),
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 17.0, right: 17.0, top: 15),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: new TextFormField(
                                        decoration: const InputDecoration(
                                          border: const OutlineInputBorder(),
                                          labelText: "Last name",
                                        ),
                                        validator: (val) => val.isEmpty
                                            ? 'This field is required'
                                            : null,
                                        onChanged: (val) {
                                          setState(() => nom = val);
                                        },
                                      ),
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 17.0, right: 17.0, top: 15),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: new TextFormField(
                                        decoration: const InputDecoration(
                                            border: const OutlineInputBorder(),
                                            labelText: "Phone"),
                                        validator: (val) => val.isEmpty
                                            ? 'This field is required'
                                            : null,
                                        onChanged: (val) {
                                          setState(() => phone = val);
                                        },
                                      ),
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 17.0, right: 17.0, top: 15),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 10.0),
                                        child: new TextFormField(
                                          decoration: const InputDecoration(
                                              border:
                                                  const OutlineInputBorder(),
                                              hintText: "Cin"),
                                          validator: (val) => val.isEmpty
                                              ? 'This field is required'
                                              : null,
                                          onChanged: (val) {
                                            setState(() => cin = val);
                                          },
                                        ),
                                      ),
                                      flex: 2,
                                    ),
                                    Flexible(
                                      child: new TextFormField(
                                        decoration: const InputDecoration(
                                            border: const OutlineInputBorder(),
                                            hintText: "City"),
                                        validator: (val) => val.isEmpty
                                            ? 'This field is required'
                                            : null,
                                        onChanged: (val) {
                                          setState(() => ville = val);
                                        },
                                      ),
                                      flex: 2,
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
