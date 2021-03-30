import 'package:FD_flutter/modules/user.dart';
import 'package:FD_flutter/pages/client/profile_mdf.dart';
import 'package:FD_flutter/shared/FadeAnimation.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bbar_cl.dart';
import 'drawer_cl.dart';
import 'index_cl.dart';

// ignore: camel_case_types
class ProfileCl extends StatefulWidget {
  @override
  _ProfileClState createState() => _ProfileClState();
}

// ignore: camel_case_types
class _ProfileClState extends State<ProfileCl> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        ButtomBarCl.selectedIndex = 0;
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
                            ProfileCLModifier()));
                  })
            ],
            leading: Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.black,
            elevation: 1,
          ),
          bottomNavigationBar: ButtomBarCl(),
          drawer: DrawerCL(),
          body: StreamBuilder<DocumentSnapshot>(
              stream: Firestore.instance
                  .collection('client')
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
                          snapshot.data['photoURL'] == null
                              ? Container(
                                  width: 140,
                                  height: 140,
                                  child: CircleAvatar(
                                    radius: 35.0,
                                    backgroundImage:
                                        AssetImage('assets/profile.png'),
                                  ),
                                )
                              : CachedNetworkImage(
                                  imageUrl: snapshot.data['photoURL'],
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    width: 140,
                                    height: 140,
                                    child: CircleAvatar(
                                        radius: 35.0,
                                        backgroundImage: imageProvider),
                                  ),
                                  placeholder: (context, url) => Container(
                                    width: 140,
                                    height: 140,
                                    child: CircleAvatar(
                                        radius: 35.0,
                                        child: CircularProgressIndicator()),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    width: 140,
                                    height: 140,
                                    child: CircleAvatar(
                                        radius: 35.0, child: Icon(Icons.error)),
                                  ),
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
                          Container(
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              "First name : ",
                              style: textStyleWhite,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
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
                          Container(
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              "Last name : ",
                              style: textStyleWhite,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
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
                          Container(
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              "Phone : ",
                              style: textStyleWhite,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
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
                          Container(
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              "Email : ",
                              style: textStyleWhite,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
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
                          Container(
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              "CIN : ",
                              style: textStyleWhite,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                            child: Text(
                              '${snapshot.data['cin']}',
                              style: strongTextStyle,
                            ),
                          )
                        ],
                      ),
                    ),
                  ]),
                );
              })),
    );
  }
}
