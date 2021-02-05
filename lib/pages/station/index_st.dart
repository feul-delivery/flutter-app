import 'dart:io';
import 'package:flutter/material.dart';
import 'package:feul_delivery/pages/station/drawer_st.dart';
import 'package:feul_delivery/pages/station/bbar_st.dart';

class St extends StatefulWidget {
  @override
  _StState createState() => _StState();
}

class _StState extends State<St> {
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
          backgroundColor: Colors.orange[900],
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            margin: const EdgeInsets.fromLTRB(25.0, 35.0, 25.0, 15.0),
            child: Column(
              children: <Widget>[
                Text(
                  'comnande non delevery',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                for (int i = 0; i < items.length; i++)
                  commandtnontermeneState(i)
              ],
            ),
          ),
        ),
        drawer: drawerst(),
        bottomNavigationBar: BottomNavigationBarCl(),
      ),
    );
  }

  Container commandtnontermeneState(int i) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Container(
              decoration: new BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(225, 95, 27, .3),
                        blurRadius: 20,
                        offset: Offset(0, 10))
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Container(
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(items[i]['nom'],
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15))),
                        ),
                        SizedBox(
                          width: 120,
                        ),
                        Container(
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(items[i]['time'],
                                  style: TextStyle(color: Colors.grey))),
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
                                  child: Text('Volume demonder : ',
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
                                  child: Text('Type : ',
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
                                  child: Text('Adresse : ',
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
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 30,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.orange[700],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: Text(items[i]['statu'])),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }

  List items = [
    {
      "nom": "saed massawi",
      "time": "11:00",
      "etat": "en cour",
      "volume": "43L",
      "type": "diesel",
      "adresse": "Rue N° 35467 \nAvenue alwafae Narjiss \nfes",
      "statu": "en attend"
    },
    {
      "nom": "saed massawi",
      "time": "11:00",
      "etat": "en cour",
      "volume": "43L",
      "type": "diesel",
      "adresse": "Rue N° 35467 \nAvenue alwafae Narjiss \nfes",
      "statu": "en attend"
    },
    {
      "nom": "saed massawi",
      "time": "11:00",
      "etat": "en cour",
      "volume": "43L",
      "type": "diesel",
      "adresse": "Rue N° 35467 \nAvenue alwafae Narjiss \nfes",
      "statu": "en attend"
    },
    {
      "nom": "saed massawi",
      "time": "11:00",
      "etat": "en cour",
      "volume": "43L",
      "type": "diesel",
      "statu": "en attend",
      "adresse": "Rue N° 35467 \nAvenue alwafae Narjiss \nfes",
    }
  ];
}
