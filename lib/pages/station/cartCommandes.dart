import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class ToutCommandes extends StatefulWidget {
  final DocumentSnapshot document;
  final String xox;
  ToutCommandes(this.document, this.xox);
  @override
  _ToutCommandesState createState() => _ToutCommandesState();
}

class _ToutCommandesState extends State<ToutCommandes> {
  var pnom = 'N/A';

  @override
  void initState() {
    super.initState();
    getNom();
    timeago.setLocaleMessages('fr', timeago.FrMessages());
  }

  Future getNom() async {
    await Firestore.instance
        .collection('client')
        .document(widget.document['uidclient'])
        .get()
        .then((value) async {
      if (value.exists) {
        var key1 = await value.data['prenom'];
        var key2 = await value.data['nom'];
        setState(() {
          pnom = key1 + ' ' + key2;
          print(pnom);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var document = widget.document;
    DateTime date = DateTime.parse(document['dateheurec']);
    if (widget.xox == 'histo') {
      return Container(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
                decoration: new BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 20,
                          offset: Offset(0, 10))
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 25,
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black,
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 5.0, right: 5.0),
                              child: Center(
                                  child: Text(
                                DateFormat.Hm().format(date),
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                          ),
                          Container(
                            height: 25,
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black,
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 5.0, right: 5.0),
                              child: Center(
                                  child: Text(
                                "${date.day}/${date.month}/${date.year}",
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text('$pnom',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18))),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Container(
                                        child: Text('Volume: ',
                                            style: TextStyle(
                                                color: Colors.grey[800])),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Container(
                                        child: Text('${document['volume']}L',
                                            style: TextStyle(
                                                color: Colors.grey[600])),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 40,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: Text('Type:',
                                        style:
                                            TextStyle(color: Colors.grey[800])),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Container(
                                    child: Text(document['idtype'],
                                        textAlign: TextAlign.center,
                                        style:
                                            TextStyle(color: Colors.grey[600])),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text('Address: ',
                                        style:
                                            TextStyle(color: Colors.grey[800])),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        3 /
                                        5,
                                    alignment: Alignment.centerLeft,
                                    child: Text(document['adresse'],
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        style:
                                            TextStyle(color: Colors.grey[600])),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      )
                    ],
                  ),
                )),
          ],
        ),
      );
    } else {
      return Container(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
                decoration: new BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 20,
                          offset: Offset(0, 10))
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(pnom,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15))),
                          ),
                          Container(
                            height: 25,
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black,
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 5.0, right: 5.0),
                              child: Center(
                                  child: Text(
                                timeago.format(date, locale: 'fr'),
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text('Volume:',
                                        style:
                                            TextStyle(color: Colors.grey[800])),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    child: Text('${document['volume']}L',
                                        style:
                                            TextStyle(color: Colors.grey[600])),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Text('Type:',
                                        style:
                                            TextStyle(color: Colors.grey[800])),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    child: Text(document['idtype'],
                                        style:
                                            TextStyle(color: Colors.grey[600])),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text('Address:',
                                        style:
                                            TextStyle(color: Colors.grey[800])),
                                  ),
                                  Container(
                                    child: Text(document['adresse'],
                                        style:
                                            TextStyle(color: Colors.grey[600])),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                )),
          ],
        ),
      );
    }
  }
}
