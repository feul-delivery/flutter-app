import 'package:FD_flutter/pages/livreur/bbar_liv.dart';
import 'package:FD_flutter/pages/livreur/index_lv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'reclamation.dart';

class RapportLiv extends StatefulWidget {
  @override
  _RapportLivState createState() => _RapportLivState();
}

class _RapportLivState extends State<RapportLiv> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Rapports",
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  ButtomBarLiv.selectedIndex = 0;
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => IndexLv()));
                })
          ],
          centerTitle: true,
          backgroundColor: Colors.black,
          elevation: 1,
        ),
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.only(left: 10, right: 10),
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }

  Card cardRapport(int i) {
    IconData etaticon;
    Color rapportColor;
    if (items[i]['etat'] == 'livrée') {
      etaticon = Icons.check;
      rapportColor = Colors.green;
    }
    if (items[i]['etat'] != 'en cours') {
      etaticon = Icons.timer;
      rapportColor = Colors.orange;
    }
    return Card(
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: rapportColor,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(
            etaticon,
            color: Colors.white,
          ),
        ),
        title: Text(items[i]['code']),
        subtitle: Text("${items[i]['date']} - ${items[i]['time']}"),
        trailing: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => ReclamationDetail(
                      code: items[i]['code'],
                      date: items[i]['date'],
                      id: items[i]['id'],
                      time: items[i]['time'],
                      couleur: items[i]['couleur'],
                      address: items[i]['adresse'],
                      matricule: items[i]['matricule'],
                      type: items[i]['type'],
                      message: items[i]['message'],
                    )));
          },
          child: Icon(CupertinoIcons.chevron_right),
        ),
      ),
    );
  }

  List items = [
    {
      "id": 8,
      "code": "SSH081686",
      "time": "10:00",
      "date": "25/01/2021",
      "etat": "in process",
      "volume": "43L",
      "couleur": "blue",
      "matricule": "15-B-545454",
      "type": "diesel",
      "adresse": "Rue N° 35467 Avenue alwafae Narjiss fes",
      "message": 'je suis en colère ma commande rien recus'
    },
    {
      "id": 2,
      "code": "SSH023912",
      "time": "16:00",
      "date": "15/01/2021",
      "etat": "delivered",
      "volume": "50L",
      "couleur": "broun",
      "matricule": "15-A-165876",
      "type": "diesel",
      "adresse": "Rue EL Wifaque N° 81  Mèknes",
      "message":
          "une manque sur la quantité demandé  je demande  une 43L et j'ai recus 40L "
    },
    {
      "id": 3,
      "code": "BC955170",
      "time": "12:00",
      "date": "15/01/2021",
      "etat": "delivered",
      "volume": "43L",
      "couleur": "blue",
      "matricule": "15-A-545454",
      "type": "diesel",
      "adresse": "Rue N° 35467 Avenue alwafae Narjiss fes",
      "message": "Très bonne livraison merci !"
    },
    {
      "id": 17,
      "code": "PC980394",
      "time": "17:00",
      "date": "15/02/2021",
      "etat": "delivered",
      "volume": "20L",
      "couleur": "blue",
      "matricule": "15-B-547774",
      "type": "diesel",
      "adresse": "Rue N° 61 Zouagha fes",
      "message": 'Un erreur sur la commande'
    },
    {
      "id": 6,
      "code": "PC900005",
      "time": "06:00",
      "date": "15/12/2020",
      "etat": "delivered",
      "volume": "40L",
      "couleur": "red",
      "matricule": "15-A-54574",
      "type": "essence",
      "adresse": "Rue lbyad N° 67 Bensouda",
      "message": 'Merci! à la prochaine commande '
    }
  ];

  // ignore: non_constant_identifier_names
  ReclamationDetail(
      {code, date, id, time, couleur, address, matricule, type, message}) {}
}
