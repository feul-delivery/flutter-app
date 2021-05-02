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
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';

class ExploreCl extends StatefulWidget {
  @override
  _ExploreClState createState() => _ExploreClState();
}

List<String> _favList = [];

class _ExploreClState extends State<ExploreCl> {
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle =
      new Text('${Language.mapLang['explore']}', style: pageTitleX);
  String _searchString;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection('client')
            .document(Provider.of<User>(context).uid)
            .get()
            .asStream(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return customErrorWidget;
            case ConnectionState.active:
              return customeCircularProgress;
            case ConnectionState.waiting:
              return Container(color: Color(0xFFEFF0F5));
              break;

            default:
              _favList = List.from(snapshot.data['favorite']);
              inspect(_favList);
              return Scaffold(
                backgroundColor: Color(0xFFEFF0F5),
                appBar: AppBar(
                  title: _appBarTitle,
                  elevation: 1,
                  backgroundColor: Colors.white,
                  actions: <Widget>[
                    IconButton(
                        icon: new Icon(
                          Icons.search,
                          color: Colors.blue[700],
                        ),
                        onPressed: _searchPressed),
                  ],
                ),
                body: StreamBuilder<QuerySnapshot>(
                  stream: _searchString == null
                      ? Firestore.instance.collection('entreprise').snapshots()
                      : Firestore.instance
                          .collection('entreprise')
                          .where('titre', isGreaterThanOrEqualTo: _searchString)
                          .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Icon(Icons.cancel, color: Colors.blue[700]);
                    }

                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return SizedBox(
                            child: Center(child: customeCircularProgress));
                      case ConnectionState.none:
                        return Icon(Icons.error_outline, color: Colors.black);
                      case ConnectionState.done:
                        return Icon(Icons.done, color: Colors.black);

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
                                                StationProfilCl(
                                                    doc: document)));
                                  },
                                  child: createCard(document));
                            })?.toList());
                    }
                  },
                ),
              );
          }
        });
  }

  Container createCard(DocumentSnapshot document) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StationProfilCl(doc: document)));
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
                                      builder: (context) =>
                                          new StationProfilCl(doc: document)));
                            },
                            child: Text('${document['titre']}'.toUpperCase(),
                                style: tileTitleStyle),
                          ),
                          Text(
                            '${document['adresse']}'.toLowerCase(),
                            style: TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          ),
                        ],
                      ),
                      PopupMenuButton(
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
                tag: document.documentID,
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
                  errorWidget: (context, url, error) => Container(
                    height: 200,
                    color: Colors.black,
                    child: Center(
                      child: Icon(Icons.error, color: Colors.white),
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
                              color: Colors.blue[700],
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.4,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(PageTransition(
                              type: PageTransitionType.fade,
                              child: new ClientOrder(doc: document)));
                        },
                        icon: Icon(OMIcons.accountBalanceWallet,
                            color: Colors.blue[700]),
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
          style: textStyle,
          keyboardType: TextInputType.text,
          decoration: new InputDecoration(
            hintText: '${Language.mapLang['typehere']}',
            hintStyle: hintStyle,
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
        this._appBarTitle =
            new Text('${Language.mapLang['explore']}', style: pageTitleX);
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
}
