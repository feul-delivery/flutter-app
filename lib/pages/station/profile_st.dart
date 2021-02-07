import 'package:feul_delivery/animations/FadeAnimation.dart';
import 'package:flutter/material.dart';

class ProfilSt extends StatefulWidget {
  @override
  _ProfilStState createState() => _ProfilStState();
}

class _ProfilStState extends State<ProfilSt> {
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
                              image: AssetImage('assets/s4.png'),
                              fit: BoxFit.cover)),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 40.0,
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
                                            "Total - Centre ville",
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
                                                      title:
                                                          Text('Modifier nom'),
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
                                                                      "Total - Centre ville",
                                                                  hintStyle: TextStyle(
                                                                      color: Colors
                                                                          .grey),
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                ),
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
                                                                    () {},
                                                                child: Text(
                                                                    "Changer",
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
                                                                    "Annuler",
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
                                                  "Modifier",
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
                                          title: Text('Modifier description'),
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
                                                      hintText: "...",
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey),
                                                      border: InputBorder.none,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            Row(
                                              children: [
                                                FlatButton(
                                                    onPressed: () {},
                                                    child: Text("Changer",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .red[900]))),
                                                FlatButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text("Annuler",
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
                                      "Modifier",
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
                              "On sait depuis longtemps que travailler avec du texte lisible et contenant du sens est source de distractions, et empêche de se concentrer sur la mise en page elle-même.",
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
                                    "Addresse",
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
                                          title: Text('Modifier addresse'),
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
                                                      hintText:
                                                          "Rue Sefrou, Narjiss, Fés, Maroc",
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey),
                                                      border: InputBorder.none,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            Row(
                                              children: [
                                                FlatButton(
                                                    onPressed: () {},
                                                    child: Text("Changer",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .red[900]))),
                                                FlatButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text("Annuler",
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
                                      "Modifier",
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
                              "Rue Sefrou, Narjiss, Fés, Maroc",
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
                                    "Tél",
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
                                          title: Text('Modifier tél'),
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
                                                      hintText:
                                                          "+212654543476",
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey),
                                                      border: InputBorder.none,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            Row(
                                              children: [
                                                FlatButton(
                                                    onPressed: () {},
                                                    child: Text("Changer",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .red[900]))),
                                                FlatButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text("Annuler",
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
                                      "Modifier",
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
                              "+212654543476",
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
                                          title: Text('Modifier Email'),
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
                                                      hintText:
                                                          "contact@total.ma",
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey),
                                                      border: InputBorder.none,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            Row(
                                              children: [
                                                FlatButton(
                                                    onPressed: () {},
                                                    child: Text("Changer",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .red[900]))),
                                                FlatButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text("Annuler",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .red[900]))),
                                              ],
                                            ),
                                          ],
                                        );
                                      });},
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
                                      "Modifier",
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
                              "contact@total.ma",
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
                                      "Modifier",
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
