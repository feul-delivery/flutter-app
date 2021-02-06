import 'package:flutter/material.dart';
import 'package:feul_delivery/pages/station/drawer_st.dart';
import 'package:feul_delivery/pages/station/bbar_st.dart';

class Commandtermene extends StatefulWidget {
  @override
  _CommandtermeneState createState() => _CommandtermeneState();
}

class _CommandtermeneState extends State<Commandtermene> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("commandes"),
        backgroundColor: Colors.orange[900],
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh_rounded),
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
                'Commandes terméné',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              Divider(
                height: 5,
                thickness: 1,
              ),
              for (int i = 0; i < items.length; i++) commandestermeneState(i),
            ],
          ),
        ),
      ),
      drawer: Drawerst(),
      bottomNavigationBar: BottomNavigationBarCl(),
    );
  }

  Container commandestermeneState(int i) {
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
                        color: Colors.orange[900].withOpacity(0.4),
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
                          height: 25,
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.orange[900],
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 5.0, right: 5.0),
                            child: Center(
                                child: Text(
                              items[i]['date'],
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ),
                        Container(
                          height: 25,
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.orange[900],
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text('Volume demonder: ',
                                          style: TextStyle(
                                              color: Colors.grey[800])),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      child: Text(items[i]['volume'],
                                          style: TextStyle(
                                              color: Colors.grey[600])),
                                    ),
                                  ],
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
                        SizedBox(
                          width: 10,
                        ),
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
      "nom": "Da7mad ELMAKKAWI",
      "time": "17:47",
      "date": "17/01/2021",
      "etat": "en cour",
      "volume": "10L",
      "type": "Gas-oil",
      "adresse": "Monfleuri 2, Lycée Technique, Fès",
    },
    {
      "nom": "Da7mad ELMAKKAWI",
      "time": "17:05",
      "date": "17/01/2021",
      "etat": "en cour",
      "volume": "50L",
      "type": "Gas-oil",
      "adresse": "Monfleuri 2, Lycée Technique, Fès",
    },
    {
      "nom": "Da7mad ELMAKKAWI",
      "time": "17:01",
      "date": "17/01/2021",
      "etat": "en cour",
      "volume": "43L",
      "type": "Gas-oil",
      "adresse": "Monfleuri 2, Lycée Technique, Fès",
    },
    {
      "nom": "Da7mad ELMAKKAWI",
      "time": "16:50",
      "date": "17/01/2021",
      "etat": "en cour",
      "volume": "43L",
      "type": "Gas-oil",
      "adresse": "Monfleuri 2, Lycée Technique, Fès",
    }
  ];
}
