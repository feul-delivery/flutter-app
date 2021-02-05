import 'dart:io';
import 'package:feul_delivery/pages/client/favoris_cl.dart';
import 'package:flutter/material.dart';
import 'package:feul_delivery/styles/style_accueil_cl.dart';
import 'package:feul_delivery/pages/client/station_cl.dart';
import 'package:feul_delivery/pages/client/drawer_cl.dart';
import 'bbar_cl.dart';

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
                  new GestureDetector(
                    onTap: () => exit(0),
                    child: Text('OK'),
                  ),
                  SizedBox(height: 16),
                  new GestureDetector(
                    onTap: () => Navigator.of(context).pop(false),
                    child: Text('Annuler'),
                  ),
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
            margin: const EdgeInsets.fromLTRB(25.0, 35.0, 25.0, 15.0),
            child: Column(
              children: <Widget>[
                // TODOSwitch case for bottom bar
                BigStation(),
                Divider(height: 55.0),
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
                child: Text(
                  'Afficher tout',
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
                      name: 'Afriquia',
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
                  tag: 'taaag',
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
