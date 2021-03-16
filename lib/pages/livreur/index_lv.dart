import 'package:flutter/material.dart';

class IndexLv extends StatefulWidget {
  IndexLv({Key key}) : super(key: key);

  @override
  _IndexLvState createState() => _IndexLvState();
}

class _IndexLvState extends State<IndexLv> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Livreur"),
      ),
    );
  }
}
