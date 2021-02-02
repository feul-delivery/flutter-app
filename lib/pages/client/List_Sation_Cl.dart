import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:feul_delivery/pages/client/drawer_Cl.dart';
import 'package:feul_delivery/pages/client/station_profil_cl.dart';
import 'package:feul_delivery/pages/client/Bottom_Navigation_Bar_Cl.dart';

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
      drawer: DrawerCL(),
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
