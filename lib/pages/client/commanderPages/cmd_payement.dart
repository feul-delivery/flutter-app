import 'package:FD_flutter/modules/order.dart';
import 'package:FD_flutter/pages/client/commanderPages/cmd_done.dart';
import 'package:FD_flutter/services/database.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:flutter/material.dart';

enum pmethode { livraison, google }

// ignore: must_be_immutable
class CommandePayment extends StatefulWidget {
  Order newOrder;
  CommandePayment({@required this.newOrder});

  @override
  _CommandePaymentState createState() => _CommandePaymentState();
}

class _CommandePaymentState extends State<CommandePayment> {
  pmethode _methode = pmethode.livraison;
  @override
  Widget build(BuildContext context) {
    var _order = widget.newOrder;
    DatabaseService _databaseService = DatabaseService();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red[900],
        title: Text(
          'Payment',
          style: pageTitle,
        ),
        actions: [
          FlatButton(
              onPressed: () async {
                _order.methode = 'COD';
                await _databaseService.newOrderData(
                    _order.idorder,
                    _order.volume,
                    _order.adresse,
                    DateTime.now(),
                    DateTime(0000, 0, 0),
                    _order.matricule,
                    _order.color,
                    _order.prixtotal,
                    'Waiting',
                    _order.methode,
                    _order.uidclient,
                    _order.uidentreprise,
                    '',
                    _order.idtype);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderDone(
                        order: _order,
                      ),
                    ));
              },
              child: Text(
                'Finish',
                style: buttonStyle,
              ))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text('Cash on delivery'),
              leading: Radio(
                  activeColor: Colors.red[900],
                  value: pmethode.livraison,
                  groupValue: _methode,
                  onChanged: (pmethode valeur) {
                    setState(() {
                      _methode = valeur;
                    });
                  }),
            ),
            ListTile(
              title: Text('G-Pay'),
              leading: Radio(
                  activeColor: Colors.red[900],
                  value: pmethode.google,
                  groupValue: _methode,
                  onChanged: (pmethode valeur) {
                    setState(() {
                      _methode = valeur;
                    });
                  }),
            )
          ],
        ),
      ),
    );
  }
}
