import 'package:FD_flutter/modules/user.dart';
import 'package:FD_flutter/services/auth.dart';
import 'package:FD_flutter/services/database.dart';
import 'package:FD_flutter/shared/lang.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:FD_flutter/wrapper.dart';

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

  List<String> _sexeTypes = ['female', 'male'];
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
        backgroundColor: scaffoldBackground,
        appBar: AppBar(
            centerTitle: false,
            backgroundColor: Colors.white,
            elevation: 1,
            title: Text("${Language.mapLang['profile']}", style: pageTitleX),
            leading: IconButton(
                icon: Icon(Icons.west, color: Colors.black),
                onPressed: () => Navigator.of(context).pop()),
            actions: <Widget>[
              InkWell(
                  onTap: () async {
                    email = Provider.of<User>(context, listen: true).email;
                    final uid = Provider.of<User>(context).uid;
                    print(email);
                    print(uid);
                    if (_formKey.currentState.validate()) {
                      final DatabaseService _auth = DatabaseService(uid: uid);
                      setState(() => loading = true);
                      DatabaseService(uid: uid).updateUserType("client", email);

                      _auth.setClientData(
                          nom.toLowerCase(),
                          prenom.toLowerCase(),
                          email.toLowerCase(),
                          sexe.toLowerCase(),
                          cin.toLowerCase(),
                          phone.toLowerCase(),
                          ville.toLowerCase());
                      AuthService.type = "client";
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => Wrapper()));
                    }
                  },
                  child: Center(
                      child: Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20)),
                          child: Text("${Language.mapLang['finish']}",
                              style: buttonStyle))))
            ]),
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
                                    left: 17.0, right: 17.0, top: 15),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: new TextFormField(
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          labelText:
                                              "${Language.mapLang['firstname']}",
                                        ),
                                        validator: (val) => val.isEmpty
                                            ? "${Language.mapLang['required']}"
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
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          labelText:
                                              "${Language.mapLang['lastname']}",
                                        ),
                                        validator: (val) => val.isEmpty
                                            ? "${Language.mapLang['required']}"
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
                                        decoration: InputDecoration(
                                            prefixIcon:
                                                Text('+212', style: hintStyle),
                                            border: const OutlineInputBorder(),
                                            labelText:
                                                "${Language.mapLang['phone']}"),
                                        validator: (val) =>
                                            _validateNumber(val),
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
                                  children: <Widget>[
                                    new Flexible(
                                      child: new TextFormField(
                                        decoration: InputDecoration(
                                            border: const OutlineInputBorder(),
                                            labelText:
                                                "${Language.mapLang['city']}"),
                                        validator: (val) => val.isEmpty
                                            ? "${Language.mapLang['required']}"
                                            : null,
                                        onChanged: (val) {
                                          setState(() => ville = val);
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
                                              ? "${Language.mapLang['required']}"
                                              : null,
                                          onChanged: (val) {
                                            setState(() => cin = val);
                                          },
                                        ),
                                      ),
                                      flex: 2,
                                    ),
                                    Flexible(
                                      flex: 2,
                                      child: Container(
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
                                                '${Language.mapLang['sexe']}:',
                                                style: tileTitleStyleW,
                                              ),
                                            ),
                                            DropdownButtonFormField(
                                              dropdownColor: scaffoldBackground,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none),
                                              hint: Text(
                                                '${Language.mapLang['sexe']}',
                                                style: hintStyle,
                                              ),
                                              items: _sexeTypes.map((sexe) {
                                                return DropdownMenuItem(
                                                  value: sexe.toLowerCase(),
                                                  child: Text(
                                                    '$sexe',
                                                    style: hintStyle,
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (val) => sexe = val,
                                              validator: (value) =>
                                                  value.isEmpty
                                                      ? 'Required'
                                                      : null,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Flexible(
                                    //   child: new TextFormField(
                                    //     decoration: const InputDecoration(
                                    //         border: const OutlineInputBorder(),
                                    //         hintText: "sexe (F ou M)"),
                                    //     validator: (val) {
                                    //       if (val != "male" &&
                                    //           val != "female") {
                                    //         return 'This field is required';
                                    //       } else {
                                    //         return null;
                                    //       }
                                    //     },
                                    //     onChanged: (val) {
                                    //       setState(() => sexe = val);
                                    //     },
                                    //   ),
                                    //   flex: 2,
                                    // ),
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

String _validateNumber(String val) {
  if (val.isEmpty)
    return "${Language.mapLang['required']}";
  else if (RegExp("[0-9]").hasMatch(val)) {
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
      default:
        return "${Language.mapLang['invalidnumber']}";
    }
  }
  return null;
}
