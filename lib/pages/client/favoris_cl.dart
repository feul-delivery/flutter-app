import 'package:FD_flutter/pages/client/station_cl.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FavorisCl extends StatefulWidget {
  @override
  _FavorisClState createState() => _FavorisClState();
}

class _FavorisClState extends State<FavorisCl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          'Favorites',
          style: pageTitle,
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SingleChildScrollView(
        child: Column(
            // children: [createCard()],
            ),
      ),
    );
  }

  Container createCard(DocumentSnapshot document) {
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
                              builder: (context) => StationProfilCl(
                                    doc: document,
                                  )));
                    },
                    child: Stack(
                      children: [
                        Ink.image(
                          height: 100,
                          image: AssetImage(
                            'assets/s3.jpg',
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
                          //   backgroundColor: Colors.white.withOpacity(0),
                          //   onPressed: null,
                          //   child: Icon(
                          //     Icons.favorite,
                          //     color: Colors.black,
                          //   ),
                          // ),
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
                                            'Order',
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
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             StationProfilCl()));
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
