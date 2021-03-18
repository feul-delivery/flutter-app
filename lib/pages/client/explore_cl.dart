import 'package:FD_flutter/pages/client/index_cl.dart';
import 'package:FD_flutter/pages/client/station_cl.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:FD_flutter/pages/client/drawer_cl.dart';
import 'bbar_cl.dart';

class ExploreCl extends StatefulWidget {
  @override
  _ExploreClState createState() => _ExploreClState();
}

class _ExploreClState extends State<ExploreCl> {
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Explore', style: pageTitle);
  Icon _adoreIcon;
  int adore = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        ButtomBarCl.selectedIndex = 0;
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => IndexCl()));
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
        drawer: DrawerCL(),
        body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('entreprise').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Icon(Icons.cancel, color: Colors.red[900]);
            }

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return SizedBox(
                    child: Center(
                        child: CircularProgressIndicator(
                            backgroundColor: Colors.red[900])));
              case ConnectionState.none:
                return Icon(Icons.error_outline, color: Colors.red[900]);
              case ConnectionState.done:
                return Icon(
                  Icons.done,
                  color: Colors.red[900],
                );
              default:
                return new ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    children: snapshot.data?.documents
                        ?.map((DocumentSnapshot document) {
                      return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        StationProfilCl(doc: document)));
                          },
                          child: createCard(document));
                    })?.toList());
            }
          },
        ),
        bottomNavigationBar: ButtomBarCl(),
      ),
    );
  }

  Container createCard(DocumentSnapshot document) {
    return Container(
      height: 230,
      child: Center(
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
                            builder: (context) => StationProfilCl(
                                  doc: document,
                                )));
                  },
                  child: Stack(
                    children: [
                      Ink.image(
                        height: 100,
                        image: AssetImage(
                          'assets/s4.png',
                        ),
                        fit: BoxFit.fitWidth,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: RaisedButton(
                          onPressed: () {},
                        ),
                        // child: FloatingActionButton(
                        //     backgroundColor: Colors.white.withOpacity(0),
                        //     onPressed: () {
                        //       setState(() {
                        //         _changeFav();
                        //       });
                        //     },
                        //     child: _adoreIcon),
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
                                    builder: (context) => StationProfilCl(
                                          doc: document,
                                        )));
                          },
                          child: Text(
                            '${document['titre']}',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          '${document['adresse']}',
                          style: TextStyle(color: Colors.black54),
                        ),
                        Container(
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {},
                                child: IconButton(
                                  onPressed: null,
                                  icon: Icon(
                                    Icons.phone,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: IconButton(
                                  onPressed: null,
                                  icon: Icon(
                                    Icons.chat,
                                    color: Colors.amber[700],
                                  ),
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.all(10),
                                  alignment: Alignment.topCenter,
                                  child: FlatButton.icon(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.near_me,
                                      color: Colors.blue[800],
                                    ),
                                    label: Text(
                                      'Order',
                                      style: TextStyle(color: Colors.blue[800]),
                                    ),
                                  )),
                              Container(
                                padding: EdgeInsets.all(8),
                                alignment: Alignment.topCenter,
                                child: FlatButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                StationProfilCl(
                                                  doc: document,
                                                )));
                                  },
                                  icon: Icon(
                                    Icons.read_more,
                                  ),
                                  label: Text(
                                    'Details',
                                  ),
                                ),
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
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          decoration: new InputDecoration(
              hintText: 'Type here',
              hintStyle: TextStyle(color: Colors.white10),
              border: InputBorder.none,
              labelText: 'Search',
              labelStyle: TextStyle(color: Colors.white10)),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Explore');
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
