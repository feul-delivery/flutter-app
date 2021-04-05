import 'package:FD_flutter/pages/client/profile_mdf.dart';
import 'package:FD_flutter/services/auth.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:FD_flutter/wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class SettingsCl extends StatefulWidget {
  SettingsCl({Key key}) : super(key: key);

  @override
  _SettingsClState createState() => _SettingsClState();
}

AuthService _auth = AuthService();

class _SettingsClState extends State<SettingsCl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackground,
      appBar: AppBar(
        title: Text(
          "Settings",
          style: pageTitleX,
        ),
        leading: IconButton(
            icon: Icon(
              OMIcons.arrowBack,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(scrollDirection: Axis.vertical, children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(width: 1, color: Colors.grey[300]))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                child: Text(
                  'Account',
                  style: pageTitleX,
                ),
              ),
              Material(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ProfileCLModifier()));
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Colors.blue[700],
                    ),
                    title: Text(
                      "Edit profile",
                      style: textStyle,
                    ),
                  ),
                ),
              ),
              Material(
                child: InkWell(
                  onTap: () {
                    _modalChangePasswordRow(context);
                  },
                  child: ListTile(
                    leading: Icon(
                      OMIcons.lock,
                      color: Colors.blue[700],
                    ),
                    title: Text(
                      "Change password",
                      style: textStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(width: 1, color: Colors.grey[300]))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
                child: Text(
                  'Application',
                  style: pageTitleX,
                ),
              ),
              Material(
                child: InkWell(
                  onTap: () {
                    _showModalBottomRateUs(context);
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.rate_review,
                      color: Colors.blue[700],
                    ),
                    title: Text(
                      "Rate us",
                      style: textStyle,
                    ),
                  ),
                ),
              ),
              Material(
                child: InkWell(
                  onTap: () {
                    _buildModalAboutUsRow(context);
                  },
                  child: ListTile(
                    leading: Icon(
                      OMIcons.info,
                      color: Colors.blue[700],
                    ),
                    title: Text(
                      "About us",
                      style: textStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Material(
          child: InkWell(
              onTap: () async {
                _auth.signOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => Wrapper()));
              },
              child: ListTile(
                leading: Icon(
                  OMIcons.exitToApp,
                  color: Colors.blue[700],
                ),
                title: Text(
                  "Sign out",
                  style: textStyle,
                ),
              )),
        )
      ]),
    );
  }
}

Future<void> _showModalBottomRateUs(BuildContext context) {
  return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (BuildContext context, setState) {
          return Container(
              height: MediaQuery.of(context).size.height * 1 / 4,
              child: ListView(
                children: [
                  Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.only(
                          left: 10, right: 10, bottom: 5, top: 10),
                      child: Text('Rate us', style: pageTitleX)),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 4 / 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.star_border_outlined),
                            Icon(Icons.star_border_outlined),
                            Icon(Icons.star_border_outlined),
                            Icon(Icons.star_border_outlined),
                            Icon(Icons.star_border_outlined),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () async {},
                        child: Container(
                          height: 45,
                          margin: EdgeInsets.fromLTRB(15, 7, 15, 7),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.blue[700]),
                          child: Center(
                            child: Text(
                              "Submit".toUpperCase(),
                              style: buttonStyle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ));
        });
      });
}

Future<void> _modalChangePasswordRow(BuildContext context) {
  bool _isObscure = true;
  final _formKey = GlobalKey<FormState>();
  String _password;
  return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.all(5),
                margin:
                    EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 10),
                child: Text('Change password', style: pageTitleX)),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 7, 15, 7),
                          child: TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "Old password",
                              hintStyle: hintStyle,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 15.0),
                            ),
                            validator: (val) => val != _password
                                ? 'confirmation do not match the password.'
                                : null,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 7, 15, 7),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            obscureText: _isObscure,
                            decoration: InputDecoration(
                              hintText: "Password",
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    _isObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: _isObscure
                                        ? Color(0xFFB9BAC3)
                                        : Colors.blue[700],
                                  ),
                                  onPressed: () {
                                    // setState(() {
                                    //   _isObscure = !_isObscure;
                                    // });
                                  }),
                              hintStyle: hintStyle,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 15.0),
                            ),
                            validator: (val) => val.length < 6
                                ? 'enter a password 8+ chars long.'
                                : null,
                            onChanged: (val) {
                              // setState(() => password = val);
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 7, 15, 7),
                          child: TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "Confirmation",
                              hintStyle: hintStyle,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 15.0),
                            ),
                            validator: (val) => val != _password
                                ? 'confirmation do not match the password.'
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    '',
                    style: TextStyle(
                        color: Colors.red,
                        fontFamily: 'Gotham',
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () async {
                      if (_formKey.currentState.validate()) {}
                    },
                    child: Container(
                      height: 45,
                      margin: EdgeInsets.fromLTRB(15, 7, 15, 7),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blue[700]),
                      child: Center(
                        child: Text(
                          "Validate".toUpperCase(),
                          style: buttonStyle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      });
}

Future<void> _buildModalAboutUsRow(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.all(5),
                margin:
                    EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 10),
                child: Text('About us', style: pageTitleX)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 10,
                          color: Theme.of(context).scaffoldBackgroundColor),
                      boxShadow: [],
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/Fueldelivery.png'))),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  'Build by the Flutter framework.',
                  style: textStyle,
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  'Developped by:',
                  style: textStyle,
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  'ELHESSBI Imad',
                  style: titleStyleNew,
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  'ZAMOURI Iliyass',
                  style: titleStyleNew,
                ),
              ],
            ),
          ],
        );
      });
}
