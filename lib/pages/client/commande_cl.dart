import 'package:FD_flutter/shared/lang.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class CommandeDetail extends StatefulWidget {
  final DocumentSnapshot document;
  CommandeDetail({@required this.document});
  @override
  _CommandeDetailState createState() => _CommandeDetailState();
}

class _CommandeDetailState extends State<CommandeDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackground,
      appBar: AppBar(
        title: Text(
          "${Language.mapLang['detail']}",
          style: pageTitleX,
        ),
        leading: IconButton(
            icon: Icon(OMIcons.arrowBack, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
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
                Icons.new_releases,
                color: Colors.black,
              )),
        ],
      ),
      body: ListView(
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
                      "${Language.mapLang['number']} :",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Text(
                    '${widget.document['ordernum']}',
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
                      "Date :",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Text(
                    '${DateTime.parse(widget.document['dateheurec']).day.toString()}/${DateTime.parse(widget.document['dateheurec']).month.toString()}/${DateTime.parse(widget.document['dateheurec']).year.toString()}',
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
                      Icons.timer,
                      color: Colors.black54,
                      size: 18,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "${Language.mapLang['time']} :",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Text(
                    '${DateFormat.Hm().format(DateTime.parse(widget.document['dateheurec']))}',
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
                      "${Language.mapLang['matricule']} :",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Text(
                    '${widget.document['matricule']}',
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
                      "${Language.mapLang['carcolor']} :",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Icon(
                    Icons.airport_shuttle_rounded,
                    color: Color(widget.document['color']),
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
                      "${Language.mapLang['ftype']} :",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Text(
                    '${widget.document['idtype']}',
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
                      "${Language.mapLang['address']}",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(28, 0, 28, 0),
                    child: Text(
                      '${widget.document['adresse']}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.width * 2 / 3,
                    width: MediaQuery.of(context).size.width * 2 / 3,
                    child: QrImage(
                      data: '${widget.document.documentID}',
                      //   embeddedImage: AssetImage('assets/profile.png'),
                      //   embeddedImageStyle:
                      //       QrEmbeddedImageStyle(size: Size(50, 50)),
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
}
