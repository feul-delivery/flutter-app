import 'package:FD_flutter/pages/station/add_livreur.dart';
import 'package:flutter/material.dart';
import 'package:FD_flutter/pages/station/drawer_st.dart';
import 'package:FD_flutter/pages/station/bbar_st.dart';

import 'index_st.dart';

class LivreurSt extends StatefulWidget {
  @override
  _LivreurStState createState() => _LivreurStState();
}

class _LivreurStState extends State<LivreurSt> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        ButtomBarSt.selectedIndexSt = 0;
        Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => IndexSt()));
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => AddLivreur()));
              },
              child: Container(
                padding: EdgeInsets.all(15),
                child: Icon(Icons.group_add),
              ),
            ),
          ],
          title: Text(
            "Livreurs",
          ),
          centerTitle: true,
          backgroundColor: Colors.red[900],
          elevation: 1,
        ),
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.only(left: 5, right: 5),
            children: <Widget>[
              for (int i = 0; i < items.length; i++) livreurList(i)
            ],
          ),
        ),
        drawer: DrawerSt(),
        bottomNavigationBar: ButtomBarSt(),
      ),
    );
  }

  Container livreurList(int i) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {},
            child: Container(
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 100,
                          width: 150,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image(
                                fit: BoxFit.fitWidth,
                                image: AssetImage("assets/profile.png")),
                          )),
                      Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: 25,
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.red[900],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, right: 5.0),
                                  child: Center(
                                      child: Text(
                                    "Since:  " + items[i]['date'],
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    items[i]['nom'] + ' ' + items[i]['prenom'],
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15))),
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text('CIN: ',
                                                style: TextStyle(
                                                    color: Colors.grey[800])),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            child: Text(items[i]['cin'],
                                                style: TextStyle(
                                                    color: Colors.grey[600])),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text('Phone:',
                                            style: TextStyle(
                                                color: Colors.grey[800])),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        child: Text(items[i]['tele'],
                                            style: TextStyle(
                                                color: Colors.grey[600])),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text('Status:',
                                            style: TextStyle(
                                                color: Colors.grey[800])),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        child: Text(items[i]['etat'],
                                            style: TextStyle(
                                                color: Colors.grey[600])),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }

  List items = [
    {
      "image": "assets/profile.png",
      "date": "10/04/2019",
      "etat": "Disponible",
      "nom": "ELBAKORI",
      "prenom": "Ikram",
      "cin": "C121212",
      "tele": "+212698989898",
    },
    {
      "image": "assets/profile.png",
      "date": "01/02/2020",
      "etat": "Disponible",
      "nom": "AZAMI",
      "prenom": "Farid",
      "cin": "C121212",
      "tele": "+212698989898",
    },
    {
      "image": "assets/profile.png",
      "date": "15/01/2020",
      "etat": "Disponible",
      "nom": "MANSORI",
      "prenom": "Amal",
      "cin": "C121212",
      "tele": "+212698989898",
    },
    {
      "image": "assets/profile.png",
      "date": "15/08/2018",
      "etat": "En cour",
      "nom": "BENFARES",
      "prenom": "Mohamed",
      "cin": "C121212",
      "tele": "+212698989898",
    },
  ];
}
