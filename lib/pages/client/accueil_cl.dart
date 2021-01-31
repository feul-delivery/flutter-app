import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:feul_delivery/styles/style_accueil_cl.dart';
import 'package:feul_delivery/pages/client/station_profil_cl.dart';
import 'package:page_transition/page_transition.dart';

class Cl extends StatelessWidget {
  final title = Center(
    heightFactor: 2.5,
    child: Text('Feul delivery', style: titleStyle),
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
        backgroundColor: Colors.black,
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
      ),
    );
  }
}

class BottomNavigationBarCl extends StatefulWidget {
  static const _iconSize = 30.0;

  @override
  _BottomNavigationBarClState createState() => _BottomNavigationBarClState();
}

class _BottomNavigationBarClState extends State<BottomNavigationBarCl> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      shape: CircularNotchedRectangle(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 7.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(
                OMIcons.home,

                size: BottomNavigationBarCl._iconSize,
                color: Colors.orange[900],
              ),
              onPressed: () {
                setState(() {
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade, child: Cl()));
                });
              },
            ),
            IconButton(
              icon: Icon(
                OMIcons.explore,
                size: BottomNavigationBarCl._iconSize,
                color: Colors.orange[900],
              ),
              onPressed: () {
                setState(() {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: ListSationCl()));
                });
              },
            ),
            IconButton(
              icon: Icon(
                OMIcons.accountCircle,
                size: BottomNavigationBarCl._iconSize,
                color: Colors.orange[900],
              ),
              onPressed: null,
            ),
          ],
        ),
      ),
    );
  }
}

class ListSationCl extends StatefulWidget {
  @override
  _ListSationClState createState() => _ListSationClState();
}

class _ListSationClState extends State<ListSationCl> {
  Icon _searchIcon = new Icon(Icons.search);

  Widget _appBarTitle = new Text('Search...');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange[900],
        title: _appBarTitle,
        leading: new IconButton(
          icon: new Icon(Icons.search),
          onPressed: _searchPressed,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.orange[900],
          Colors.orange[800],
          Colors.orange[400]
        ])),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StationProfilCl()));
                },
                child: Container(
                  child: new FittedBox(
                    child: Material(
                        color: Colors.white,
                        elevation: 14.0,
                        borderRadius: BorderRadius.circular(24.0),
                        shadowColor: Color(0x802196F3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Container(
                                          child: Text(
                                        "Total",
                                        style: TextStyle(
                                            color: Color(0xffe6020a),
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 1.0),
                                      child: Container(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Container(
                                              child: Text(
                                            "32KM \u00B7 ",
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 18.0,
                                            ),
                                          )),
                                          Container(
                                              child: Text(
                                            "443",
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 18.0,
                                            ),
                                          )),
                                          Container(
                                            child: Icon(
                                              FontAwesomeIcons.solidStar,
                                              color: Colors.amber,
                                              size: 15.0,
                                            ),
                                          ),
                                        ],
                                      )),
                                    ),
                                    Container(
                                        child: Text(
                                      "Alwafae \u00B7 fes",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 200,
                              height: 150,
                              child: ClipRRect(
                                borderRadius: new BorderRadius.circular(24.0),
                                child: Image.asset(
                                  'assets/Feuldelivery.png',
                                  alignment: Alignment.centerRight,
                                  fit: BoxFit.scaleDown,
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.width - 150,
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StationProfilCl()));
                },
                child: Container(
                  child: new FittedBox(
                    child: Material(
                        color: Colors.white,
                        elevation: 14.0,
                        borderRadius: BorderRadius.circular(24.0),
                        shadowColor: Color(0x802196F3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Container(
                                          child: Text(
                                        "Afriqia",
                                        style: TextStyle(
                                            color: Color(0xffe6020a),
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 1.0),
                                      child: Container(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Container(
                                              child: Text(
                                            "22KM \u00B7 ",
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 18.0,
                                            ),
                                          )),
                                          Container(
                                              child: Text(
                                            "243 ",
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 18.0,
                                            ),
                                          )),
                                          Container(
                                            child: Icon(
                                              FontAwesomeIcons.solidStar,
                                              color: Colors.amber,
                                              size: 15.0,
                                            ),
                                          ),
                                        ],
                                      )),
                                    ),
                                    Container(
                                        child: Text(
                                      "sedrou \u00B7 fes",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 200,
                              height: 150,
                              child: ClipRRect(
                                borderRadius: new BorderRadius.circular(24.0),
                                child: Image.asset(
                                  'assets/Feuldelivery.png',
                                  alignment: Alignment.centerRight,
                                  fit: BoxFit.fitHeight,
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.width - 150,
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StationProfilCl()));
                },
                child: Container(
                  child: new FittedBox(
                    child: Material(
                        color: Colors.white,
                        elevation: 14.0,
                        borderRadius: BorderRadius.circular(24.0),
                        shadowColor: Color(0x802196F3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Container(
                                          child: Text(
                                        "Total",
                                        style: TextStyle(
                                            color: Color(0xffe6020a),
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 1.0),
                                      child: Container(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Container(
                                              child: Text(
                                            "22KM \u00B7 ",
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 18.0,
                                            ),
                                          )),
                                          Container(
                                              child: Text(
                                            "243 ",
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 18.0,
                                            ),
                                          )),
                                          Container(
                                            child: Icon(
                                              FontAwesomeIcons.solidStar,
                                              color: Colors.amber,
                                              size: 15.0,
                                            ),
                                          ),
                                        ],
                                      )),
                                    ),
                                    Container(
                                        child: Text(
                                      "sedrou \u00B7 fes",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 200,
                              height: 150,
                              child: ClipRRect(
                                borderRadius: new BorderRadius.circular(24.0),
                                child: Image.asset(
                                  'assets/Feuldelivery.png',
                                  alignment: Alignment.centerRight,
                                  fit: BoxFit.fitHeight,
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.width - 150,
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StationProfilCl()));
                },
                child: Container(
                  child: new FittedBox(
                    child: Material(
                        color: Colors.white,
                        elevation: 14.0,
                        borderRadius: BorderRadius.circular(24.0),
                        shadowColor: Color(0x802196F3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Container(
                                          child: Text(
                                        "Total",
                                        style: TextStyle(
                                            color: Color(0xffe6020a),
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 1.0),
                                      child: Container(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Container(
                                              child: Text(
                                            "22KM \u00B7 ",
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 18.0,
                                            ),
                                          )),
                                          Container(
                                              child: Text(
                                            "243 ",
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 18.0,
                                            ),
                                          )),
                                          Container(
                                            child: Icon(
                                              FontAwesomeIcons.solidStar,
                                              color: Colors.amber,
                                              size: 15.0,
                                            ),
                                          ),
                                        ],
                                      )),
                                    ),
                                    Container(
                                        child: Text(
                                      "sedrou \u00B7 fes",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 200,
                              height: 150,
                              child: ClipRRect(
                                borderRadius: new BorderRadius.circular(24.0),
                                child: Image.asset(
                                  'assets/Feuldelivery.png',
                                  alignment: Alignment.centerRight,
                                  fit: BoxFit.fitHeight,
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.width - 150,
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarCl(),
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search), hintText: 'Search...'),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Search Example');
      }
    });
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
