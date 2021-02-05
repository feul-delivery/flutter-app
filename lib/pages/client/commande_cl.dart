import 'package:flutter/material.dart';

class CommandeDetail extends StatefulWidget {
  final int id;
  final String code;
  final String date;
  final String time;
  final String couleur;
  final String matricule;
  final String type;
  final String address;
  CommandeDetail({
    this.id,
    this.code,
    this.date,
    this.time,
    this.couleur,
    this.address,
    this.matricule,
    this.type,
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
          "Détail",
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.format_list_numbered_sharp,
                    color: Colors.black54,
                    size: 18,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Numéro:",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  widget.code,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.date_range_sharp,
                    color: Colors.black54,
                    size: 18,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Date:",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  widget.date,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.timer,
                    color: Colors.black54,
                    size: 18,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "L'heure:",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  widget.time,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.note_add,
                    color: Colors.black54,
                    size: 18,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Matricule de voiteur:",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  widget.matricule,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.color_lens,
                    color: Colors.black54,
                    size: 18,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Coleur:",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  widget.couleur,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.track_changes_sharp,
                    color: Colors.black54,
                    size: 18,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "type diesel:",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  widget.type,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.place,
                    color: Colors.black54,
                    size: 18,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Address",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(28, 0, 28, 0),
                  child: Text(
                    widget.address,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
            color: Colors.orange[900],
            child: FlatButton(
                onPressed: () {},
                child: Text('Envoyer une évaluation!',
                    style: TextStyle(color: Colors.white, fontSize: 15))))
      ],
    );
  }
}
