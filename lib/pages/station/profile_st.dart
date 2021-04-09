import 'package:FD_flutter/modules/user.dart';
import 'package:FD_flutter/pages/station/images.dart';
import 'package:FD_flutter/shared/custom_alert_dialog.dart';
import 'package:FD_flutter/shared/image_capture.dart';
import 'package:FD_flutter/shared/FadeAnimation.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilSt extends StatefulWidget {
  @override
  _ProfilStState createState() => _ProfilStState();
}

List<Map<dynamic, dynamic>> _imagesList;

class _ProfilStState extends State<ProfilSt> {
  void _editInfoDialog(
      String uid, String field, String fieldName, BuildContext context) {
    String _value;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomAlertDialog(
            title: Text('Edit $fieldName'),
            content: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey[200]))),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: '$fieldName',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                      onChanged: (val) {
                        _value = val;
                      },
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Row(
                children: [
                  FlatButton(
                      onPressed: () async {
                        Firestore.instance
                            .collection('entreprise')
                            .document(uid)
                            .updateData({field: _value});
                      },
                      child: Text('Change',
                          style: TextStyle(color: Colors.black))),
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel',
                          style: TextStyle(color: Colors.black))),
                ],
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    User _user = Provider.of<User>(context, listen: true);
    return Scaffold(
      backgroundColor: Color(0xFFEFF0F5),
      body: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection('entreprise')
              .document(_user.uid)
              .get()
              .asStream(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Container(
                width: MediaQuery.of(context).size.height * 1 / 5,
                child: Center(
                  child: Icon(
                    OMIcons.error,
                    color: Color(0xFF1763B9),
                  ),
                ),
              );
            }
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Container(
                  width: MediaQuery.of(context).size.height * 1 / 5,
                  child: Center(
                    child: Icon(
                      OMIcons.error,
                      color: Color(0xFF1763B9),
                    ),
                  ),
                );

              case ConnectionState.waiting:
                return Container(
                  height: MediaQuery.of(context).size.height * 1 / 5,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: customeCircularProgress,
                  ),
                );
              case ConnectionState.active:
                return Container(
                  height: MediaQuery.of(context).size.height * 1 / 5,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: customeCircularProgress,
                  ),
                );
              default:
                _imagesList =
                    List<Map<dynamic, dynamic>>.from(snapshot.data['images'])
                        .toList();
                return Stack(
                  children: <Widget>[
                    CustomScrollView(
                      slivers: <Widget>[
                        SliverAppBar(
                          expandedHeight: 200,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          flexibleSpace: FlexibleSpaceBar(
                            collapseMode: CollapseMode.pin,
                            background: snapshot.data['photoURL'] == null
                                ? Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                                AssetImage('assets/total.png'),
                                            fit: BoxFit.cover)),
                                    child: IconButton(
                                      onPressed: () async {
                                        Navigator.of(context).push(
                                            PageTransition(
                                                type: PageTransitionType
                                                    .leftToRight,
                                                child: ImageCapture(
                                                  filePath:
                                                      'images/profile/${_user.uid}',
                                                  manyPics: false,
                                                  collection: 'entreprise',
                                                )));
                                      },
                                      icon: Icon(Icons.edit),
                                      color: Colors.white,
                                      iconSize: 40.0,
                                    ))
                                : CachedNetworkImage(
                                    imageUrl: snapshot.data['photoURL'],
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover)),
                                            child: IconButton(
                                              onPressed: () async {
                                                String _uid =
                                                    snapshot.data.documentID;
                                                Navigator.of(context).push(
                                                    PageTransition(
                                                        type: PageTransitionType
                                                            .leftToRight,
                                                        child: ImageCapture(
                                                          filePath:
                                                              'images/profile/$_uid',
                                                          collection:
                                                              'entreprise',
                                                          manyPics: false,
                                                        )));
                                              },
                                              icon: Icon(Icons.edit),
                                              color: Colors.white,
                                              iconSize: 40.0,
                                            )),
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            customeCircularProgress,
                                    errorWidget: (context, url, error) =>
                                        Container(
                                            child: IconButton(
                                      onPressed: () async {
                                        String _uid = Provider.of<User>(context,
                                                listen: true)
                                            .uid;
                                        Navigator.of(context).push(
                                            PageTransition(
                                                type: PageTransitionType
                                                    .leftToRight,
                                                child: ImageCapture(
                                                  filePath:
                                                      'images/profile/$_uid',
                                                  collection: 'entreprise',
                                                  manyPics: false,
                                                )));
                                      },
                                      icon: Icon(Icons.edit),
                                      color: Colors.black,
                                      iconSize: 40.0,
                                    )),
                                  ),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildListDelegate([
                            Padding(
                              padding: EdgeInsets.only(
                                left: 20,
                                right: 20,
                                bottom: 20,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          FadeAnimation(
                                              1,
                                              Column(children: [
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      '${snapshot.data['titre']}',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 25),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        _editInfoDialog(
                                                            _user.uid,
                                                            'titre',
                                                            'Title',
                                                            context);
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.edit,
                                                            size: 13,
                                                            color: Colors.black,
                                                          ),
                                                          SizedBox(
                                                            width: 4,
                                                          ),
                                                          Text(
                                                            "Edit",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ])),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  FadeAnimation(
                                    1.2,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.article,
                                              color: Colors.black,
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              "Description",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        InkWell(
                                          onTap: () {
                                            _editInfoDialog(
                                                _user.uid,
                                                'description',
                                                'Description',
                                                context);
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.edit,
                                                size: 13,
                                                color: Colors.black,
                                              ),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                "Edit",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    height: 15,
                                    thickness: 2,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  FadeAnimation(
                                      1.2,
                                      Text(
                                        '${snapshot.data['description']}',
                                        style: TextStyle(
                                            color: Colors.grey, height: 1.4),
                                      )),
                                  FadeAnimation(
                                    1.2,
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ),
                                  FadeAnimation(
                                    1.2,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.business,
                                              color: Colors.black,
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              "Address",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        InkWell(
                                          onTap: () {
                                            _editInfoDialog(_user.uid,
                                                'adresse', 'Address', context);
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.edit,
                                                size: 13,
                                                color: Colors.black,
                                              ),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                "Edit",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    height: 15,
                                    thickness: 2,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  FadeAnimation(
                                      1.2,
                                      Text(
                                        '${snapshot.data['adresse']}',
                                        style: TextStyle(color: Colors.grey),
                                      )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  FadeAnimation(
                                    1.2,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.phone,
                                              color: Colors.black,
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              "Phone",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        InkWell(
                                          onTap: () {
                                            _editInfoDialog(_user.uid, 'tele',
                                                'phone', context);
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.edit,
                                                size: 13,
                                                color: Colors.black,
                                              ),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                "Edit",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    height: 15,
                                    thickness: 2,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  FadeAnimation(
                                      1.2,
                                      Text(
                                        '${snapshot.data['tele']}',
                                        style: TextStyle(color: Colors.grey),
                                      )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  FadeAnimation(
                                    1.2,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.mail,
                                              color: Colors.black,
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              "Email",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        InkWell(
                                          onTap: () {
                                            _editInfoDialog(_user.uid, 'email',
                                                'email', context);
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.edit,
                                                size: 13,
                                                color: Colors.black,
                                              ),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                "Edit",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    height: 15,
                                    thickness: 2,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  FadeAnimation(
                                      1.2,
                                      Text(
                                        '${snapshot.data['email']}',
                                        style: TextStyle(color: Colors.grey),
                                      )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  FadeAnimation(
                                    1.2,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.photo,
                                              color: Colors.black,
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              "Images",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        InkWell(
                                          onTap: () {
                                            //page where images will be taking care of
                                            Navigator.of(context).push(
                                                PageTransition(
                                                    child: ImagesSt(
                                                      userUID: snapshot
                                                          .data.documentID,
                                                    ),
                                                    type: PageTransitionType
                                                        .fade));
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.edit,
                                                size: 13,
                                                color: Colors.black,
                                              ),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                "Edit Images",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    height: 15,
                                    thickness: 2,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  FadeAnimation(
                                      1.8,
                                      Container(
                                        height: 200,
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: _imagesList
                                              .map((e) => makeVideo(
                                                  imageURL: e['photoURL']))
                                              .toList(),
                                        ),
                                      )),
                                  SizedBox(
                                    height: 60,
                                  )
                                ],
                              ),
                            )
                          ]),
                        )
                      ],
                    ),
                  ],
                );
            }
          }),
    );
  }

  Widget makeVideo({imageURL}) {
    return AspectRatio(
      child: CachedNetworkImage(
        imageUrl: imageURL,
        imageBuilder: (context, imageProvider) => Container(
          margin: EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
        ),
        placeholder: (context, url) => Container(
          height: 200,
          child: Center(child: customeCircularProgress),
        ),
        errorWidget: (context, url, error) => Container(
          height: 200,
          child: Center(
            child: Icon(Icons.error, color: Colors.black),
          ),
        ),
      ),
      aspectRatio: 1.5 / 1,
    );
  }
}
