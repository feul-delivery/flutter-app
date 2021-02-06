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
              for (int i = 0; i < items.length; i++) livreurList(i)
            ],
          ),
        ),drawer: Drawerst(),
      bottomNavigationBar: BottomNavigationBarCl(),
    );
  }

  Container livreurList(int i) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
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
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
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
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Container(
                          child: CircleAvatar(
                  radius: 35.0,
                  backgroundImage: AssetImage('assets/profile.png'),
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
                                "Karim chrkawi",
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
                                    child: Text(
                                      "etat : disponible",
                                    )),
                              ),
                              
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  List items = [
    {
      "id": 1,
      "code": "SSH081686",
      "time": "11:00",
      "date": "15/01/2021",
      "etat": "en cour",
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
      "etat": "complet",
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
      "etat": "complet",
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
      "etat": "complet",
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
      "etat": "complet",
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
      "etat": "complet",
      "volume": "43L",
      "couleur": "blue",
      "matricule": "15-A-545454",
      "type": "diesel",
      "adresse": "Rue N° 35467 Avenue alwafae Narjiss fes",
    }
  ];
}
