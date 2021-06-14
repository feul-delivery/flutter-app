import 'package:FD_flutter/modules/user.dart';
import 'package:FD_flutter/shared/FadeAnimation.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import 'bbar_liv.dart';
import 'index_lv.dart';
import 'drawer_liv.dart';
import 'profile_liv_mdf.dart';

class ProfileLiv extends StatefulWidget {
  @override
  _ProfileLivState createState() => _ProfileLivState();
}

class _ProfileLivState extends State<ProfileLiv> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        ButtomBarLiv.selectedIndex = 0;
        Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => IndexLv()));
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              "Mon profil",
              style: pageTitleO,
            ),
            leading: Builder(
              builder: (context) => IconButton(
                icon: Icon(
                  Icons.menu,
                  color: buttonColor,
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 1,
          ),
          bottomNavigationBar: ButtomBarLiv(),
          drawer: DrawerLiv(),
          body: StreamBuilder<DocumentSnapshot>(
              stream: Firestore.instance
                  .collection('livreur')
                  .document(Provider.of<User>(context).uid)
                  .get()
                  .asStream(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Icon(Icons.cancel, color: buttonColor));
                }

                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: customeCircularProgress);
                  case ConnectionState.none:
                    return Center(
                        child:
                            Icon(Icons.error_outline, color: Colors.white54));

                  default:
                    return Container(
                      padding: EdgeInsets.only(left: 16, top: 25, right: 16),
                      child: ListView(children: [
                        Center(
                          child: Stack(
                            children: [
                              CachedNetworkImage(
                                imageUrl: snapshot?.data['photoURL'] == null
                                    ? ''
                                    : snapshot?.data['photoURL'],
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  width: 140,
                                  height: 140,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1,
                                          color: buttonColor.withOpacity(0.7)),
                                      boxShadow: [
                                        BoxShadow(
                                            spreadRadius: 2,
                                            blurRadius: 10,
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            offset: Offset(0, 7))
                                      ],
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: imageProvider)),
                                ),
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 85),
                          child: Container(
                            decoration: BoxDecoration(
                                color: buttonColor,
                                borderRadius: BorderRadius.circular(50)),
                            margin: EdgeInsets.all(20),
                            child: Material(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(50),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ProfileLivModifier()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.20,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Modifier le profil',
                                          style: tileTitleStyleW,
                                        ),
                                        Transform.rotate(
                                            angle: 180 * math.pi / 180,
                                            child: Icon(
                                              Icons.arrow_back_ios_rounded,
                                              color: Colors.white,
                                              size: 20,
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        FadeAnimation(
                          1.2,
                          Row(
                            children: [
                              Container(
                                width: 70,
                                child: Text("Prénom: ",
                                    style: smallTileGray.copyWith(
                                        color: buttonColor,
                                        fontWeight: FontWeight.w500)),
                              ),
                              Text(
                                '${snapshot.data['prenom']}',
                                style: strongTextStyle,
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
                              Container(
                                width: 70,
                                child: Text("Nom: ",
                                    style: smallTileGray.copyWith(
                                        color: buttonColor,
                                        fontWeight: FontWeight.w500)),
                              ),
                              Text(
                                '${snapshot.data['nom']}',
                                style: strongTextStyle,
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
                              Container(
                                width: 70,
                                child: Text("Tél: ",
                                    style: smallTileGray.copyWith(
                                        color: buttonColor,
                                        fontWeight: FontWeight.w500)),
                              ),
                              Text(
                                '+212${snapshot.data['tele']}',
                                style: strongTextStyle,
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
                              Container(
                                width: 70,
                                child: Text("Email: ",
                                    style: smallTileGray.copyWith(
                                        color: buttonColor,
                                        fontWeight: FontWeight.w500)),
                              ),
                              Text(
                                '${snapshot.data['email']}',
                                style: strongTextStyle,
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
                              Container(
                                width: 70,
                                child: Text(
                                  "Cin: ",
                                  style: smallTileGray.copyWith(
                                      color: buttonColor,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Text(
                                '${snapshot.data['cin']}',
                                style: strongTextStyle,
                              )
                            ],
                          ),
                        ),
                        Divider(
                          height: 30,
                          thickness: 1,
                        ),
                      ]),
                    );
                }
              })),
    );
  }
}
