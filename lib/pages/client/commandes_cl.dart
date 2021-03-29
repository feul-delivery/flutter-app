import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'bbar_cl.dart';
import 'commande_cl.dart';
import 'index_cl.dart';

class CommandeCl extends StatefulWidget {
  @override
  _CommandeClState createState() => _CommandeClState();
}

class _CommandeClState extends State<CommandeCl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "My orders",
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  ButtomBarCl.selectedIndex = 0;
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => IndexCl()));
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
              for (int i = 0; i < items.length; i++) cardCommande(i),
            ],
          ),
        ));
  }

  Card cardCommande(int i) {
    IconData etaticon;
    Color commandColor;
    if (items[i]['etat'] == 'delivered') {
      etaticon = Icons.check;
      commandColor = Colors.green;
    }
    if (items[i]['etat'] != 'delivered') {
      etaticon = Icons.timer;
      commandColor = Colors.orange;
    }
    return Card(
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: commandColor,
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
                builder: (BuildContext context) => CommandeDetail(
                      code: items[i]['code'],
                      date: items[i]['date'],
                      id: items[i]['id'],
                      time: items[i]['time'],
                      couleur: items[i]['couleur'],
                      address: items[i]['adresse'],
                      matricule: items[i]['matricule'],
                      type: items[i]['type'],
                    )));
          },
          child: Icon(CupertinoIcons.chevron_right),
        ),
      ),
    );
  }

  List items = [
    {
      "id": 1,
      "code": "SSH081686",
      "time": "11:00",
      "date": "15/01/2021",
      "etat": "in process",
      "volume": "43L",
      "couleur": "blue",
      "matricule": "15-A-545454",
      "type": "diesel",
      "adresse": "Rue N° 35467 Avenue alwafae Narjiss fes",
    },
    {
      "id": 2,
      "code": "SSH023912",
      "time": "16:00",
      "date": "15/01/2021",
      "etat": "delivered",
      "volume": "43L",
      "couleur": "blue",
      "matricule": "15-A-545454",
      "type": "diesel",
      "adresse": "Rue N° 35467 Avenue alwafae Narjiss fes",
    },
    {
      "id": 3,
      "code": "PC985170",
      "time": "12:00",
      "date": "15/01/2021",
      "etat": "delivered",
      "volume": "43L",
      "couleur": "blue",
      "matricule": "15-A-545454",
      "type": "diesel",
      "adresse": "Rue N° 35467 Avenue alwafae Narjiss fes",
    },
    {
      "id": 4,
      "code": "PC980394",
      "time": "17:00",
      "date": "15/01/2021",
      "etat": "delivered",
      "volume": "43L",
      "couleur": "blue",
      "matricule": "15-A-545454",
      "type": "diesel",
      "adresse": "Rue N° 35467 Avenue alwafae Narjiss fes",
    },
    {
      "id": 5,
      "code": "PC932721",
      "time": "19:00",
      "date": "15/01/2021",
      "etat": "delivered",
      "volume": "43L",
      "couleur": "blue",
      "matricule": "15-A-545454",
      "type": "diesel",
      "adresse": "Rue N° 35467 Avenue alwafae Narjiss fes",
    },
    {
      "id": 5,
      "code": "PC932721",
      "time": "19:00",
      "date": "15/01/2021",
      "etat": "delivered",
      "volume": "43L",
      "couleur": "blue",
      "matricule": "15-A-545454",
      "type": "diesel",
      "adresse": "Rue N° 35467 Avenue alwafae Narjiss fes",
    },
    {
      "id": 6,
      "code": "PC900005",
      "time": "06:00",
      "date": "15/01/2021",
      "etat": "delivered",
      "volume": "43L",
      "couleur": "blue",
      "matricule": "15-A-545454",
      "type": "diesel",
      "adresse": "Rue N° 35467 Avenue alwafae Narjiss fes",
    }
  ];
}
