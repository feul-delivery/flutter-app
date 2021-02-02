import 'package:flutter/material.dart';
import 'package:feul_delivery/pages/client/Commande_detail_col.dart';

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
            padding: EdgeInsets.only(left: 20, right: 20),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.search,
                        size: 38,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Search...')
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: List.generate(
                        menus.length,
                        (index) => InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      menus[index],
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ))),
              ),
              SizedBox(
                height: 50,
              ),
              Column(
                children: List.generate(
                    items.length,
                    (index) => InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ProductDetailPage(
                                          id: items[index]['id'],
                                          name: items[index]['name'],
                                          img: items[index]['img'],
                                          code: items[index]['code'],
                                          pPrice: items[index]['p_price']
                                              .toString(),
                                          pPromotionPrice: items[index]
                                                  ['p_promotion_price']
                                              .toString(),
                                        )));
                          },
                          child: Card(
                            child: Row(
                              children: <Widget>[
                                Hero(
                                  tag: items[index]['id'].toString(),
                                  child: Container(
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                                AssetImage(items[index]['img']),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      items[index]['name'],
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          items[index]['p_promotion_price']
                                                  .toString() +
                                              " USD",
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          items[index]['p_price'].toString() +
                                              " USD",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.red,
                                              fontWeight: FontWeight.w500,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        )),
              )
            ],
          ),
        ));
  }

  List menus = ["Sort by date", "sort by station", "sort by contite"];

  List items = [
    {
      "id": 1,
      "name": "Command01",
      "code": "SSH081686",
      "img": "assets/Feuldelivery.png",
      "p_price": 100.00,
      "p_promotion_price": 55.00
    },
    {
      "id": 2,
      "name": "Command02",
      "code": "SSH023912",
      "img": "assets/Feuldelivery.png",
      "p_price": 120.00,
      "p_promotion_price": 40.00
    },
    {
      "id": 3,
      "name": "Command03",
      "code": "PC985170",
      "img": "assets/Feuldelivery.png",
      "p_price": 130.00,
      "p_promotion_price": 30.00
    },
    {
      "id": 4,
      "name": "Command04",
      "code": "PC980394",
      "img": "assets/Feuldelivery.png",
      "p_price": 200.00,
      "p_promotion_price": 20.00
    },
    {
      "id": 5,
      "name": "Command05",
      "code": "PC932721",
      "img": "assets/Feuldelivery.png",
      "p_price": 150.00,
      "p_promotion_price": 50.00
    },
    {
      "id": 6,
      "name": "Command06",
      "code": "PC900005",
      "img": "assets/Feuldelivery.png",
      "p_price": 200.00,
      "p_promotion_price": 60.00
    }
  ];
}
