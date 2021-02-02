import 'package:flutter/material.dart';

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
    return Container(
      child: Column(
        children: [
          Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(225, 95, 27, .3),
                        blurRadius: 20,
                        offset: Offset(0, 10))
                  ]),
              child: Card(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                        height: 80,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "commande n° :" + items[i]['code'],
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            items[i]['time'],
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          
                        ],
                      ),
                    ],
                  ),
                ),
              )),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  List items = [
    {
      "id": 1,
      "code": "SSH081686",
      "time": "11.00 14/01/2021",
    },
    {
      "id": 2,
      "code": "SSH023912",
      "time": "16.00 15/01/2021",
    },
    {
      "id": 3,
      "code": "PC985170",
      "time": "12.00 15/01/2021",
    },
    {
      "id": 4,
      "code": "PC980394",
      "time": "17.00 15/01/2021",
    },
    {
      "id": 5,
      "name": "Command05",
      "code": "PC932721",
      "time": "19.00 15/01/2021",
    },
    {
      "id": 6,
      "code": "PC900005",
      "time": "06.00 15/01/2021",
    }
  ];
}
