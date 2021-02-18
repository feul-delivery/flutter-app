import 'package:flutter/material.dart';
import 'package:FD_flutter/pages/station/drawer_st.dart';
import 'package:FD_flutter/pages/station/bbar_st.dart';

import 'index_st.dart';

class ToutCommandesSt extends StatefulWidget {
  @override
  _ToutCommandesStState createState() => _ToutCommandesStState();
}

class _ToutCommandesStState extends State<ToutCommandesSt> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        selectedIndexSt = 0;
        Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => IndexSt()));
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Orders"),
          backgroundColor: Colors.red[900],
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
                for (int i = 0; i < items.length; i++) toutCommandes(i),
              ],
            ),
          ),
        ),
        drawer: DrawerSt(),
        bottomNavigationBar: ButtomBarSt(),
      ),
    );
  }

  Container toutCommandes(int i) {
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
                                      child: Text('Volume: ',
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
                                  child: Text('Address: ',
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
      "etat": "waiting",
      "volume": "10L",
      "type": "Gas-oil",
      "adresse": "Monfleuri 2, Lycée Technique, Fès",
    },
    {
      "nom": "Da7mad ELMAKKAWI",
      "time": "17:05",
      "date": "17/01/2021",
      "etat": "waiting",
      "volume": "50L",
      "type": "Gas-oil",
      "adresse": "Monfleuri 2, Lycée Technique, Fès",
    },
    {
      "nom": "Da7mad ELMAKKAWI",
      "time": "17:01",
      "date": "17/01/2021",
      "etat": "waiting",
      "volume": "43L",
      "type": "Gas-oil",
      "adresse": "Monfleuri 2, Lycée Technique, Fès",
    },
    {
      "nom": "Da7mad ELMAKKAWI",
      "time": "16:50",
      "date": "17/01/2021",
      "etat": "waiting",
      "volume": "43L",
      "type": "Gas-oil",
      "adresse": "Monfleuri 2, Lycée Technique, Fès",
    }
  ];
}
