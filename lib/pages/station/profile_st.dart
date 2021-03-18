import 'dart:io';
import 'package:FD_flutter/pages/station/index_st.dart';
import 'package:FD_flutter/services/database.dart';
import 'package:FD_flutter/services/profile_picture.dart';
import 'package:FD_flutter/shared/FadeAnimation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

String profileURL;

class ProfilSt extends StatefulWidget {
  @override
  _ProfilStState createState() => _ProfilStState();
}

class _ProfilStState extends State<ProfilSt> {
  String titre = "N/A";
  String titreTmp;
  String descriptionTmp;
  String emailTmp;
  String teleTmp;
  String adresseTmp;
  String description = "N/A";
  String email = "N/A";
  String tele = "N/A";
  String adresse = "N/A";
  var uid;
  @override
  // ignore: must_call_super
  void initState() {
    getEntData();
  }

  Future getEntData() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    uid = user.uid;

    Firestore.instance
        .collection('entreprise')
        .document(uid)
        .get()
        .then((value) async {
      print(uid);
      if (value.exists) {
        var key1 = await value.data['titre'];
        var key2 = await value.data['description'];
        var key3 = await value.data['email'];
        var key4 = await value.data['tele'];
        var key5 = await value.data['adresse'];
        print(key1);
        setState(() {
          this.titre = key1;
          this.description = key2;
          this.email = key3;
          this.tele = key4;
          this.adresse = key5;
        });
      }
    });
  }

  final picker = ImagePicker();

  Future<File> getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    print('naaaaani');
    return null;
  }

  void _showImageSettingsPanel() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            margin: EdgeInsets.all(50),
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    File profileImage = await getImage(ImageSource.camera);
                    if (profileImage != null) {
                      profileURL = await uploadFile(profileImage);
                      setState(() {
                        IndexSt.entreprise.photoURL = profileURL;
                      });
                    }
                  },
                  child: Material(
                      color: Colors.red[900],
                      borderRadius: BorderRadius.circular(10.0),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Icon(Icons.camera_alt,
                            color: Colors.white, size: 40.0),
                      ))),
                ),
                InkWell(
                  onTap: () async {
                    File profileImage = await getImage(ImageSource.gallery);
                    if (profileImage != null) {
                      profileURL = await uploadFile(profileImage);
                      setState(() {
                        IndexSt.entreprise.photoURL = profileURL;
                      });
                    }
                  },
                  child: Material(
                      color: Colors.red[900],
                      borderRadius: BorderRadius.circular(10.0),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child:
                            Icon(Icons.photo, color: Colors.white, size: 40.0),
                      ))),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 200,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: IndexSt.entreprise?.photoURL == null
                                  ? AssetImage('assets/s4.png')
                                  : NetworkImage(IndexSt.entreprise.photoURL),
                              fit: BoxFit.cover)),
                      child: IconButton(
                        onPressed: () async {
                          _showImageSettingsPanel();
                        },
                        icon: Icon(Icons.edit),
                        color: Colors.white,
                        iconSize: 40.0,
                      )),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            titre,
                                            style: TextStyle(
                                                color: Colors.grey[800],
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text('Edit nom'),
                                                      content: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              decoration: BoxDecoration(
                                                                  border: Border(
                                                                      bottom: BorderSide(
                                                                          color:
                                                                              Colors.grey[200]))),
                                                              child: TextField(
                                                                decoration:
                                                                    InputDecoration(
                                                                  hintText:
                                                                      "$titre",
                                                                  hintStyle: TextStyle(
                                                                      color: Colors
                                                                          .grey),
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                ),
                                                                onChanged:
                                                                    (val) {
                                                                  setState(() =>
                                                                      titreTmp =
                                                                          val);
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
                                                                onPressed:
                                                                    () async {
                                                                  await DatabaseService(uid: uid).updateEntrepriseData(
                                                                      titre:
                                                                          titreTmp,
                                                                      address:
                                                                          adresse,
                                                                      description:
                                                                          description,
                                                                      tele:
                                                                          tele,
                                                                      email:
                                                                          email);
                                                                  titre =
                                                                      titreTmp;
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  setState(
                                                                      () {});
                                                                },
                                                                child: Text(
                                                                    "Change",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .red[900]))),
                                                            FlatButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child: Text(
                                                                    "Cancel",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .red[900]))),
                                                          ],
                                                        ),
                                                      ],
                                                    );
                                                  });
                                            },
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.edit,
                                                  size: 13,
                                                  color: Colors.red[900],
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  "Edit",
                                                  style: TextStyle(
                                                    color: Colors.red[800],
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.article,
                                    color: Colors.red[900],
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Description",
                                    style: TextStyle(
                                        color: Colors.grey[800],
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Edit description'),
                                          content: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              color: Colors
                                                                  .grey[200]))),
                                                  child: TextField(
                                                    decoration: InputDecoration(
                                                      hintText: "$description",
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey),
                                                      border: InputBorder.none,
                                                    ),
                                                    onChanged: (val) {
                                                      setState(() =>
                                                          descriptionTmp = val);
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
                                                      await DatabaseService(
                                                              uid: uid)
                                                          .updateEntrepriseData(
                                                              titre: titre,
                                                              address: adresse,
                                                              description:
                                                                  descriptionTmp,
                                                              tele: tele,
                                                              email: email);
                                                      description =
                                                          descriptionTmp;
                                                      Navigator.of(context)
                                                          .pop();
                                                      setState(() {});
                                                    },
                                                    child: Text("Change",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .red[900]))),
                                                FlatButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text("Cancel",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .red[900]))),
                                              ],
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.edit,
                                      size: 13,
                                      color: Colors.red[900],
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      "Edit",
                                      style: TextStyle(
                                        color: Colors.red[800],
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
                              "$description",
                              style: TextStyle(color: Colors.grey, height: 1.4),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.business,
                                    color: Colors.red[900],
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Address",
                                    style: TextStyle(
                                        color: Colors.grey[800],
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Edit address'),
                                          content: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              color: Colors
                                                                  .grey[200]))),
                                                  child: TextField(
                                                    decoration: InputDecoration(
                                                      hintText: "$adresse",
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey),
                                                      border: InputBorder.none,
                                                    ),
                                                    onChanged: (val) {
                                                      setState(() =>
                                                          adresseTmp = val);
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
                                                      await DatabaseService(
                                                              uid: uid)
                                                          .updateEntrepriseData(
                                                              titre: titre,
                                                              address:
                                                                  adresseTmp,
                                                              description:
                                                                  description,
                                                              tele: tele,
                                                              email: email);
                                                      adresse = adresseTmp;
                                                      Navigator.of(context)
                                                          .pop();
                                                      setState(() {});
                                                    },
                                                    child: Text("Change",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .red[900]))),
                                                FlatButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text("Cancel",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .red[900]))),
                                              ],
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.edit,
                                      size: 13,
                                      color: Colors.red[900],
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      "Edit",
                                      style: TextStyle(
                                        color: Colors.red[800],
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
                              "$adresse",
                              style: TextStyle(color: Colors.grey),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          1.2,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.phone,
                                    color: Colors.red[900],
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Phone",
                                    style: TextStyle(
                                        color: Colors.grey[800],
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Change phone'),
                                          content: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              color: Colors
                                                                  .grey[200]))),
                                                  child: TextField(
                                                    decoration: InputDecoration(
                                                      hintText: "$tele",
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey),
                                                      border: InputBorder.none,
                                                    ),
                                                    onChanged: (val) {
                                                      setState(
                                                          () => teleTmp = val);
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
                                                      await DatabaseService(
                                                              uid: uid)
                                                          .updateEntrepriseData(
                                                              titre: titre,
                                                              address: adresse,
                                                              description:
                                                                  description,
                                                              tele: teleTmp,
                                                              email: email);
                                                      tele = teleTmp;
                                                      Navigator.of(context)
                                                          .pop();
                                                      setState(() {});
                                                    },
                                                    child: Text("Change",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .red[900]))),
                                                FlatButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text("Cancel",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .red[900]))),
                                              ],
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.edit,
                                      size: 13,
                                      color: Colors.red[900],
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      "Edit",
                                      style: TextStyle(
                                        color: Colors.red[800],
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
                              "$tele",
                              style: TextStyle(color: Colors.grey),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          1.2,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.mail,
                                    color: Colors.red[900],
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Email",
                                    style: TextStyle(
                                        color: Colors.grey[800],
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Edit Email'),
                                          content: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              color: Colors
                                                                  .grey[200]))),
                                                  child: TextField(
                                                    decoration: InputDecoration(
                                                      hintText: "$email",
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey),
                                                      border: InputBorder.none,
                                                    ),
                                                    onChanged: (val) {
                                                      setState(
                                                          () => emailTmp = val);
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
                                                      await DatabaseService(
                                                              uid: uid)
                                                          .updateEntrepriseData(
                                                              titre: titre,
                                                              address: adresse,
                                                              description:
                                                                  description,
                                                              tele: tele,
                                                              email: emailTmp);
                                                      email = emailTmp;
                                                      Navigator.of(context)
                                                          .pop();
                                                      setState(() {});
                                                    },
                                                    child: Text("Change",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .red[900]))),
                                                FlatButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text("Cancel",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .red[900]))),
                                              ],
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.edit,
                                      size: 13,
                                      color: Colors.red[900],
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      "Edit",
                                      style: TextStyle(
                                        color: Colors.red[800],
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
                              "$email",
                              style: TextStyle(color: Colors.grey),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          1.2,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.photo,
                                    color: Colors.red[900],
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Images",
                                    style: TextStyle(
                                        color: Colors.grey[800],
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {},
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.edit,
                                      size: 13,
                                      color: Colors.red[900],
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      "Edit",
                                      style: TextStyle(
                                        color: Colors.red[800],
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
      ),
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
