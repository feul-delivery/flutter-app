import 'package:flutter/material.dart';
import 'package:feul_delivery/pages/station/drawer_st.dart';
import 'package:feul_delivery/pages/station/bbar_st.dart';

class Livreur extends StatefulWidget {
  @override
  _LivreurState createState() => _LivreurState();
}

class _LivreurState extends State<Livreur> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mes livreurs",
        ),
        centerTitle: true,
        backgroundColor: Colors.red[900],
        elevation: 1,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(left: 10, right: 10),
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            for (int i = 0; i < items.length; i++) livreurList(i)
          ],
        ),
      ),
      drawer: Drawerst(),
      bottomNavigationBar: BottomNavigationBarCl(),
    );
  }

  Container livreurList(int i) {
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40.0,
                      backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1594616838951-c155f8d978a0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80",
                      ),
                    ),
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
                                  "active depius :" + items[i]['date'],
                                  style: TextStyle(color: Colors.white),
                                )),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(items[i]['nom'],
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
                                          child: Text('CIN : ',
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text('télé :',
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text('état actual: ',
                                          style: TextStyle(
                                              color: Colors.grey[800])),
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
        ],
      ),
    );
  }

  List items = [
    {
      "date": "15/01/2021",
      "etat": "desponible",
      "nom": "ikram elbakori",
      "cin": "C121212",
      "tele": "+212698989898",
    },
    {
      "date": "15/01/2021",
      "etat": "desponible",
      "nom": "ikram elbakori",
      "cin": "C121212",
      "tele": "+212698989898",
    },
    {
      "date": "15/01/2021",
      "etat": "desponible",
      "nom": "ikram elbakori",
      "cin": "C121212",
      "tele": "+212698989898",
    },
    {
      "date": "15/01/2021",
      "etat": "ikram elbakori",
      "nom": "en cour",
      "cin": "C121212",
      "tele": "+212698989898",
    },
  ];
}
