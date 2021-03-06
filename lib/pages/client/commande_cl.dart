import 'package:FD_flutter/shared/lang.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'merci.dart';

class CommandeDetail extends StatefulWidget {
  final DocumentSnapshot document;
  CommandeDetail({@required this.document});
  @override
  _CommandeDetailState createState() => _CommandeDetailState();
}

String statutOld;

class _CommandeDetailState extends State<CommandeDetail> {
  @override
  void initState() {
    super.initState();
    statutOld = widget.document.data['statut'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackground,
      appBar: AppBar(
        title: Text("${Language.mapLang['detail']}", style: pageTitleW),
        leading: IconButton(
            icon: Icon(Icons.west, color: buttonColor),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: darkGray,
        elevation: 1,
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
                      color: buttonColor,
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
                          color: buttonColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Text(
                    '${widget.document['ordernum']}',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70),
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
                      color: buttonColor,
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
                          color: buttonColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Text(
                    '${DateTime.parse(widget.document['dateheurec']).day.toString()}/${DateTime.parse(widget.document['dateheurec']).month.toString()}/${DateTime.parse(widget.document['dateheurec']).year.toString()}',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70),
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
                      color: buttonColor,
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
                          color: buttonColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Text(
                    '${DateFormat.Hm().format(DateTime.parse(widget.document['dateheurec']))}',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70),
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
                      color: buttonColor,
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
                          color: buttonColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Text(
                    '${widget.document['matricule']}',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70),
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
                      color: buttonColor,
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
                          color: buttonColor),
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
                      color: buttonColor,
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
                          color: buttonColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Text(
                    '${widget.document['idtype']}',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70),
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
                      color: buttonColor,
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
                          color: buttonColor),
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
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: _checkstatut(widget.document.data['statut'],
              widget.document?.data['uidlivreur'])
          ? SizedBox.shrink()
          : FloatingActionButton.extended(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: darkGray,
                        content: Container(
                          color: darkGray,
                          height:
                              MediaQuery.of(context).size.width * 2 / 3 + 15,
                          width: MediaQuery.of(context).size.width * 2 / 3,
                          child: Column(
                            children: [
                              QrImage(
                                foregroundColor: Colors.white,
                                data: '${widget.document.documentID}',
                              ),
                              Container(
                                child: Text(
                                  "${Language.mapLang['deliveryqr']}",
                                  style: hintStyle.copyWith(
                                      color: Colors.white, fontSize: 12),
                                  textAlign: TextAlign.justify,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    });
                Firestore.instance
                    .collection('orders')
                    .document(widget.document.documentID)
                    .snapshots()
                    .listen((event) {
                  String statutNew = event.data['statut'];
                  if (statutNew == 'done' && statutOld == 'waiting') {
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => CommandeCompleted()));
                    // showDialog(
                    //     context: context,
                    //     builder: (BuildContext context) {
                    //       return AlertDialog(
                    //         backgroundColor: darkGray,
                    //         content: Container(
                    //           margin: EdgeInsets.all(5),
                    //           decoration: BoxDecoration(
                    //               border: Border.all(color: Colors.white)),
                    //           padding: EdgeInsets.symmetric(
                    //               vertical: 10, horizontal: 20),
                    //           child: Container(
                    //             child: Text(
                    //               "merci d'être patient, dans l'attente de la prochaine commande",
                    //               style: TextStyle(
                    //                   fontSize: 18, color: Colors.white),
                    //               textAlign: TextAlign.justify,
                    //             ),
                    //           ),
                    //         ),
                    //       );
                    //     });
                  }
                });
              },
              label: Text('livrez..', style: pageTitleW.copyWith(fontSize: 14)),
              icon: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                  backgroundColor: buttonColor),
              backgroundColor: buttonColor,
              elevation: 0,
            ),
    );
  }
}

bool _checkstatut(String statut, String livreur) {
  if (statut == 'waiting' && livreur != null) return false;
  return true;
}
