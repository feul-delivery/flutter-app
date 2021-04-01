import 'dart:developer';
import 'dart:ui';
import 'package:FD_flutter/pages/client/commanderPages/cmd_client.dart';
import 'package:FD_flutter/pages/client/favoris_cl.dart';
import 'package:FD_flutter/pages/client/index_cl.dart';
import 'package:FD_flutter/pages/client/station_cl.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
  Icon _icon = new Icon(Icons.favorite, color: Colors.black38);
  String _searchString;
  int adore = 0;

  @override
  Widget build(BuildContext context) {
    inspect(FavorisCl.favList);
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        ButtomBarCl.selectedIndex = 0;
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => IndexCl()));
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
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
      margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StationProfilCl(
                          doc: document,
                        )));
          },
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.only(left: 7, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                            child: Text('${document['titre']}'.toUpperCase(),
                                style: tileTitleStyle),
                          ),
                          Text(
                            '${document['adresse']}'.toLowerCase(),
                            style: TextStyle(
                              color: Colors.black38,
                              fontFamily: 'Gotham',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      PopupMenuButton(
                        itemBuilder: (BuildContext bc) => [
                          PopupMenuItem(
                            child: TextButton.icon(
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
                                label: Text(
                                  'Call',
                                  style: textStyle,
                                )),
                          ),
                          PopupMenuItem(
                            child: TextButton.icon(
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
                                label: Text(
                                  'Mail',
                                  style: textStyle,
                                )),
                          ),
                        ],
                        onSelected: (route) {
                          print(route);
                          // Note You must create respective pages for navigation
                          Navigator.pushNamed(context, route);
                        },
                      ),
                    ],
                  )),
//image of the station
              document['photoURL'] != null
                  ? CachedNetworkImage(
                      imageUrl: document['photoURL'],
                      imageBuilder: (context, imageProvider) => Ink.image(
                        height: 200,
                        image: imageProvider,
                        fit: BoxFit.fitWidth,
                      ),
                      placeholder: (context, url) => Container(
                        height: 200,
                        child: Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.black,
                            valueColor:
                                new AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: 200,
                        child: Center(
                          child: Icon(Icons.error, color: Colors.black),
                        ),
                      ),
                    )
                  : Container(
                      height: 200,
                      child: Center(
                        child: Icon(Icons.error, color: Colors.black),
                      ),
                    ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
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
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _changeFav();
                      });
                    },
                    icon: FavorisCl.favList
                            .any((element) => element == document.documentID)
                        ? _adoreIcon
                        : _icon,
                  ),
                ],
              )
            ],
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
