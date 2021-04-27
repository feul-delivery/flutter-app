import 'package:FD_flutter/modules/order.dart';
import 'package:FD_flutter/shared/splash.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:FD_flutter/wrapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
// import 'package:qr_flutter/qr_flutter.dart';

class OrderDone extends StatefulWidget {
  final Order order;
  OrderDone({@required this.order});
  @override
  _OrderDoneState createState() => _OrderDoneState();
}

bool _isdone;
QuerySnapshot snapshot;

class _OrderDoneState extends State<OrderDone> {
  String qrData;
  @override
  Widget build(BuildContext context) {
    if (_isdone == null) _isdone = widget.order == null ? true : false;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          _isdone == true
              ? IconButton(
                  icon: Icon(
                    Icons.play_arrow_sharp,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(PageTransition(
                        type: PageTransitionType.leftToRight,
                        child: Wrapper()));
                  })
              : Container()
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (_isdone)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width * 1 / 3,
                    width: MediaQuery.of(context).size.width * 1 / 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.green[300],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.white,
                        size: 60,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Text(
                      'Order finished',
                      style: TextStyle(
                        color: Colors.black54,
                        fontFamily: 'Gotham',
                        fontSize: 35,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    "${SplashScreen.mapLang['deliveredASAP']}",
                    style: TextStyle(
                        color: Colors.black26,
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.w200,
                        fontSize: 17),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  // Container(
                  //   height: MediaQuery.of(context).size.width * 2 / 3,
                  //   width: MediaQuery.of(context).size.width * 2 / 3,
                  //   child: QrImage(
                  //     data: qrData,
                  //   ),
                  // ),
                ],
              ),
            if (!_isdone)
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      child: Text(
                        '${SplashScreen.mapLang['orderdetail']} :',
                        style: titleStyle,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 1 / 3,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.date_range_sharp,
                                        color: Colors.black45,
                                        size: 18,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Date :",
                                        style: smallTileGray,
                                      ),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    '${widget.order.dateheurec.day}/${widget.order.dateheurec.month}/${widget.order.dateheurec.year}',
                                    style: tileTitleStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 1 / 3,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.offline_bolt,
                                        color: Colors.black45,
                                        size: 18,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Volume :",
                                        style: smallTileGray,
                                      ),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    '${widget.order.volume}',
                                    style: tileTitleStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 1 / 3,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.list_alt,
                                        color: Colors.black45,
                                        size: 18,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "${SplashScreen.mapLang['ftype']} :",
                                        style: smallTileGray,
                                      ),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    '${widget.order.idtype}',
                                    textAlign: TextAlign.start,
                                    style: tileTitleStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 1 / 3,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.aspect_ratio_sharp,
                                        color: Colors.black45,
                                        size: 18,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "${SplashScreen.mapLang['matricule']} :",
                                        style: smallTileGray,
                                      ),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    '${widget.order.matricule}',
                                    style: tileTitleStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 1 / 3,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.color_lens,
                                        color: Colors.black45,
                                        size: 18,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "${SplashScreen.mapLang['carcolor']} :",
                                        style: smallTileGray,
                                      ),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: Icon(
                                    Icons.airport_shuttle,
                                    color: Color(widget.order.color),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 1 / 2,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Total : ",
                            style: smallTileGray,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Center(
                            child: Text(
                              '${widget.order.prixtotal.toStringAsFixed(2)} Dh',
                              style: tileTitleStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                        radius: 50.0,
                        onTap: () async {
                          Firestore.instance
                              .collection('orders')
                              .document()
                              .setData({
                            'ordernum': widget.order.idorder,
                            'volume': widget.order.volume,
                            'adresse': widget.order.adresse,
                            'dateheurec': DateTime.now().toString(),
                            'dateheurel': DateTime(0000, 0, 0).toString(),
                            'matricule': widget.order.matricule,
                            'color': widget.order.color,
                            'prixtotal': widget.order.prixtotal,
                            'statut': 'waiting',
                            'methode': widget.order.methode,
                            'uidclient': widget.order.uidclient,
                            'uidstation': widget.order.uidentreprise,
                            'uidlivreur': '',
                            'idtype': widget.order.idtype,
                            'coordinates': widget.order.coordinates
                          });

                          // await _databaseService.newOrderData(
                          //     widget.order.idorder,
                          //     widget.order.volume,
                          //     widget.order.adresse,
                          //     DateTime.now().toString(),
                          //     DateTime(0000, 0, 0).toString(),
                          //     widget.order.matricule,
                          //     widget.order.color,
                          //     widget.order.prixtotal,
                          //     'Waiting',
                          //     widget.order.methode,
                          //     widget.order.uidclient,
                          //     widget.order.uidentreprise,
                          //     '',
                          //     widget.order.idtype);
                          // ignore: missing_return
                          // snapshot.documents.firstWhere((element) {
                          //   if (element.data['ordernum'] ==
                          //           widget.order.idorder &&
                          //       element.data['uidclient'] ==
                          //           widget.order.uidclient)
                          //     qrData = element.documentID;
                          // });
                          setState(() {
                            _isdone = true;
                          });
                        },
                        child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 1 / 4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.black),
                          child: Center(
                            child: Text(
                              "${SplashScreen.mapLang['confirm']}",
                              style: buttonStyle,
                            ),
                          ),
                        )),
                  ])
          ],
        ),
      ),
    );
  }
}
