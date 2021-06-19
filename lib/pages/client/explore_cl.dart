import 'dart:developer';
import 'dart:ui';
import 'package:FD_flutter/pages/client/commanderPages/cmd_client.dart';
import 'package:FD_flutter/pages/client/station_cl.dart';
import 'package:FD_flutter/shared/lang.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:FD_flutter/modules/user.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';

class ExploreCl extends StatefulWidget {
  @override
  _ExploreClState createState() => _ExploreClState();
}

List<String> _favList = [];

String searchTerm;
// TextEditingController searchController = new TextEditingController();

class _ExploreClState extends State<ExploreCl> {
  @override
  void initState() {
    super.initState();
  }

  Icon _searchIcon = new Icon(Icons.search);
  final GlobalKey<ScaffoldState> _mScaffoldState =
      new GlobalKey<ScaffoldState>();
  Widget _appBarTitle = new Container(
      margin: EdgeInsets.only(top: 3),
      child: Text('${Language.mapLang['explore']}', style: pageTitleO));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _mScaffoldState,
      backgroundColor: darkGray,
      appBar: AppBar(
        leading: Icon(Icons.language_rounded, color: buttonColor),
        title: _appBarTitle,
        elevation: 0,
        backgroundColor: darkGray,
        actions: <Widget>[
          IconButton(
              icon: new Icon(
                Icons.search,
                color: buttonColor,
              ),
              onPressed: _searchPressed),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection('client')
              .document(Provider.of<User>(context).uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Icon(Icons.cancel, color: buttonColor));
            }

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return _shimmerExplore();
              case ConnectionState.none:
                return Center(
                    child: Icon(Icons.error_outline, color: Colors.white54));

              default:
                _favList = List.from(snapshot.data['favorite']);
                inspect(_favList);
                return StreamBuilder<QuerySnapshot>(
                  stream: searchTerm == null
                      ? Firestore.instance.collection('entreprise').snapshots()
                      : Firestore.instance
                          .collection('entreprise')
                          .where('titre', isGreaterThanOrEqualTo: searchTerm)
                          .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                          child: Icon(Icons.cancel, color: buttonColor));
                    }

                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return _shimmerExplore();
                      case ConnectionState.none:
                        return Center(
                            child: Icon(Icons.error_outline,
                                color: Colors.white54));
                      case ConnectionState.done:
                        return Center(
                            child: Icon(Icons.done, color: Colors.white54));

