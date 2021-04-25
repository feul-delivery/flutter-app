import 'package:FD_flutter/shared/custom_alert_dialog.dart';
import 'package:FD_flutter/shared/splash.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'commande_cl.dart';

class CommandeCl extends StatefulWidget {
  final AsyncSnapshot<QuerySnapshot> querySnapshot;

  const CommandeCl({@required this.querySnapshot});
  @override
  _CommandeClState createState() => _CommandeClState();
}

class _CommandeClState extends State<CommandeCl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFEFF0F5),
        appBar: AppBar(
          elevation: 1,
          title: Text(
            "${SplashScreen.mapLang['orders']}",
            style: pageTitleX,
          ),
          leading: IconButton(
              icon: Icon(OMIcons.arrowBack, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              }),
          backgroundColor: Color(0xFFFFFFFF),
        ),
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.only(left: 0, right: 0),
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              for (DocumentSnapshot doc in widget.querySnapshot.data.documents)
                cardCommande(doc),
            ],
          ),
        ));
  }

  Widget cardCommande(DocumentSnapshot documentSnapshot) {
    double _prixTotal = double.tryParse('${documentSnapshot['prixtotal']}');
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.20,
      actions: [
        IconSlideAction(
          caption: '${SplashScreen.mapLang['show']}',
          color: Colors.white,
          icon: OMIcons.list,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => CommandeDetail(
                      document: documentSnapshot,
                    )));
          },
        ),
      ],
      secondaryActions: [
        if (documentSnapshot['statut'] == 'waiting' &&
            documentSnapshot['uidlivreur'] == '')
          IconSlideAction(
            caption: '${SplashScreen.mapLang['cancel']}',
            color: Colors.red,
            icon: OMIcons.cancel,
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomAlertDialog(
                      title: Text(
                          '${SplashScreen.mapLang['cancel']} ${SplashScreen.mapLang['order']}',
                          style: pageTitleX),
                      content: Text('${SplashScreen.mapLang['areyousure']}',
                          style: textStyle),
                      actions: [
                        InkWell(
                            onTap: () {
                              Firestore.instance
                                  .collection('orders')
                                  .document(documentSnapshot.documentID)
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
                                  '${SplashScreen.mapLang['confirm']}',
                                  style: buttonStyle,
                                ),
                              ),
                            )),
                        FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              '${SplashScreen.mapLang['cancel']}',
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
            color: documentSnapshot['statut'] == 'waiting'
                ? Colors.orange
                : Colors.green,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(
            documentSnapshot['statut'] == 'waiting'
                ? OMIcons.timer
                : OMIcons.check,
            color: Colors.white,
          ),
        ),
        title: Text('${documentSnapshot['ordernum']}'),
        subtitle: Text(
            """${DateFormat.Hm().format(DateTime.parse(documentSnapshot['dateheurec']))} - ${DateTime.parse(documentSnapshot['dateheurec']).day}/${DateTime.parse(documentSnapshot['dateheurec']).month}/${DateTime.parse(documentSnapshot['dateheurec']).year}"""),
        trailing: Text('${_prixTotal.toStringAsFixed(2)} Dh'),
      ),
    );
  }
}
