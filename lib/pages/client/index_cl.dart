import 'dart:io';
import 'package:feul_delivery/pages/client/favoris_cl.dart';
import 'package:flutter/material.dart';
import 'package:feul_delivery/styles/style_accueil_cl.dart';
import 'package:feul_delivery/pages/client/station_cl.dart';
import 'package:feul_delivery/pages/client/drawer_cl.dart';
import 'bbar_cl.dart';
import 'explore_cl.dart';

class Cl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return showDialog(
              context: context,
              builder: (context) => new AlertDialog(
                title: new Text('Etes-vous sur?'),
                content: new Text("Quitter l'application?"),
                actions: <Widget>[
                  Row(children: [
                    new FlatButton(
                      onPressed: () => exit(0),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 0.0, bottom: 0.0, top: 10),
                        child: Text(
                          'OK',
                          style: TextStyle(color: Colors.orange[900]),
                        ),
                      ),
                    ),
                    new FlatButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 0.0, bottom: 0.0, top: 10),
                        child: Text(
                          'Annuler',
                          style: TextStyle(color: Colors.orange[900]),
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
            ) ??
            false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Acceuil"),
          backgroundColor: Colors.orange[900],
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.favorite),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => FavSationCl()));
                })
          ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            margin: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
            child: Column(
              children: <Widget>[
                // TODOSwitch case for bottom bar
                BigStation(),
                SizedBox(
                  height: 20,
                ),
                SmallStation(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: ButtomBARWidget(),
        drawer: drawerCL(),
      ),
    );
  }
}

class SmallStation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Près de vous',
                style: tileTitleStyle,
              ),
              Opacity(
                opacity: 0.6,
                child: GestureDetector(
                  onTap: () {
                    selectedIndex = 1;
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => ListSationCl()));
                  },
                  child: Text(
                    'Afficher tout',
                    style: filterStyle,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            thickness: 1,
            height: 10,
          ),
          createSmallCard(),
          createSmallCard(),
          createSmallCard()
        ],
      ),
    );
  }
}

class BigStation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => StationProfilCl()));
      },
      child: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Le meilleur de la semaine',
                  style: tileTitleStyle,
                ),
              ],
            ),
            Divider(
              height: 10,
              thickness: 1,
            ),
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Hero(
                  tag: 'tage',
                  child: Image.asset(
                    'assets/Station3.png',
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width - 150,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Container createSmallCard() {
  return Container(
    height: 230,
    child: Container(
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {},
                  child: Stack(
                    children: [
                      Ink.image(
                        height: 100,
                        image: AssetImage(
                          'assets/Station3.png',
                        ),
                        fit: BoxFit.fitWidth,
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      top: 10,
                      right: 10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Column(children: [
                                  Text(
                                    'Total - Centre ville',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Av. Mohammed V,Centre villed. Fès',
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ]),
                              ),
                              Positioned(
                                right: 0,
                                child: Container(
                                  height: 25,
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.orange[900],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5.0, right: 5.0),
                                    child: Center(
                                        child: Row(children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "15 Km",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ])),
                                  ),
                                ),
                              ),
                            ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.topCenter,
                              child: FlatButton(
                                  onPressed: () {},
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.near_me,
                                        color: Colors.blue[800],
                                      ),
                                      Text(
                                        'Commander',
                                        style:
                                            TextStyle(color: Colors.blue[800]),
                                      ),
                                    ],
                                  )),
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              alignment: Alignment.topCenter,
                              child: FlatButton(
                                  onPressed: () {},
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.read_more,
                                      ),
                                      Text(
                                        'Details',
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
