import 'package:FD_flutter/modules/user.dart';
import 'package:FD_flutter/services/auth.dart';
import 'package:FD_flutter/services/database.dart';
import 'package:FD_flutter/shared/lang.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:FD_flutter/wrapper.dart';

class InitialProfilecl extends StatefulWidget {
  @override
  _initialProfileclState createState() => _initialProfileclState();
}

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
            backgroundColor: buttonColor,
            elevation: 1,
            title: Text("${Language.mapLang['profile']}", style: pageTitleW),
            leading: IconButton(
                icon: Icon(Icons.west, color: Colors.white),
                onPressed: () => Navigator.of(context).pop()),
            actions: <Widget>[
              Container(
                  margin: EdgeInsets.only(right: 5, top: 10, bottom: 10),
                  width: 75.0,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20)),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () async {
                        email = Provider.of<User>(context, listen: true).email;
                        final uid = Provider.of<User>(context).uid;
                        print(email);
                        print(uid);
                        if (_formKey.currentState.validate()) {
                          final DatabaseService _auth =
                              DatabaseService(uid: uid);
                          setState(() => loading = true);
                          DatabaseService(uid: uid)
                              .updateUserType("client", email);

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
                              MaterialPageRoute(
                                  builder: (context) => Wrapper()));
                        }
                      },
                      child: Center(
                        child: Text("${Language.mapLang['finish']}",
                            style: buttonStyle),
                      ),
                    ),
                  ))
            ]),
        body: new ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
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
                                    cursorColor: grayColor,
                                    cursorHeight: 25,
                                    cursorWidth: 1,
                                    style: hintStyle,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 15.0),
                                        border: const OutlineInputBorder(),
                                        labelText:
                                            "${Language.mapLang['firstname']}",
                                        labelStyle: hintStyle),
                                    validator: (val) => _validateNames(val),
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
                                    cursorColor: grayColor,
                                    cursorHeight: 25,
                                    cursorWidth: 1,
                                    style: hintStyle,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 15.0),
                                        border: const OutlineInputBorder(),
                                        labelText:
                                            "${Language.mapLang['lastname']}",
                                        labelStyle: hintStyle),
                                    validator: (val) => _validateNames(val),
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
                                    cursorColor: grayColor,
                                    cursorHeight: 25,
                                    cursorWidth: 1,
                                    style: hintStyle,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 15.0),
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0,
                                              top: 15.0,
                                              bottom: 10.0),
                                          child: Text('+212', style: hintStyle),
                                        ),
                                        border: const OutlineInputBorder(),
                                        labelText:
                                            "${Language.mapLang['phone']}",
                                        labelStyle: hintStyle),
                                    validator: (val) => _validateNumber(val),
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
                                  child: new DropdownSearch<String>(
                                    dropDownButton: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.white24,
                                      size: 20,
                                    ),
                                    mode: Mode.BOTTOM_SHEET,
                                    popupBackgroundColor: scaffoldBackground,
                                    showClearButton: true,
                                    showSearchBox: true,
                                    showSelectedItem: true,
                                    searchBoxDecoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 15.0),
                                        border: InputBorder.none,
                                        labelText:
                                            "${Language.mapLang['typehere']}",
                                        labelStyle: hintStyle),
                                    items: cities,
                                    clearButton: Icon(Icons.clear,
                                        color: Colors.white24),
                                    dropdownSearchDecoration: InputDecoration(
                                        labelStyle: hintStyle,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 15.0),
                                        border: const OutlineInputBorder(),
                                        hintText: "${Language.mapLang['city']}",
                                        hintStyle: hintStyle),
                                    validator: (val) => ville.isEmpty
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 10.0),
                                    child: new TextFormField(
                                      cursorColor: grayColor,
                                      cursorHeight: 25,
                                      cursorWidth: 1,
                                      style: hintStyle,
                                      decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 15.0),
                                          border: const OutlineInputBorder(),
                                          hintText: "Cin",
                                          hintStyle: hintStyle),
                                      validator: (val) => _cinValidator(val),
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
                                    margin:
                                        EdgeInsets.only(left: 10.0, right: 0.0),
                                    width: MediaQuery.of(context).size.width *
                                        0.50,
                                    child: Center(
                                      child: DropdownButtonFormField(
                                        dropdownColor: scaffoldBackground,
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                        ),
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
                                        onChanged: (val) {
                                          setState(() {
                                            sexe = val;
                                          });
                                        },
                                        validator: (val) => sexe.isEmpty
                                            ? "${Language.mapLang['required']}"
                                            : null,
                                      ),
                                    ),
                                  ),
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
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }
}

String _validateNames(String val) {
  if (val.isEmpty) return "${Language.mapLang['required']}";
  if (RegExp("[0-9]").hasMatch(val))
    return "${Language.mapLang['onlyletters']}";
  return null;
}

String _cinValidator(String val) {
  if (val.isEmpty) return "${Language.mapLang['required']}";
  if (val.length > 8) return "${Language.mapLang['invalidcin']}";
  print(val.substring(0, 1));

  if (!(RegExp("[A-Z]", caseSensitive: false).hasMatch(val.substring(0, 1))))
    return "${Language.mapLang['invalidcin']}";
  print(val.substring(2));
  print(!RegExp("[0-9]").hasMatch(val.substring(2)));
  for (int i = 2; i < val.length; i++) {
    print(val.substring(i, i + 1));
    if (!RegExp("[0-9]").hasMatch(val.substring(i, i + 1)))
      return "${Language.mapLang['invalidcin']}";
  }

  return null;
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
      default:
        return "${Language.mapLang['invalidnumber']}";
    }
  } else {
    return "${Language.mapLang['invalidnumber']}";
  }
}
