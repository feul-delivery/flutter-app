import 'package:feul_delivery/styles/textStyles.dart';
import 'package:flutter/material.dart';

enum pmethode { livraison, google }

class CommandePayment extends StatefulWidget {
  const CommandePayment({Key key}) : super(key: key);

  @override
  _CommandePaymentState createState() => _CommandePaymentState();
}

class _CommandePaymentState extends State<CommandePayment> {
  pmethode _methode = pmethode.livraison;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text(
          'Payement',
          style: pageTitle,
        ),
        actions: [FlatButton(onPressed: () {}, child: Text('Terminer'))],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text('Paiement à la livraison'),
              leading: Radio(
                  activeColor: Colors.red[900],
                  value: pmethode.livraison,
                  groupValue: _methode,
                  onChanged: (pmethode valeur) {
                    _methode = valeur;
                  }),
            ),
            ListTile(
              title: Text('G-Pay'),
              leading: Radio(
                  activeColor: Colors.red[900],
                  value: pmethode.google,
                  groupValue: _methode,
                  onChanged: (pmethode valeur) {
                    _methode = valeur;
                  }),
            )
          ],
        ),
      ),
    );
  }
}
