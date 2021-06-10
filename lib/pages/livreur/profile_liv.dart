import 'package:FD_flutter/modules/user.dart';
import 'package:FD_flutter/shared/FadeAnimation.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
              "My profile",
              style: pageTitleO,
            ),
            actions: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: buttonColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ProfileLivModifier()));
                  })
            ],
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
                            imageBuilder: (context, imageProvider) => Container(
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor),
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        color: Colors.black.withOpacity(0.1),
                                        offset: Offset(0, 7))
                                  ],
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover, image: imageProvider)),
                            ),
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
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
                              '${snapshot.data['prenom']}',
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
                              '${snapshot.data['nom']}',
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
                              '${snapshot.data['tele']}',
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
                              '${snapshot.data['email']}',
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
                              '${snapshot.data['cin']}',
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
                );
              })),
    );
  }
}
