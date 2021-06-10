import 'package:FD_flutter/shared/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommandeWidget extends StatefulWidget {
  DocumentSnapshot commande;
  CommandeWidget({@required this.commande});

  @override
  _CommandeWidgetState createState() => _CommandeWidgetState();
}

class _CommandeWidgetState extends State<CommandeWidget> {
  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('fr', timeago.FrMessages());
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: buttonColor.withOpacity(0.4),
                    blurRadius: 20,
                    offset: Offset(0, 10))
              ]),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  child: Text(
                                      widget.commande['volume'].toString() +
                                          "L",
                                      style:
                                          TextStyle(color: Colors.grey[600])),
                                ),
                              ],
                            ),
                            Container(
                              child: Text(
                                  timeago
                                      .format(
                                          DateTime.parse(
                                              widget.commande['dateheurel']),
                                          locale: 'fr')
                                      .toString(),
                                  style: TextStyle(color: Colors.orange[600])),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Text('Type:',
                                  style: TextStyle(color: Colors.grey[800])),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              child: Text(widget.commande['idtype'].toString(),
                                  style: TextStyle(color: Colors.grey[600])),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text('Address:',
                                  style: TextStyle(color: Colors.grey[800])),
                            ),
                            Container(
                              child: Text(widget.commande['adresse'],
                                  style: TextStyle(color: Colors.grey[600])),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              )),
        )
      ],
    );
  }
}
