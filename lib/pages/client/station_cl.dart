import 'package:FD_flutter/shared/FadeAnimation.dart';
import 'package:FD_flutter/shared/lang.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:FD_flutter/pages/client/commanderPages/cmd_client.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StationProfilCl extends StatefulWidget {
  final DocumentSnapshot doc;
  final String fromWhere;
  StationProfilCl({@required this.doc, @required this.fromWhere});
  @override
  _StationProfilClState createState() => _StationProfilClState();
}

int _lvCount = 0;
List<Map<dynamic, dynamic>> _imagesList;

class _StationProfilClState extends State<StationProfilCl> {
  @override
  Widget build(BuildContext context) {
    var doc = widget.doc;
    _imagesList = List<Map<dynamic, dynamic>>.from(doc.data['images']).toList();
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('livreur')
            .where('uidentreprise', isEqualTo: doc.documentID)
            .snapshots(),
        builder: (context, snapshotLv) {
          if (snapshotLv.connectionState == ConnectionState.done)
            _lvCount = snapshotLv.data.documents.length;
          return Scaffold(
            backgroundColor: scaffoldBackground,
            body: Stack(
              children: <Widget>[
                CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      leading: IconButton(
                          icon: Icon(Icons.west_rounded),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 7.0),
                        child: Center(
                          child: Text('${doc['titre']}', style: pageTitleXW),
                        ),
                      ),
                      expandedHeight: 200,
                      backgroundColor: buttonColor,
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.pin,
                        background: Hero(
                            tag: '${doc.documentID}${widget.fromWhere}',
                            child: CachedNetworkImage(
                              imageUrl: doc.data['photoURL'] == null
                                  ? ""
                                  : doc.data['photoURL'],
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover)),
                                child: Container(),
                              ),
                              placeholder: (context, url) => Container(
                                height: 200,
                                child: Center(child: customeCircularProgress),
                              ),
                              errorWidget: (context, url, error) => Material(
                                child: Container(
                                  height: 200,
                                  color: buttonColor,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.error, color: Colors.white),
                                        SizedBox(height: 5),
                                        Text(
                                            '${Language.mapLang['imagenotfound']}',
                                            style: textStyleWhite)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              FadeAnimation(
                                  0.01,
                                  Row(
                                    children: [
                                      Icon(Icons.article, color: buttonColor),
                                      SizedBox(width: 8),
                                      Text("Description",
                                          style: tileTitleStyleW),
                                    ],
                                  )),
                              Divider(
                                  height: 15,
                                  thickness: 1,
                                  color: Colors.white),
                              SizedBox(height: 10),
                              FadeAnimation(
                                  0.01,
                                  Text(doc['description'],
                                      style: smallTileGray)),
                              FadeAnimation(
                                0.01,
                                SizedBox(height: 20),
                              ),
                              FadeAnimation(
                                  0.01,
                                  Row(
                                    children: [
                                      Icon(Icons.business, color: buttonColor),
                                      SizedBox(width: 8),
                                      Text("${Language.mapLang['address']}",
                                          style: tileTitleStyleW),
                                    ],
                                  )),
                              Divider(
                                  height: 15,
                                  thickness: 1,
                                  color: Colors.white),
                              SizedBox(height: 10),
                              FadeAnimation(0.01,
                                  Text(doc['adresse'], style: smallTileGray)),
                              SizedBox(height: 20),
                              FadeAnimation(
                                0.01,
                                Row(
                                  children: [
                                    Icon(Icons.group, color: buttonColor),
                                    SizedBox(width: 8),
                                    Text("${Language.mapLang['deliverymen']}",
                                        style: tileTitleStyleW),
                                  ],
                                ),
                              ),
                              Divider(
                                  height: 15,
                                  thickness: 1,
                                  color: Colors.white),
                              SizedBox(height: 10),
                              FadeAnimation(
                                  0.01,
                                  _lvCount > 0
                                      ? Text(
                                          "$_lvCount ${Language.mapLang['deliverymen']}",
                                          style: smallTileGray)
                                      : Text("${Language.mapLang['stnolv']}",
                                          style: smallTileGray)),
                              SizedBox(height: 20),
                              FadeAnimation(
                                0.01,
                                Row(
                                  children: [
                                    Icon(Icons.phone, color: buttonColor),
                                    SizedBox(width: 8),
                                    Text("${Language.mapLang['phone']}",
                                        style: tileTitleStyleW)
                                  ],
                                ),
                              ),
                              Divider(
                                  height: 15,
                                  thickness: 1,
                                  color: Colors.white),
                              SizedBox(height: 10),
                              FadeAnimation(0.01,
                                  Text(doc['tele'], style: smallTileGray)),
                              SizedBox(height: 20),
                              FadeAnimation(
                                0.01,
                                Row(
                                  children: [
                                    Icon(Icons.mail, color: buttonColor),
                                    SizedBox(width: 8),
                                    Text("Email", style: tileTitleStyleW),
                                  ],
                                ),
                              ),
                              Divider(
                                  height: 15,
                                  thickness: 1,
                                  color: Colors.white),
                              SizedBox(height: 10),
                              FadeAnimation(0.01,
                                  Text(doc['email'], style: smallTileGray)),
                              SizedBox(height: 20),
                              _imagesList.length != 0
                                  ? Column(
                                      children: [
                                        FadeAnimation(
                                          0.01,
                                          Row(
                                            children: [
                                              Icon(Icons.photo,
                                                  color: buttonColor),
                                              SizedBox(width: 8),
                                              Text(
                                                  "${Language.mapLang['pictures']}",
                                                  style: tileTitleStyleW),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                            height: 15,
                                            thickness: 1,
                                            color: Colors.white),
                                        SizedBox(height: 10),
                                        FadeAnimation(
                                            1.8,
                                            Container(
                                              height: 200,
                                              child: ListView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                children: _imagesList
                                                    .map((e) => makeVideo(
                                                        imageURL:
                                                            e['photoURL']))
                                                    .toList(),
                                              ),
                                            )),
                                        SizedBox(
                                          height: 60,
                                        )
                                      ],
                                    )
                                  : Container(),
                            ],
                          ),
                        )
                      ]),
                    )
                  ],
                ),
                _lvCount > 0
                    ? Positioned(
                        bottom: 20,
                        left: MediaQuery.of(context).size.width -
                            MediaQuery.of(context).size.width * 0.7,
                        right: MediaQuery.of(context).size.width -
                            MediaQuery.of(context).size.width * 0.7,
                        child: FadeAnimation(
                          0.01,
                          Container(
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: buttonColor),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(50),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => new ClientOrder(
                                                doc: doc,
                                              )));
                                },
                                child: Center(
                                  child: Text(
                                    "${Language.mapLang['placeorder']}",
                                    style: buttonStyle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          );
        });
  }

  Widget makeVideo({imageURL}) {
    return AspectRatio(
      child: CachedNetworkImage(
        imageUrl: imageURL,
        imageBuilder: (context, imageProvider) => Container(
          margin: EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
        ),
        placeholder: (context, url) => Container(
          height: 200,
          child: Center(child: customeCircularProgress),
        ),
        errorWidget: (context, url, error) => Container(
          height: 200,
          child: Center(
            child: Icon(Icons.error, color: buttonColor),
          ),
        ),
      ),
      aspectRatio: 16 / 9,
    );
  }
}
