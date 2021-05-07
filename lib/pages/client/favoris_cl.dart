import 'dart:developer';

import 'package:FD_flutter/modules/user.dart';
import 'package:FD_flutter/pages/client/station_cl.dart';
import 'package:FD_flutter/shared/lang.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class FavorisCl extends StatefulWidget {
  final QuerySnapshot snapshotFavoris;
  final List<String> favList;
  const FavorisCl({@required this.snapshotFavoris, @required this.favList});
  @override
  _FavorisClState createState() => _FavorisClState();
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
}

class _FavorisClState extends State<FavorisCl> {
  @override
  Widget build(BuildContext context) {
    inspect(widget.favList);
    inspect(widget.snapshotFavoris);
    return Scaffold(
      backgroundColor: darkGray,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: buttonColor,
        title: Text('${Language.mapLang['favorite']}', style: pageTitleW),
        leading: IconButton(
            icon: Icon(Icons.west, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SafeArea(
        child: ListView(
            scrollDirection: Axis.vertical,
            children: widget.snapshotFavoris.documents
                .map((DocumentSnapshot document) {
              return widget.favList.contains(document.documentID)
                  ? _createCard(document)
                  : Container();
            }).toList()),
      ),
    );
  }

  Widget _createCard(DocumentSnapshot document) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.15,
      secondaryActions: [
        IconSlideAction(
          color: Colors.red,
          caption: '${Language.mapLang['delete']}',
          icon: OMIcons.delete,
          onTap: () {
            _removeStFromFav(
                document.documentID, Provider.of<User>(context).uid);
            Navigator.pop(context);
          },
        ),
      ],
      actions: [
        IconSlideAction(
          color: Colors.amber[700],
          iconWidget: Icon(OMIcons.mail, color: Colors.white),
          onTap: () async {
            var email = 'mailto:${document['email']}';
            if (await canLaunch(email)) {
              await launch(email);
            }
          },
        ),
        IconSlideAction(
          color: Colors.green,
          iconWidget: Icon(OMIcons.call, color: Colors.white),
          onTap: () async {
            var tele = 'tel:${document['tele']}';
            if (await canLaunch(tele)) {
              await launch(tele);
            }
          },
        ),
      ],
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushReplacement(PageTransition(
              type: PageTransitionType.leftToRight,
              child: StationProfilCl(doc: document, fromWhere: 'fav')));
        },
        child: ListTile(
          tileColor: scaffoldBackground,
          leading: Container(
            child: Icon(OMIcons.star, color: Color(0xFFF8C513)),
          ),
          title: Text('${document.data['titre']}', style: tileTitleStyleW),
        ),
      ),
    );
  }
}
