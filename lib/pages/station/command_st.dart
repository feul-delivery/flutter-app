import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommandeDetailSt extends StatefulWidget {
  final DocumentSnapshot document;
  CommandeDetailSt(
    this.document,
  );
  @override
  _CommandeDetailStState createState() => _CommandeDetailStState();
}

class _CommandeDetailStState extends State<CommandeDetailSt> {
  var livreur='N/A';
  @override
  void initState() {
    super.initState();
    if (widget.document['statut'] == 'done') {
      getLivreur();
    }
  }

  Future getLivreur() async {
    await Firestore.instance
        .collection('livreur')
        .document(widget.document['uidlivreur'])
        .get()
        .then((value) async {
      if (value.exists) {
        var key1 = await value.data['prenom'];
        var key2 = await value.data['nom'];
        setState(() {
          livreur = key1 + ' ' + key2;
          print(livreur);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.document['statut'] == 'done') {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Details",
            style: TextStyle(),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          elevation: 1,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.info_outline,
                  color: Colors.white,
                )),
          ],
        ),
        body: getBodyDone(),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Details",
            style: TextStyle(),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          elevation: 1,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.info_outline,
                  color: Colors.white,
                )),
          ],
        ),
        body: getBodyAtt(),
      );
    }
  }

  Widget getBodyDone() {
    DateTime dateC = DateTime.parse(widget.document['dateheurec']);
    DateTime dateL = DateTime.parse(widget.document['dateheurel']);
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.format_list_numbered_sharp,
                    color: Colors.black54,
                    size: 18,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Ref:",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  widget.document.reference.documentID,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.date_range_sharp,
                    color: Colors.black54,
                    size: 18,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Date de commande:",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  "${dateC.day}/${dateC.month}/${dateC.year} ${DateFormat.Hm().format(dateC)}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.done,
                    color: Colors.black54,
                    size: 18,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Date de livrisent:",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  "${dateL.day}/${dateL.month}/${dateL.year} ${DateFormat.Hm().format(dateL)}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.black54,
                    size: 18,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "livreur de commande:",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  livreur,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.note_add,
                    color: Colors.black54,
                    size: 18,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Registration number de client:",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  widget.document['matricule'],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.color_lens,
                    color: Colors.black54,
                    size: 18,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Color:",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  widget.document['color'],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.track_changes_sharp,
                    color: Colors.black54,
                    size: 18,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Fuel type:",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  widget.document['idtype'],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.place,
                    color: Colors.black54,
                    size: 18,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Address",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(28, 0, 28, 0),
                  child: Text(
                    widget.document['adresse'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getBodyAtt() {
    DateTime dateC = DateTime.parse(widget.document['dateheurec']);
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.format_list_numbered_sharp,
                    color: Colors.black54,
                    size: 18,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Ref:",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  widget.document.reference.documentID,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.date_range_sharp,
                    color: Colors.black54,
                    size: 18,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Date de commande:",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  "${dateC.day}/${dateC.month}/${dateC.year} ${DateFormat.Hm().format(dateC)}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.note_add,
                    color: Colors.black54,
                    size: 18,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Registration number de client:",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  widget.document['matricule'],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.color_lens,
                    color: Colors.black54,
                    size: 18,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Color:",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  widget.document['color'],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.track_changes_sharp,
                    color: Colors.black54,
                    size: 18,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Fuel type:",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  widget.document['idtype'],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.place,
                    color: Colors.black54,
                    size: 18,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Address",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(28, 0, 28, 0),
                  child: Text(
                    widget.document['adresse'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}