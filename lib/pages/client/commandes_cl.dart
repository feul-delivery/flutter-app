import 'package:FD_flutter/shared/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
            "My orders",
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
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => CommandeDetail(
                  document: documentSnapshot,
                )));
      },
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
