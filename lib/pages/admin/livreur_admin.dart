import 'package:feul_delivery/styles/textStyles.dart';
import 'package:flutter/material.dart';

class LiveursPage extends StatelessWidget {
  const LiveursPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text(
          'Livreurs',
          style: pageTitle,
        ),
      ),
      body: Container(),
    );
  }
}
