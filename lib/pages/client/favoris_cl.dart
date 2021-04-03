import 'dart:developer';

import 'package:FD_flutter/pages/client/station_cl.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

class FavorisCl extends StatefulWidget {
  final QuerySnapshot snapshotFavoris;
  final List<String> favList;
  const FavorisCl({@required this.snapshotFavoris, @required this.favList});
  @override
  _FavorisClState createState() => _FavorisClState();
}

class _FavorisClState extends State<FavorisCl> {
  @override
  Widget build(BuildContext context) {
    inspect(widget.favList);
    inspect(widget.snapshotFavoris);
    return Scaffold(
      backgroundColor: Color(0xFFEFF0F5),
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Color(0xFFFFFFFF),
        title: Text(
          'Favorites',
          style: pageTitleX,
        ),
        leading: IconButton(
            icon: Icon(OMIcons.arrowBack, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children:
              widget.snapshotFavoris.documents.map((DocumentSnapshot document) {
            return widget.favList.contains(document.documentID)
                ? _createCard(document)
                : Container();
          }).toList()),
    );
  }

  Widget _createCard(DocumentSnapshot document) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushReplacement(PageTransition(
            type: PageTransitionType.leftToRight,
            child: StationProfilCl(doc: document)));
      },
      child: ListTile(
        tileColor: Colors.white,
        leading: Container(
          child: Icon(OMIcons.star, color: Color(0xFFF8C513)),
        ),
        title: Text('${document.data['titre']}', style: textStyle),
        trailing: PopupMenuButton(
          itemBuilder: (BuildContext bc) => [
            PopupMenuItem(
              child: TextButton.icon(
                  onPressed: () async {
                    var tele = 'tel:${document['tele']}';
                    if (await canLaunch(tele)) {
                      await launch(tele);
                    }
                  },
                  icon: Icon(Icons.phone, color: Colors.green),
                  label: Text('Call', style: textStyle)),
            ),
            PopupMenuItem(
              child: TextButton.icon(
                  onPressed: () async {
                    var email = 'mailto:${document['email']}';
                    if (await canLaunch(email)) {
                      await launch(email);
                    }
                  },
                  icon: Icon(Icons.mail, color: Colors.amber[700]),
                  label: Text('Mail', style: textStyle)),
            ),
          ],
          onSelected: (route) {
            print(route);
            // Note You must create respective pages for navigation
            Navigator.pushNamed(context, route);
          },
        ),
      ),
    );
  }
}
