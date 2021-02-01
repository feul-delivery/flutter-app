import 'dart:io';
import 'package:flutter/material.dart';
import 'package:feul_delivery/styles/style_accueil_cl.dart';
import 'package:feul_delivery/pages/client/station_profil_cl.dart';
import 'package:feul_delivery/pages/client/Bottom_Navigation_Bar_Cl.dart';
import 'package:feul_delivery/pages/client/drawer_Cl.dart';

class Cl extends StatelessWidget {
  final title = Center(
    heightFactor: 2.5,
    child: Text('Feul delivery',
        style: TextStyle(
            fontSize: 23.0,
            fontWeight: FontWeight.w900,
            letterSpacing: 2.5,
            color: Colors.black)),
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return showDialog(
              context: context,
              builder: (context) => new AlertDialog(
                title: new Text('Etes-vous sur ?'),
                content: new Text('Exit lapplication?'),
                actions: <Widget>[
                  new GestureDetector(
                    onTap: () => exit(0),
                    child: Text('oui'),
                  ),
                  SizedBox(height: 16),
                  new GestureDetector(
                    onTap: () => Navigator.of(context).pop(false),
                    child: Text('no'),
                  ),
                ],
              ),
            ) ??
            false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title:title,backgroundColor: Colors.orange[900],centerTitle: true,),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            margin: const EdgeInsets.fromLTRB(25.0, 35.0, 25.0, 15.0),
            child: Column(
              children: <Widget>[
                title,
                // TODOSwitch case for bottom bar
                BigStation(),
                Divider(height: 55.0),
                SmallStation(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBarCl(),
        drawer: DrawerCL(),
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
                'near you',
                style: tileTitleStyle,
              ),
              Opacity(
                opacity: 0.6,
                child: Text(
                  'Show all',
                  style: filterStyle,
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Row(
              children: <Widget>[
                Flexible(
                    flex: 5,
                    child: SmallProductTile(
                      name: 'Afriqia',
                      distance: 9,
                      asset: 'assets/Feuldelivery.png',
                      padding: const EdgeInsets.only(left: 14.0),
                    )),
                Flexible(
                  flex: 5,
                  child: SmallProductTile(
                    name: 'shell',
                    distance: 19,
                    asset: 'assets/Feuldelivery.png',
                    padding: const EdgeInsets.only(left: 14.0),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Row(
              children: <Widget>[
                Flexible(
                  flex: 5,
                  child: SmallProductTile(
                    name: 'Afriqia',
                    distance: 49,
                    asset: 'assets/Feuldelivery.png',
                    padding: const EdgeInsets.only(right: 14.0),
                  ),
                ),
                Flexible(
                  flex: 5,
                  child: SmallProductTile(
                    name: 'shell',
                    distance: 99,
                    asset: 'assets/Feuldelivery.png',
                    padding: const EdgeInsets.only(left: 14.0),
                  ),
                ),
              ],
            ),
          ),
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
                  'Best of the week',
                  style: tileTitleStyle,
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Hero(
                  tag: 'taaag',
                  child: Image.asset(
                    'assets/emma.jpg',
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width - 150,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: tileItemStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SmallProductTile extends StatelessWidget {
  final String name;
  final int distance;
  final String asset;
  final EdgeInsets padding;

  SmallProductTile({
    @required this.name,
    @required this.distance,
    @required this.asset,
    @required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              asset,
              fit: BoxFit.fill,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('$name', style: smallTileName),
                Text('$distance Km', style: smallTileP),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
