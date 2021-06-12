import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:FD_flutter/shared/lang.dart';
import 'package:url_launcher/url_launcher.dart';

class CommandeDetailLv extends StatefulWidget {
  final DocumentSnapshot document;
  CommandeDetailLv(
    this.document,
  );
  @override
  _CommandeDetailLvState createState() => _CommandeDetailLvState();
}

class _CommandeDetailLvState extends State<CommandeDetailLv> {
  @override
  Widget build(BuildContext context) {
    DateTime dateC = DateTime.parse(widget.document['dateheurec']);
    int colorV = int.parse(widget.document['color'].toString());
    Color myColor = Color(colorV);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Details",
          style: pageTitleO,
        ),
        leading: IconButton(
          icon: Icon(Icons.west_outlined, color: buttonColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          IconButton(
              onPressed: () {
                _clientDetailSheet(context, widget.document['uidclient']);
              },
              icon: Icon(
                Icons.person_outline_rounded,
                color: buttonColor,
              )),
          IconButton(
              onPressed: () async {
                Map<dynamic, dynamic> _coordinates =
                    widget.document['coordinates'];
                var _mapURL =
                    'https://www.google.com/maps?saddr=Your+Location&daddr=${_coordinates['latitude']},${_coordinates['longitude']}';
                if (await canLaunch(_mapURL)) {
                  await launch(_mapURL);
                }
              },
              icon: Icon(
                Icons.location_on_outlined,
                color: buttonColor,
              )),
        ],
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
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
                      "${Language.mapLang['matricule']}",
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
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                  width: 60,
                ),
                Center(
                  child: Icon(
                    Icons.airport_shuttle_rounded,
                    color: myColor,
                    size: 36,
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _clientDetailSheet(BuildContext context, String uid) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context, setState) {
            return SingleChildScrollView(
                child: StreamBuilder<DocumentSnapshot>(
                    stream: Firestore.instance
                        .collection('client')
                        .document(uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      return Column(
                        children: [
                          Container(
                              padding: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width,
                              color: buttonColor,
                              child: Text(
                                "Client information",
                                style: pageTitleW,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CachedNetworkImage(
                                imageUrl: snapshot?.data['photoURL'] == null
                                    ? ''
                                    : snapshot?.data['photoURL'],
                                imageBuilder: (context, imageProvider) =>
                                    CircleAvatar(
                                        radius: 30.0,
                                        backgroundImage: imageProvider),
                                placeholder: (context, url) => CircleAvatar(
                                    radius: 30.0,
                                    child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    CircleAvatar(
                                        radius: 30.0, child: Icon(Icons.error)),
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
                                          child: Text(
                                              '${snapshot.data['nom'] + ' ' + snapshot.data['prenom']}',
                                              style: TextStyle(
                                                  color: Colors.grey[800],
                                                  fontSize: 22)),
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
                                          child: Text(
                                              '${snapshot.data['tele']}',
                                              style: TextStyle(
                                                  color: Colors.grey[800],
                                                  fontSize: 22)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }));
          });
        });
  }
}
