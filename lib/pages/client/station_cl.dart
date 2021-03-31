import 'package:FD_flutter/shared/FadeAnimation.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:FD_flutter/pages/client/commanderPages/cmd_client.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

int like = 24;
int dislike = 9;

class StationProfilCl extends StatefulWidget {
  final DocumentSnapshot doc;
  StationProfilCl({@required this.doc});

  @override
  _StationProfilClState createState() => _StationProfilClState();
}

class _StationProfilClState extends State<StationProfilCl> {
  @override
  Widget build(BuildContext context) {
    String likeText = like.toString();
    String dislikeText = dislike.toString();
    var doc = widget.doc;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                expandedHeight: 200,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    background: doc.data['photoURL'] == null
                        ? Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/s4.png'),
                                    fit: BoxFit.cover)),
                            child: Container(),
                          )
                        : CachedNetworkImage(
                            imageUrl: doc.data['photoURL'],
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover)),
                              child: Container(),
                            ),
                            placeholder: (context, url) => Container(
                              height: 200,
                              child: Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.black,
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              height: 200,
                              child: Center(
                                child: Icon(Icons.error, color: Colors.black),
                              ),
                            ),
                          )),
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
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FadeAnimation(
                                0.2,
                                Container(
                                  width: 100,
                                  child: RaisedButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      setState(() {
                                        _changeText(0);
                                      });
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Row(children: [
                                          Icon(
                                            Icons.thumb_up,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            likeText,
                                            style: TextStyle(
                                                fontFamily: 'Gotham',
                                                color: Colors.grey,
                                                fontSize: 18),
                                          ),
                                        ])
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              FadeAnimation(
                                  0.2,
                                  Container(
                                    width: 100,
                                    child: RaisedButton(
                                      color: Colors.white,
                                      onPressed: () {
                                        setState(() {
                                          _changeText(1);
                                        });
                                      },
                                      child: Row(children: [
                                        Icon(
                                          Icons.thumb_down,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          dislikeText,
                                          style: TextStyle(
                                              fontFamily: 'Gotham',
                                              color: Colors.grey,
                                              fontSize: 18),
                                        ),
                                      ]),
                                    ),
                                  )),
                            ]),
                        FadeAnimation(
                          0.2,
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                FadeAnimation(
                                    1,
                                    Center(
                                      child: Text(
                                        doc['titre'],
                                        style: titleStyle,
                                      ),
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                        FadeAnimation(
                          0.2,
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
                                style: tileTitleStyle,
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 15,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FadeAnimation(
                            0.2,
                            Text(
                              doc['description'],
                              style: smallTileGray,
                            )),
                        FadeAnimation(
                          0.2,
                          SizedBox(
                            height: 20,
                          ),
                        ),
                        FadeAnimation(
                          0.2,
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
                                style: tileTitleStyle,
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 15,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FadeAnimation(
                            0.2,
                            Text(
                              doc['adresse'],
                              style: smallTileGray,
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          0.2,
                          Row(
                            children: [
                              Icon(
                                Icons.group,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Delivery",
                                style: tileTitleStyle,
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 15,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FadeAnimation(
                            0.2,
                            Text(
                              "4 deliveryman",
                              style: smallTileGray,
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          0.2,
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
                                style: tileTitleStyle,
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 15,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FadeAnimation(
                            0.2,
                            Text(
                              doc['tele'],
                              style: smallTileGray,
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          0.2,
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
                                style: tileTitleStyle,
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 15,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FadeAnimation(
                            0.2,
                            Text(
                              doc['email'],
                              style: smallTileGray,
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          0.2,
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
                                "Pictures",
                                style: tileTitleStyle,
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 15,
                          thickness: 1,
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
          Positioned.fill(
            bottom: 20,
            top: MediaQuery.of(context).size.height -
                MediaQuery.of(context).size.height * 1 / 12,
            left: MediaQuery.of(context).size.width -
                MediaQuery.of(context).size.width * 7 / 10,
            right: MediaQuery.of(context).size.width -
                MediaQuery.of(context).size.width * 7 / 10,
            child: FadeAnimation(
              2,
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ClientOrder(
                                doc: doc,
                              )));
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.green.shade400),
                  child: Text(
                    "Place an order",
                    style: buttonStyle,
                  ),
                ),
              ),
            ),
          )
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

void _changeText(int choix) {
  if (choix == 0) {
    like = like + 1;
  } else if (choix == 1) {
    dislike = dislike + 1;
  }
}
