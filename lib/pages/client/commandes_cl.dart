import 'package:FD_flutter/shared/custom_alert_dialog.dart';
import 'package:FD_flutter/shared/lang.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'commande_cl.dart';
import 'package:provider/provider.dart';
import 'package:FD_flutter/modules/user.dart';

class CommandeCl extends StatefulWidget {
  @override
  _CommandeClState createState() => _CommandeClState();
}

class _CommandeClState extends State<CommandeCl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: darkGray,
        appBar: AppBar(
            elevation: 1,
            title: Text(
              "${Language.mapLang['orders']}",
              style: pageTitleW,
            ),
            leading: IconButton(
                icon: Icon(Icons.west, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                }),
            actions: <Widget>[
              IconButton(
                  icon: new Icon(
                    Icons.refresh,
                    color: buttonColor,
                  ),
                  onPressed: () {
                    setState(() {});
                  }),
            ],
            backgroundColor: buttonColor),
        body: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('orders')
                  .where('uidclient', isEqualTo: Provider.of<User>(context).uid)
                  .orderBy('ordernum')
                  .getDocuments()
                  .asStream(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Icon(Icons.cancel, color: buttonColor));
                }

                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: customeCircularProgress);
                  case ConnectionState.none:
                    return Center(
                        child:
                            Icon(Icons.error_outline, color: Colors.white54));

                  default:
                    return ListView(
                      padding: EdgeInsets.only(left: 0, right: 0),
                      children: <Widget>[
                        SizedBox(
                          height: 5,
                        ),
                        for (DocumentSnapshot doc in snapshot.data.documents)
                          cardCommande(doc),
                      ],
                    );
                }
              }),
        ));
  }

  Widget cardCommande(DocumentSnapshot snapshot) {
    double _prixTotal = double.tryParse('${snapshot['prixtotal']}');
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.20,
      actions: [
        IconSlideAction(
          caption: '${Language.mapLang['show']}',
          color: scaffoldBackground,
          icon: OMIcons.list,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => CommandeDetail(
                      document: snapshot,
                    )));
          },
        ),
      ],
      secondaryActions: [
        if (snapshot['statut'] == 'waiting' && snapshot['uidlivreur'] == '')
          IconSlideAction(
            caption: '${Language.mapLang['cancel']}',
            color: Colors.red,
            icon: OMIcons.cancel,
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomAlertDialog(
                      title: Text(
                          '${Language.mapLang['cancel']} ${Language.mapLang['order']}',
                          style: pageTitleX),
                      content: Text('${Language.mapLang['areyousure']}',
                          style: textStyle),
                      actions: [
                        InkWell(
                            onTap: () {
                              Firestore.instance
                                  .collection('orders')
                                  .document(snapshot.documentID)
                                  .delete();
                              Navigator.of(context).pop();
                            },
                            child: Center(
                              child: Container(
                                padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(50)),
                                child: Text(
                                  '${Language.mapLang['confirm']}',
                                  style: buttonStyle,
                                ),
                              ),
                            )),
                        FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              '${Language.mapLang['cancel']}',
                              style: smallTileGray,
                            )),
                      ],
                    );
                  });
            },
          )
      ],
      child: ListTile(
          leading: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: snapshot['statut'] == 'waiting'
                  ? Colors.orange
                  : Colors.green,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              snapshot['statut'] == 'waiting' ? OMIcons.timer : OMIcons.check,
              color: Colors.white,
            ),
          ),
          title: Text(
            '${snapshot['ordernum']}',
            style: tileTitleStyleW,
          ),
          subtitle: Text(
            """${DateFormat.Hm().format(DateTime.parse(snapshot['dateheurec']))} - ${DateTime.parse(snapshot['dateheurec']).day}/${DateTime.parse(snapshot['dateheurec']).month}/${DateTime.parse(snapshot['dateheurec']).year}""",
            style: smallTileGray,
          ),
          trailing: Text(
            '${_prixTotal.toStringAsFixed(2)} Dh',
            style: moreStyleWhite,
          )),
    );
  }
}
