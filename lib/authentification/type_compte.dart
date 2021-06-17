import 'dart:io';
import 'package:FD_flutter/pages/client/initial_profil_cl.dart';
import 'package:FD_flutter/pages/station/initial_profil_st.dart';
import 'package:FD_flutter/shared/lang.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

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
          backgroundColor: darkGray,
          appBar: AppBar(
            title: Text(
              "${Language.mapLang['accounttype']}",
              style: pageTitleW,
            ),
            leading: Container(),
            backgroundColor: scaffoldBackground,
            centerTitle: true,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('${Language.mapLang['dragchoose']}'.toUpperCase(),
                  style: pageTitleW),
              SizedBox(
                height: 20,
              ),
              Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 1,
                actions: <Widget>[
                  IconSlideAction(
                    caption: '${Language.mapLang['choose']}',
                    color: buttonColor,
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
                      new BoxDecoration(color: scaffoldBackground, boxShadow: [
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
                        Shimmer.fromColors(
                          baseColor: scaffoldBackground,
                          highlightColor: Colors.white,
                          child: Row(
                            children: [
                              RotatedBox(
                                quarterTurns: 2,
                                child: Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                  size: 50,
                                ),
                              ),
                              Text('${Language.mapLang['customer']}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Quarion',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 34.0)),
                            ],
                          ),
                        ),
                        Material(
                            color: buttonColor,
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
                    caption: '${Language.mapLang['choose']}',
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
                actionExtentRatio: 1,
                child: InkWell(
                  child: Container(
                    decoration: new BoxDecoration(
                        color: scaffoldBackground,
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
                          Shimmer.fromColors(
                            baseColor: scaffoldBackground,
                            highlightColor: Colors.white,
                            child: Row(
                              children: [
                                Text('${Language.mapLang['enterprise']}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Quarion',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 34.0)),
                                Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                  size: 50,
                                ),
                              ],
                            ),
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
