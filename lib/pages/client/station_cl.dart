import 'package:FD_flutter/shared/FadeAnimation.dart';
import 'package:FD_flutter/shared/lang.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:FD_flutter/pages/client/commanderPages/cmd_client.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StationProfilCl extends StatefulWidget {
  final DocumentSnapshot doc;
  StationProfilCl({@required this.doc});
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
            .getDocuments()
            .asStream(),
        builder: (context, snapshotLv) {
          if (snapshotLv.connectionState == ConnectionState.done)
            _lvCount = snapshotLv.data.documents.length;
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                      expandedHeight: 200,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.pin,
                          background: Hero(
                            tag: doc.documentID,
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
                                  color: Colors.black,
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
                            ),
                          )),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Padding(
                          padding:
                              EdgeInsets.only(left: 20, right: 20, bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              FadeAnimation(
                                  0.01,
                                  Container(
                                      margin: EdgeInsets.all(10),
                                      padding: EdgeInsets.all(10),
                                      child: FadeAnimation(
                                          0.01,
                                          Center(
                                            child: Text('${doc['titre']}',
                                                style: titleStyleNew),
                                          )))),
                              FadeAnimation(
                                  0.01,
                                  Row(
                                    children: [
                                      Icon(Icons.article, color: Colors.black),
                                      SizedBox(width: 8),
                                      Text("Description",
                                          style: tileTitleStyle),
                                    ],
                                  )),
                              Divider(height: 15, thickness: 1),
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
                                      Icon(Icons.business, color: Colors.black),
                                      SizedBox(width: 8),
                                      Text("${Language.mapLang['address']}",
                                          style: tileTitleStyle),
                                    ],
                                  )),
                              Divider(height: 15, thickness: 1),
                              SizedBox(height: 10),
                              FadeAnimation(0.01,
                                  Text(doc['adresse'], style: smallTileGray)),
                              SizedBox(height: 20),
                              FadeAnimation(
                                0.01,
                                Row(
                                  children: [
                                    Icon(Icons.group, color: Colors.black),
                                    SizedBox(width: 8),
                                    Text("${Language.mapLang['deliverymen']}",
                                        style: tileTitleStyle),
                                  ],
                                ),
                              ),
                              Divider(height: 15, thickness: 1),
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
                                    Icon(Icons.phone, color: Colors.black),
                                    SizedBox(width: 8),
                                    Text("${Language.mapLang['phone']}",
                                        style: tileTitleStyle)
                                  ],
                                ),
                              ),
                              Divider(height: 15, thickness: 1),
                              SizedBox(height: 10),
                              FadeAnimation(0.01,
                                  Text(doc['tele'], style: smallTileGray)),
                              SizedBox(height: 20),
                              FadeAnimation(
                                0.01,
                                Row(
                                  children: [
                                    Icon(Icons.mail, color: Colors.black),
                                    SizedBox(width: 8),
                                    Text("Email", style: tileTitleStyle),
                                  ],
                                ),
                              ),
                              Divider(height: 15, thickness: 1),
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
                                                  color: Colors.black),
                                              SizedBox(width: 8),
                                              Text(
                                                  "${Language.mapLang['pictures']}",
                                                  style: tileTitleStyle),
                                            ],
                                          ),
                                        ),
                                        Divider(height: 15, thickness: 1),
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
                    ? Positioned.fill(
                        bottom: 20,
                        top: MediaQuery.of(context).size.height -
                            MediaQuery.of(context).size.height * 0.075,
                        left: MediaQuery.of(context).size.width -
                            MediaQuery.of(context).size.width * 0.7,
                        right: MediaQuery.of(context).size.width -
                            MediaQuery.of(context).size.width * 0.7,
                        child: FadeAnimation(
                          0.01,
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => new ClientOrder(
                                            doc: doc,
                                          )));
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.green.shade400),
                              child: Text(
                                "${Language.mapLang['placeorder']}",
                                style: buttonStyle,
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
            child: Icon(Icons.error, color: Colors.black),
          ),
        ),
      ),
      aspectRatio: 16 / 9,
    );
  }
}
