import 'package:FD_flutter/shared/FadeAnimation.dart';
import 'package:FD_flutter/pages/client/profile_mdf.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'bbar_cl.dart';
import 'drawer_cl.dart';
import 'index_cl.dart';

// ignore: camel_case_types
class profileCl extends StatefulWidget {
  @override
  _profileClState createState() => _profileClState();
}

// ignore: camel_case_types
class _profileClState extends State<profileCl> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        selectedIndex = 0;
        Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => IndexCl()));
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "My profile",
              style: pageTitle,
            ),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            profileCLModifier()));
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
          bottomNavigationBar: ButtomBarCl(),
          drawer: DrawerCL(),
          body: Container(
            padding: EdgeInsets.only(left: 16, top: 25, right: 16),
            child: ListView(children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 7))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/profile.png'))),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              FadeAnimation(
                1.2,
                Row(
                  children: [
                    Text(
                      "First name : ",
                      style: textStyle,
                    ),
                    Container(
                      child: Text(
                        'Da7mad',
                        style: strongTextStyle,
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 30,
                thickness: 1,
              ),
              FadeAnimation(
                1.2,
                Row(
                  children: [
                    Text(
                      "Last name : ",
                      style: textStyle,
                    ),
                    Container(
                      child: Text(
                        'Lmkawi',
                        style: strongTextStyle,
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 30,
                thickness: 1,
              ),
              FadeAnimation(
                1.2,
                Row(
                  children: [
                    Text(
                      "Phone : ",
                      style: textStyle,
                    ),
                    Container(
                      child: Text(
                        '+212601020304',
                        style: strongTextStyle,
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 30,
                thickness: 1,
              ),
              FadeAnimation(
                1.2,
                Row(
                  children: [
                    Text(
                      "Email : ",
                      style: textStyle,
                    ),
                    Container(
                      child: Text(
                        'Contact@da7mad.com',
                        style: strongTextStyle,
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 30,
                thickness: 1,
              ),
              FadeAnimation(
                1.2,
                Row(
                  children: [
                    Text(
                      "CIN : ",
                      style: textStyle,
                    ),
                    Container(
                      child: Text(
                        'CD454545',
                        style: strongTextStyle,
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 30,
                thickness: 1,
              ),
            ]),
          )),
    );
  }
}
