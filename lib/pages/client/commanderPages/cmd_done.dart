import 'package:FD_flutter/modules/order.dart';
import 'package:FD_flutter/services/database.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:FD_flutter/wrapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qr_flutter/qr_flutter.dart';

class OrderDone extends StatefulWidget {
  final Order order;
  OrderDone({@required this.order});
  @override
  _OrderDoneState createState() => _OrderDoneState();
}

bool _isdone = false;
QuerySnapshot snapshot;

class _OrderDoneState extends State<OrderDone> {
  String qrData;
  @override
  Widget build(BuildContext context) {
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
                    child: Material(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.green[300],
                        child: Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Center(
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.white,
                              size: 60,
                            ),
                          ),
                        )),
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
                    'will be delivered ASAP',
                    style: TextStyle(
                        color: Colors.black26,
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.w200,
                        fontSize: 17),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.width * 2 / 3,
                    width: MediaQuery.of(context).size.width * 2 / 3,
                    child: QrImage(
                      data: qrData,
                    ),
                  ),
                ],
              ),
            if (!_isdone)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
//order infos shoud be  right here
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.date_range_sharp,
                                      color: Colors.black54,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      "Date:",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.offline_bolt,
                                      color: Colors.black54,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      "Volume:",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.list_alt,
                                      color: Colors.black54,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      "Type:",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.aspect_ratio_sharp,
                                      color: Colors.black54,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      "Matricule:",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.airport_shuttle,
                                      color: Colors.black54,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      "Color:",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        '${widget.order.dateheurec.day}/${widget.order.dateheurec.month}/${widget.order.dateheurec.year}',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        '${widget.order.volume}',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        '${widget.order.idtype}',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        '${widget.order.matricule}',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Icon(
                                        Icons.color_lens,
                                        // color: Color(widget.order.color),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Total:",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Center(
                          child: Text('${widget.order.prixtotal} Dh'
                              // color: Color(widget.order.color),
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
                          'statut': 'Waiting',
                          'methode': widget.order.methode,
                          'uidclient': widget.order.uidclient,
                          'uidstation': widget.order.uidentreprise,
                          'uidlivreur': '',
                          'idtype': widget.order.idtype,
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
                            'Confirm',
                            style: buttonStyle,
                          ),
                        ),
                      )),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
