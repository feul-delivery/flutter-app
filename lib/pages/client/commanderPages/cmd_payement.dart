import 'package:FD_flutter/shared/text_styles.dart';
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
        centerTitle: true,
        backgroundColor: Colors.red[900],
        title: Text(
          'Payment',
          style: pageTitle,
        ),
        actions: [
          FlatButton(
              onPressed: () {},
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
