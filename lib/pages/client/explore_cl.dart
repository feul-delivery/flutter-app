import 'package:feul_delivery/pages/client/station_cl.dart';
import 'package:flutter/material.dart';
import 'package:feul_delivery/pages/client/drawer_cl.dart';
import 'bbar_cl.dart';
import 'index_cl.dart';

class ListSationCl extends StatefulWidget {
  @override
  _ListSationClState createState() => _ListSationClState();
}

class _ListSationClState extends State<ListSationCl> {
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Explorer');
  Icon _adoreIcon;
  int adore = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        selectedIndex = 0;
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) => Cl()));
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.red[900],
          title: _appBarTitle,
          actions: <Widget>[
            IconButton(
              icon: new Icon(Icons.search),
              onPressed: _searchPressed,
            ),
          ],
        ),
        drawer: drawerCL(),
        body: SingleChildScrollView(
          child: Column(
            children: [createCard()],
          ),
        ),
        bottomNavigationBar: ButtomBARWidget(),
      ),
    );
  }

  Container createCard() {
    return Container(
      height: 230,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StationProfilCl()));
                    },
                    child: Stack(
                      children: [
                        Ink.image(
                          height: 100,
                          image: AssetImage(
                            'assets/Station3.png',
                          ),
                          fit: BoxFit.fitWidth,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: FloatingActionButton(
                              backgroundColor: Colors.white.withOpacity(0),
                              onPressed: () {
                                setState(() {
                                  _changeFav();
                                });
                              },
                              child: _adoreIcon),
                        )
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StationProfilCl()));
                            },
                            child: Text(
                              'Total - Centre ville',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            'Av. Mohammed V,Centre villed. Fès',
                            style: TextStyle(color: Colors.black54),
                          ),
                          Container(
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: null,
                                  icon: Icon(
                                    Icons.phone,
                                    color: Colors.green,
                                  ),
                                ),
                                IconButton(
                                  onPressed: null,
                                  icon: Icon(Icons.chat),
                                ),
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
                                            style: TextStyle(
                                                color: Colors.blue[800]),
                                          ),
                                        ],
                                      )),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  alignment: Alignment.topCenter,
                                  child: FlatButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    StationProfilCl()));
                                      },
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

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search), hintText: 'Rechercher...'),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Explorer');
      }
    });
  }

  void _changeFav() {
    if (adore == 0) {
      _adoreIcon = new Icon(
        Icons.favorite,
        color: Colors.white,
      );
      adore = 1;
    } else {
      _adoreIcon = new Icon(
        Icons.favorite,
        color: Colors.red[900],
      );
      adore = 0;
    }
  }
}
