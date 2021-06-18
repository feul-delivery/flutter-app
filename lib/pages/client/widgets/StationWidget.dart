import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../modules/user.dart';

class StationWidget extends StatefulWidget {
  String id;
  StationWidget({@required this.id});

  @override
  _StationWidgetState createState() => _StationWidgetState();
}

class _StationWidgetState extends State<StationWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection('entreprise')
              .document(widget.id)
              .snapshots(),
          builder: (context, snapshot) {
            return ListTile(
              title: Text(snapshot.data['titre'].toString()),
            );
          }),
    );
  }
}
