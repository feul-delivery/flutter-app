import 'package:feul_delivery/animations/FadeAnimation.dart';
import 'package:flutter/material.dart';

int like = 10;
int dislike = 10;

class StationProfilCl extends StatefulWidget {
  @override
  _StationProfilClState createState() => _StationProfilClState();
}

class _StationProfilClState extends State<StationProfilCl> {
  @override
  Widget build(BuildContext context) {
    String likeText = like.toString();
    String dislikeText = dislike.toString();
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
                            image: AssetImage('assets/Station3.png'),
                            fit: BoxFit.cover)),
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            FadeAnimation(
                                1,
                                Text(
                                  "Total - Centre ville",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
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
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FadeAnimation(
                                1.2,
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
                                  1.2,
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
                                              color: Colors.grey, fontSize: 18),
                                        ),
                                      ]),
                                    ),
                                  )),
                            ]),
                        FadeAnimation(
                          1.2,
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
                            children: [
                              Icon(
                                Icons.group,
                                color: Colors.red[900],
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Livreurs",
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
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
                              "4 Livreurs",
                              style: TextStyle(color: Colors.grey),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          1.2,
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
                                  makeVideo(image: 'assets/Station3.png'),
                                  makeVideo(image: 'assets/Station3.png'),
                                  makeVideo(image: 'assets/Station3.png'),
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
            child: Container(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FadeAnimation(
                  2,
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 80),
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red[900]),
                    child: Align(
                        child: Text(
                      "Faire une commande",
                      style: TextStyle(color: Colors.white),
                    )),
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
