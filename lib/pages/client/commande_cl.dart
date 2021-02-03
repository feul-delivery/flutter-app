import 'package:flutter/material.dart';

class CommandeDetail extends StatefulWidget {
  final int id;
  final String code;
  final String date;
  CommandeDetail({
    this.id,
    this.code,
    this.date,
  });
  @override
  _CommandeDetailState createState() => _CommandeDetailState();
}

class _CommandeDetailState extends State<CommandeDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Commande detail",
          style: TextStyle(),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange[900],
        elevation: 1,
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            children: <Widget>[
              Text(
                "Code :",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                widget.code,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            children: <Widget>[
              Text(
                "date :",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                widget.date,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
