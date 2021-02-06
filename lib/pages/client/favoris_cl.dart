import 'package:feul_delivery/pages/client/station_cl.dart';
import 'package:flutter/material.dart';
import 'package:feul_delivery/pages/client/drawer_cl.dart';

import 'index_cl.dart';

class FavSationCl extends StatefulWidget {
  @override
  _FavSationClState createState() => _FavSationClState();
}

class _FavSationClState extends State<FavSationCl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange[900],
        title: Text('Favoris'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) => Cl()));
            },
          ),
        ],
      ),
      drawer: drawerCL(),
      body: SingleChildScrollView(
        child: Column(
          children: [createCard()],
        ),
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
                            onPressed: null,
                            child: Icon(
                              Icons.favorite,
                              color: Colors.orange[900],
                            ),
                          ),
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
                          Text(
                            'Total - Centre ville',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
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
}