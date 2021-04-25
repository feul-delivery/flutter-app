import 'dart:io';
import 'package:FD_flutter/pages/client/initial_profil_cl.dart';
import 'package:FD_flutter/pages/station/initial_profil_st.dart';
import 'package:FD_flutter/shared/splash.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:page_transition/page_transition.dart';

class TypeCompte extends StatefulWidget {
  @override
  _TypeCompteState createState() => _TypeCompteState();
}

class _TypeCompteState extends State<TypeCompte> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => exit(0),
      child: Scaffold(
          backgroundColor: scaffoldBackground,
          appBar: AppBar(
            title: Text(
              "${SplashScreen.mapLang['accounttype']}",
              style: pageTitleW,
            ),
            leading: Container(),
            backgroundColor: Colors.blue[700],
            centerTitle: true,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${SplashScreen.mapLang['dragchoose']}'.toUpperCase(),
                style: titleStyle,
              ),
              SizedBox(
                height: 20,
              ),
              Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                actions: <Widget>[
                  IconSlideAction(
                    caption: '${SplashScreen.mapLang['choose']}',
                    color: Colors.blue[500],
                    icon: OMIcons.check,
                    onTap: () async {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: new InitialProfilecl()));
                    },
                  ),
                ],
                child: Container(
                  decoration:
                      new BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        offset: Offset(0, 10))
                  ]),
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: [
                            RotatedBox(
                              quarterTurns: 2,
                              child: Icon(
                                Icons.play_arrow,
                                size: 50,
                              ),
                            ),
                            Text('${SplashScreen.mapLang['customer']}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 34.0)),
                          ],
                        ),
                        Material(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(24.0),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Icon(Icons.account_circle,
                                  color: Colors.white, size: 40.0),
                            )))
                      ]),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Slidable(
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: '${SplashScreen.mapLang['choose']}',
                    color: Colors.black,
                    icon: OMIcons.check,
                    onTap: () async {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: InitialProfileSt()));
                    },
                  ),
                ],
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                child: InkWell(
                  child: Container(
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadiusDirectional.horizontal(
                            start: Radius.lerp(Radius.zero, Radius.zero, 10)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 10,
                              offset: Offset(0, 10))
                        ]),
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Material(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(24.0),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Image(
                                  height: 40,
                                  width: 40,
                                  image: AssetImage('assets/fuel_tank_32.png'),
                                  color: Colors.white,
                                ),
                              ))),
                          Row(
                            children: [
                              Text('${SplashScreen.mapLang['enterprise']}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 34.0)),
                              Icon(
                                Icons.play_arrow,
                                size: 50,
                              ),
                            ],
                          )
                        ]),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          )),
    );
  }
}
