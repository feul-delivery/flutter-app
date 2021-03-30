import 'package:cached_network_image/cached_network_image.dart';
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
  var livreur = 'N/A';
  var clNom = 'N/A';
  var clNum = 'N/A';
  @override
  void initState() {
    super.initState();
    if (widget.document['statut'] == 'done') {
      getLivreur();
      getClient();
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

  Future getClient() async {
    await Firestore.instance
        .collection('client')
        .document(widget.document['uidclient'])
        .get()
        .then((value) async {
      if (value.exists) {
        var key1 = await value.data['prenom'];
        var key2 = await value.data['nom'];
        var key3 = await value.data['tele'];
        setState(() {
          clNom = key1 + ' ' + key2;
          clNum = key3;
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
                onPressed: () {
                  _clientDetailSheet(
                      context, widget.document['uidclient'], clNom, clNum);
                },
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

Future<void> _clientDetailSheet(
    BuildContext context, var id, var nom, var num) {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (BuildContext context, setState) {
          return Container(
              height: MediaQuery.of(context).size.height * 1 / 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    
                    Container(
                       decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: MediaQuery.of(context).size.width / 5,
                        width: MediaQuery.of(context).size.width / 5,
                      child: StreamBuilder<DocumentSnapshot>(
                          stream: Firestore.instance
                              .collection('client')
                              .document(id)
                              .get()
                              .asStream(),
                          builder: (context, snapshot) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                snapshot.data['photoURL'] == null
                                    ? CircleAvatar(
                                        radius: 50.0,
                                        backgroundImage:
                                            AssetImage('assets/profile.png'),
                                      )
                                    : CachedNetworkImage(
                                        imageUrl: snapshot.data['photoURL'],
                                        imageBuilder: (context,
                                                imageProvider) =>
                                            CircleAvatar(
                                                radius: 30.0,
                                                backgroundImage: imageProvider),
                                        placeholder: (context, url) =>
                                            CircleAvatar(
                                                radius: 30.0,
                                                child:
                                                    CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            CircleAvatar(
                                                radius: 30.0,
                                                child: Icon(Icons.error)),
                                      ),
                                
                              ],
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: Colors.black54,
                                size: 18,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                child: Text(nom,
                                    style: TextStyle(
                                        color: Colors.grey[800], fontSize: 22)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.phone,
                                color: Colors.black54,
                                size: 18,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Container(
                                child: Text(num,
                                    style: TextStyle(
                                        color: Colors.grey[800], fontSize: 22)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        });
      });
}