                      default:
                        return new ListView(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            children: snapshot.data?.documents
                                ?.map((DocumentSnapshot document) {
                              return createCard(document);
                            })?.toList());
                    }
                  },
                );
            }
          }),
    );
  }

  Container createCard(DocumentSnapshot document) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Card(
        color: scaffoldBackground,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StationProfilCl(
                          doc: document,
                          fromWhere: 'explore',
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
                          Text('${document['titre']}', style: smallTileName),
                          Text(
                            '${document['adresse']}',
                            style: TextStyle(
                                color: Colors.white24,
                                fontFamily: 'Quarion',
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                          ),
                        ],
                      ),
                      PopupMenuButton(
                        icon: Icon(Icons.menu_rounded, color: Colors.white),
                        color: Colors.white,
                        itemBuilder: (BuildContext bc) => [
                          PopupMenuItem(
                            child: InkWell(
                              onTap: () async {
                                var tele = 'tel:${document['tele']}';
                                if (await canLaunch(tele)) {
                                  await launch(tele);
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(2, 4, 2, 4),
                                child: Row(
                                  children: [
                                    Icon(Icons.phone, color: Colors.green),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('${Language.mapLang['call']}',
                                        style: textStyle)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            child: InkWell(
                              onTap: () async {
                                var email = 'mailto:${document['email']}';
                                if (await canLaunch(email)) {
                                  await launch(email);
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(2, 4, 2, 4),
                                child: Row(
                                  children: [
                                    Icon(Icons.mail, color: Colors.amber[700]),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('${Language.mapLang['mail']}',
                                        style: textStyle)
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                        onSelected: (route) {
                          print(route);
                          // Note You must create respective pages for navigation
                          Navigator.pushNamed(context, route);
                        },
                      ),
                    ],
                  )),
              Hero(
                tag: '${document.documentID}explore',
                child: CachedNetworkImage(
                  imageUrl:
                      document['photoURL'] == null ? "" : document['photoURL'],
                  imageBuilder: (context, imageProvider) => Material(
                    child: Ink.image(
                      height: 200,
                      image: imageProvider,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  placeholder: (context, url) => Container(
                    height: 200,
                    child: Center(
                      child: customeCircularProgress,
                    ),
                  ),
                  errorWidget: (context, url, error) => Material(
                    child: Container(
                      height: 200,
                      color: darkGray,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error, color: Colors.white),
                            SizedBox(height: 5),
                            Text('${Language.mapLang['imagenotfound']}',
                                style: textStyle.copyWith(color: Colors.white))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      TextButton.icon(
                        label: Container(
                          margin: EdgeInsets.only(top: 2),
                          child: Text(
                            '${Language.mapLang['order']}',
                            style: TextStyle(
                              color: buttonColor,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.4,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Firestore.instance
                              .collection('livreur')
                              .where('uidentreprise',
                                  isEqualTo: document.documentID)
                              .getDocuments()
                              .then((value) {
                            if (value.documents.length > 0) {
                              Navigator.of(context).push(PageTransition(
                                  type: PageTransitionType.fade,
                                  child: new ClientOrder(doc: document)));
                            } else {
                              showInSnackBar("${Language.mapLang['stnolv']}");
                            }
                          });
                        },
                        icon: Icon(OMIcons.accountBalanceWallet,
                            color: buttonColor),
                      ),
                    ],
                  ),
                  _favList.any((element) => element == document.documentID)
                      ? IconButton(
                          icon: Icon(OMIcons.star, color: Color(0xFFF8C513)),
                          onPressed: () => _removeStFromFav(document.documentID,
                              Provider.of<User>(context).uid))
                      : IconButton(
                          icon: Icon(OMIcons.star, color: Colors.black38),
                          onPressed: () => _addStToFav(document.documentID,
                              Provider.of<User>(context).uid)),
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
        this._appBarTitle = new TextFormField(
          cursorColor: grayColor,
          cursorHeight: 25,
          cursorWidth: 1,
          style: TextStyle(fontSize: 18, color: Colors.white),
          textInputAction: TextInputAction.search,
          onFieldSubmitted: (val) {
            setState(() {
              searchTerm = val;
            });
          },
          decoration: new InputDecoration(
            hintText: '${Language.mapLang['typehere']}',
            hintStyle: hintStyle,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          ),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Container(
            margin: EdgeInsets.only(top: 3),
            child: Text('${Language.mapLang['explore']}', style: pageTitleO));
      }
    });
  }

  void _addStToFav(String documentID, String uid) async {
    try {
      await Firestore.instance.collection('client').document(uid).setData({
        'favorite': FieldValue.arrayUnion([documentID])
      }, merge: true);
    } catch (e) {
      print(e);
    }
    setState(() {});
  }

  void _removeStFromFav(String documentID, String uid) async {
    try {
      await Firestore.instance.collection('client').document(uid).updateData(
        {
          'favorite': FieldValue.arrayRemove([documentID])
        },
      );
    } catch (e) {
      print(e);
    }

    setState(() {});
  }

  _shimmerExplore() {
    return Shimmer(
      enabled: true,
      gradient: LinearGradient(
        colors: <Color>[darkGray, scaffoldBackground],
      ),
      child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: [
            for (int i = 0; i < 4; i++)
              Card(
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                      height: 250, width: MediaQuery.of(context).size.width))
          ]),
    );
  }

  void showInSnackBar(String value) {
    SnackBar snackBar = new SnackBar(
        backgroundColor: Colors.white,
        content: new Text(value, style: textStyle));
    _mScaffoldState.currentState.showSnackBar(snackBar);
  }
}
