import 'package:FD_flutter/pages/client/commanderPages/cmd_client.dart';
import 'package:FD_flutter/pages/client/index_cl.dart';
import 'package:FD_flutter/pages/client/station_cl.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:FD_flutter/pages/client/drawer_cl.dart';

import 'package:url_launcher/url_launcher.dart';
import 'bbar_cl.dart';

class ExploreCl extends StatefulWidget {
  @override
  _ExploreClState createState() => _ExploreClState();
}

class _ExploreClState extends State<ExploreCl> {
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Explore', style: pageTitle);
  Icon _adoreIcon = new Icon(Icons.favorite, color: Colors.black);
  String _searchString;
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
          backgroundColor: Colors.black,
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
          stream: _searchString == null
              ? Firestore.instance.collection('entreprise').snapshots()
              : Firestore.instance
                  .collection('entreprise')
                  .where('titre', isGreaterThanOrEqualTo: _searchString)
                  .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Icon(Icons.cancel, color: Colors.black);
            }

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return SizedBox(
                    child: Center(
                        child: CircularProgressIndicator(
                            valueColor:
                                new AlwaysStoppedAnimation<Color>(Colors.white),
                            backgroundColor: Colors.black)));
              case ConnectionState.none:
                return Icon(Icons.error_outline, color: Colors.black);
              case ConnectionState.done:
                return Icon(
                  Icons.done,
                  color: Colors.black,
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
      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Card(
        clipBehavior: Clip.antiAlias,
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
//image of the station

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
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          _changeFav();
                        });
                      },
                      icon: _adoreIcon,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                      child: Text('${document['titre']}',
                          style: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'Gotham',
                            fontWeight: FontWeight.w400,
                            fontSize: 24,
                          )),
                    ),
                    Text(
                      '${document['adresse']}',
                      style: TextStyle(
                        color: Colors.black38,
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () async {
                              var tele = 'tel:${document['tele']}';
                              if (await canLaunch(tele)) {
                                await launch(tele);
                              }
                            },
                            icon: Icon(
                              Icons.phone,
                              color: Colors.green,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              var email = 'mailto:${document['email']}';
                              if (await canLaunch(email)) {
                                await launch(email);
                              }
                            },
                            icon: Icon(
                              Icons.mail,
                              color: Colors.amber[700],
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.topCenter,
                              child: FlatButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ClientOrder(
                                                doc: document,
                                              )));
                                },
                                icon: Icon(
                                  Icons.near_me,
                                  color: Colors.blue[800],
                                ),
                                label: Text(
                                  'Order',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontFamily: 'Gotham',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          style: textStyleWhite,
          keyboardType: TextInputType.text,
          decoration: new InputDecoration(
            hintText: 'Type here',
            hintStyle: hintStyleWhite,
            border: InputBorder.none,
          ),
          onChanged: (value) {
            setState(() {
              _searchString = value;
            });
          },
        );
      } else {
        _searchString = null;
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text(
          'Explore',
          style: pageTitle,
        );
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
        color: Colors.black,
      );
      adore = 0;
    }
  }
}
