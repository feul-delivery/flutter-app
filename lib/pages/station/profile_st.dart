import 'package:FD_flutter/modules/user.dart';
// import 'package:FD_flutter/pages/station/index_st.dart';
// import 'package:FD_flutter/services/database.dart';
import 'package:FD_flutter/shared/image_capture.dart';
import 'package:FD_flutter/shared/FadeAnimation.dart';
import 'package:page_transition/page_transition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

String profileURL;

class ProfilSt extends StatefulWidget {
  @override
  _ProfilStState createState() => _ProfilStState();
}

class _ProfilStState extends State<ProfilSt> {
  // String titre = "N/A";
  // String titreTmp;
  // String descriptionTmp;
  // String emailTmp;
  // String teleTmp;
  // String adresseTmp;
  // String description = "N/A";
  // String email = "N/A";
  // String tele = "N/A";
  // String adresse = "N/A";
  // var uid;
  // @override
  // ignore: must_call_super
  // void initState() {
  //   getEntData();
  // }

  // Future getEntData() async {
  //   final FirebaseAuth auth = FirebaseAuth.instance;
  //   final FirebaseUser user = await auth.currentUser();
  //   uid = user.uid;

  //   Firestore.instance
  //       .collection('entreprise')
  //       .document(uid)
  //       .get()
  //       .then((value) async {
  //     print(uid);
  //     if (value.exists) {
  //       var key1 = await value.data['titre'];
  //       var key2 = await value.data['description'];
  //       var key3 = await value.data['email'];
  //       var key4 = await value.data['tele'];
  //       var key5 = await value.data['adresse'];
  //       print(key1);
  //       setState(() {
  //         this.titre = key1;
  //         this.description = key2;
  //         this.email = key3;
  //         this.tele = key4;
  //         this.adresse = key5;
  //       });
  //     }
  //   });
  // }

  // final picker = ImagePicker();

  // Future<File> getImage(ImageSource source) async {
  //   final pickedFile = await ImagePicker.pickImage(source: source);
  //   if (pickedFile != null) {
  //     return File(pickedFile.path);
  //   }
  //   print('naaaaani');
  //   return null;
  // }

  // void _showImageSettingsPanel() {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (context) {
  //         return Container(
  //           margin: EdgeInsets.all(50),
  //           padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               InkWell(
  //                 onTap: () async {
  //                   File profileImage = await getImage(ImageSource.camera);
  //                   if (profileImage != null) {
  //                     profileURL = await uploadFile(profileImage);
  //                     setState(() {
  //                       IndexSt.entreprise?.photoURL = profileURL;
  //                     });
  //                   }
  //                 },
  //                 child: Material(
  //                     color: Colors.black,
  //                     borderRadius: BorderRadius.circular(10.0),
  //                     child: Center(
  //                         child: Padding(
  //                       padding: const EdgeInsets.all(20.0),
  //                       child: Icon(Icons.camera_alt,
  //                           color: Colors.white, size: 40.0),
  //                     ))),
  //               ),
  //               InkWell(
  //                 onTap: () async {
  //                   File profileImage = await getImage(ImageSource.gallery);
  //                   if (profileImage != null) {
  //                     profileURL = await uploadFile(profileImage);
  //                     setState(() {
  //                       IndexSt.entreprise?.photoURL = profileURL;
  //                     });
  //                   }
  //                 },
  //                 child: Material(
  //                     color: Colors.black,
  //                     borderRadius: BorderRadius.circular(10.0),
  //                     child: Center(
  //                         child: Padding(
  //                       padding: const EdgeInsets.all(20.0),
  //                       child:
  //                           Icon(Icons.photo, color: Colors.white, size: 40.0),
  //                     ))),
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  // }

  void _editInfoDialog(
      String uid, String field, String fieldName, BuildContext context) {
    String _value;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection('entreprise')
              .document(_user.uid)
              .get()
              .asStream(),
          builder: (context, snapshot) {
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
                                        image: AssetImage('assets/total.png'),
                                        fit: BoxFit.cover)),
                                child: IconButton(
                                  onPressed: () async {
                                    Navigator.of(context).push(PageTransition(
                                        type: PageTransitionType.leftToRight,
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
                                            String _uid = Provider.of<User>(
                                                    context,
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
                                          color: Colors.white,
                                          iconSize: 40.0,
                                        )),
                                progressIndicatorBuilder: (context, url,
                                        downloadProgress) =>
                                    CircularProgressIndicator(
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                        backgroundColor: Colors.black,
                                        value: downloadProgress.progress),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error, color: Colors.black),
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
                                    mainAxisAlignment: MainAxisAlignment.end,
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
                                                          color: Colors.black,
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
                                        _editInfoDialog(_user.uid, 'adresse',
                                            'Address', context);
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
                                  1.8,
                                  Container(
                                    height: 200,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: <Widget>[
                                        makeVideo(image: 'assets/s4.png'),
                                        makeVideo(image: 'assets/s4.png'),
                                        makeVideo(image: 'assets/s4.png'),
                                      ],
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
          }),
    );
  }

  Widget makeVideo({image}) {
    return AspectRatio(
      aspectRatio: 1.5 / 1,
      child: Container(
        margin: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image:
                DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
      ),
    );
  }
}
