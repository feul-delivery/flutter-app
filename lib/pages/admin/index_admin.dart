import 'dart:io';
import 'package:feul_delivery/pages/admin/drawer_admin.dart';
import 'package:flutter/material.dart';

class IndexAdmin extends StatefulWidget {
  @override
  _IndexAdminState createState() => _IndexAdminState();
}

class _IndexAdminState extends State<IndexAdmin> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return showDialog(
              context: context,
              builder: (context) => new AlertDialog(
                title: new Text('Etes-vous sur?'),
                content: new Text("Quitter l'application?"),
                actions: <Widget>[
                  new GestureDetector(
                    onTap: () => exit(0),
                    child: Text('OK'),
                  ),
                  SizedBox(height: 16),
                  new GestureDetector(
                    onTap: () => Navigator.of(context).pop(false),
                    child: Container(
                        child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text('Annuler'),
                    )),
                  ),
                ],
              ),
            ) ??
            false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Acceuil"),
          backgroundColor: Colors.red[900],
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  setState(() {});
                })
          ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            margin: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Commandes en direct',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Divider(
                  height: 5,
                  thickness: 1,
                ),
                for (int i = 0; i < items.length; i++)
                  commandtnontermeneState(i),
              ],
            ),
          ),
        ),
        drawer: DrawerAdmin(),
      ),
    );
  }

  Container commandtnontermeneState(int i) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
              decoration: new BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.red[900].withOpacity(0.4),
                        blurRadius: 20,
                        offset: Offset(0, 10))
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(items[i]['nom'],
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15))),
                        ),
                        Container(
                          height: 25,
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red[900],
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 5.0, right: 5.0),
                            child: Center(
                                child: Text(
                              items[i]['time'],
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text('Volume demonder: ',
                                      style:
                                          TextStyle(color: Colors.grey[800])),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  child: Text(items[i]['volume'],
                                      style:
                                          TextStyle(color: Colors.grey[600])),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text('Type:',
                                      style:
                                          TextStyle(color: Colors.grey[800])),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  child: Text(items[i]['type'],
                                      style:
                                          TextStyle(color: Colors.grey[600])),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text('Adresse: ',
                                      style:
                                          TextStyle(color: Colors.grey[800])),
                                ),
                                Container(
                                  child: Text(items[i]['adresse'],
                                      style:
                                          TextStyle(color: Colors.grey[600])),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              )),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  List items = [
    {
      "nom": "Da7mad ELMAKKAWI",
      "time": "17:47",
      "etat": "en cour",
      "volume": "10L",
      "type": "Gas-oil",
      "adresse": "Monfleuri 2, Lycée Technique, Fès",
      "statut": "En attend"
    },
    {
      "nom": "Da7mad ELMAKKAWI",
      "time": "17:05",
      "etat": "en cour",
      "volume": "50L",
      "type": "Gas-oil",
      "adresse": "Monfleuri 2, Lycée Technique, Fès",
      "statut": "En attend"
    },
    {
      "nom": "Da7mad ELMAKKAWI",
      "time": "17:01",
      "etat": "en cour",
      "volume": "43L",
      "type": "Gas-oil",
      "adresse": "Monfleuri 2, Lycée Technique, Fès",
      "statut": "En attend"
    },
    {
      "nom": "Da7mad ELMAKKAWI",
      "time": "16:50",
      "etat": "en cour",
      "volume": "43L",
      "type": "Gas-oil",
      "statut": "En attend",
      "adresse": "Monfleuri 2, Lycée Technique, Fès",
    }
  ];
}
