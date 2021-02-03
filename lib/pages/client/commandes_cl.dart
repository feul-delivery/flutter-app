import 'package:feul_delivery/pages/client/commande_cl.dart';

import 'package:flutter/material.dart';

import 'commande_cl.dart';

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
            "Mes commandes",
          ),
          centerTitle: true,
          backgroundColor: Colors.orange[900],
          elevation: 1,
        ),
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.only(left: 10, right: 10),
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              for (int i = 0; i < items.length; i++) cartcomd(i)
            ],
          ),
        ));
  }

  Container cartcomd(int i) {
    const titleStylecomplet = TextStyle(
        color: Colors.green, fontSize: 15, fontWeight: FontWeight.bold);
    const titleStyleencoure =
        TextStyle(color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold);
    TextStyle titleStyle;
    IconData etaticon;
    if (items[i]['etat'] == 'complet') {
      titleStyle = titleStylecomplet;
      etaticon = Icons.check;
    }
    if (items[i]['etat'] != 'complet') {
      titleStyle = titleStyleencoure;
      etaticon = Icons.block;
    }

    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => CommandeDetail(code: items[i]['code'],date: items[i]['date'],id: items[i]['id'],)));
         
            },
                      child: Container(
                decoration: new BoxDecoration(
                    color: Colors.orange[900],
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(225, 95, 27, .3),
                          blurRadius: 20,
                          offset: Offset(0, 10))
                    ]),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      decoration: new BoxDecoration(
                          color: Colors.orange[900],
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(225, 95, 27, .3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ]),
                      child: Expanded(
                        flex: 1,
                        child: Container(
                          decoration: new BoxDecoration(
                            color: Colors.orange[900],
                          ),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        items[i]['time'],
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      ),
                                    )),
                                    Container(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        items[i]['date'],
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      ),
                                    )),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: new BoxDecoration(
                          color: Color(0xffffffff),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  "commande n° :" + items[i]['code'],
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Container(
                              child: Row(children: <Widget>[
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      etaticon,
                                      color: Colors.amber,
                                      size: 20,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(items[i]['etat'],
                                          style: titleStyle)),
                                ),
                                SizedBox(width: 60,),
                                Container(
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(items[i]['volume'],
                                          style: TextStyle(color: Colors.grey))),
                                ),
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  List items = [
    {
      "id": 1,
      "code": "SSH081686",
      "time": "11.00",
      "date": "15/01/2021",
      "etat": "en cour",
      "volume": "43L",

    },
    {
      "id": 2,
      "code": "SSH023912",
      "time": "16.00",
      "date": "15/01/2021",
      "etat": "complet",
      "volume": "43L",

    },
    {
      "id": 3,
      "code": "PC985170",
      "time": "12.00",
      "date": "15/01/2021",
      "etat": "complet",
      "volume": "43L",

    },
    {
      "id": 4,
      "code": "PC980394",
      "time": "17.00",
      "date": "15/01/2021",
      "etat": "complet",
      "volume": "43L",

    },
    {
      "id": 5,
      "code": "PC932721",
      "time": "19.00",
      "date": "15/01/2021",
      "etat": "complet",
      "volume": "43L",

    },
    {
      "id": 6,
      "code": "PC900005",
      "time": "06.00",
      "date": "15/01/2021",
      "etat": "complet",
      "volume": "43L",

    }
  ];
}
