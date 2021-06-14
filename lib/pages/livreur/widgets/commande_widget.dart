import 'package:FD_flutter/shared/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:FD_flutter/pages/livreur/commande_details.dart';
import 'package:timeago/timeago.dart' as timeago;

// ignore: must_be_immutable
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
    return Container(
      margin: EdgeInsets.only(top: 20),
      decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                offset: Offset(0, 10))
          ]),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CommandeDetailLv(widget.commande),
            ));
          },
          borderRadius: BorderRadius.circular(20),
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
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 70,
                                  alignment: Alignment.centerRight,
                                  child: Text('Volume:',
                                      style: smallTileGray.copyWith(
                                          color: buttonColor,
                                          fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(widget.commande['volume'].toString() + "L",
                                    style: TextStyle(color: Colors.grey[600])),
                              ],
                            ),
                            Text(
                                timeago.format(
                                    DateTime.parse(
                                        widget.commande['dateheurec']),
                                    locale: 'fr'),
                                style: TextStyle(
                                    color: Colors.orange[600],
                                    fontFamily: 'Quarion')),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 70,
                              alignment: Alignment.centerRight,
                              child: Text('Type:',
                                  style: smallTileGray.copyWith(
                                      color: buttonColor,
                                      fontWeight: FontWeight.w500)),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(widget.commande['idtype'].toString(),
                                style: TextStyle(color: Colors.grey[600])),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 70,
                              alignment: Alignment.centerRight,
                              child: Text('Adresse:',
                                  style: smallTileGray.copyWith(
                                      color: buttonColor,
                                      fontWeight: FontWeight.w500)),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(widget.commande['adresse'].toString(),
                                style: TextStyle(color: Colors.grey[600])),
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
