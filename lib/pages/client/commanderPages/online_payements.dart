import 'package:FD_flutter/modules/order.dart';
import 'package:FD_flutter/pages/client/commanderPages/cmd_done.dart';
import 'package:FD_flutter/shared/lang.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:square_in_app_payments/in_app_payments.dart';
import 'package:square_in_app_payments/models.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class OnlinePayments extends StatefulWidget {
  final Order order;
  OnlinePayments({@required this.order}) {
    WidgetsFlutterBinding.ensureInitialized();
  }

  @override
  _OnlinePaymentsState createState() => _OnlinePaymentsState();
}

class _OnlinePaymentsState extends State<OnlinePayments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              child: Text(
                '${Language.mapLang['orderdetail']}',
                style: subTitleStyleW,
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.only(left: 40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
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
                                  "Date:",
                                  style: smallTileGray,
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: Text(
                              '${widget.order.dateheurec.day}/${widget.order.dateheurec.month}/${widget.order.dateheurec.year}',
                              style: tileTitleStyleW,
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
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
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
                                  "Volume:",
                                  style: smallTileGray,
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: Text(
                              '${widget.order.volume}',
                              style: tileTitleStyleW,
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
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
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
                                  "${Language.mapLang['ftype']}:",
                                  style: smallTileGray,
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: Text(
                              '${widget.order.idtype}',
                              textAlign: TextAlign.start,
                              style: tileTitleStyleW,
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
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
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
                                  "${Language.mapLang['matricule']}:",
                                  style: smallTileGray,
                                  overflow: TextOverflow.fade,
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: Text(
                              '${widget.order.matricule}',
                              style: tileTitleStyleW,
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
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
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
                                  "${Language.mapLang['carcolor']}:",
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
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 1 / 2,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Total:",
                    style: tileTitleStyle,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Center(
                    child: Text(
                      '${widget.order.prixtotal.toStringAsFixed(2)} Dh',
                      style: smallTileB,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
                onTap: () async {
                  _pay();
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  height: 40,
                  width: MediaQuery.of(context).size.width * 1 / 4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.black),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${Language.mapLang['pay']}",
                          style: buttonStyle,
                        ),
                        Icon(
                          Icons.payment,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                )),
          ]),
    );
  }

  void _pay() {
    InAppPayments.setSquareApplicationId(
        'sandbox-sq0idb-WYzQeRGhjsAlGsWKeZCkRA');
    InAppPayments.startCardEntryFlow(
      onCardEntryCancel: _cardEntryCancel,
      onCardNonceRequestSuccess: _cardNonceRequestSuccess,
    );
  }

  void _cardNonceRequestSuccess(CardDetails result) {
    // Use this nonce from your backend to pay via Square API
    print(result.nonce);

    final bool _invalidZipCode = false;

    if (_invalidZipCode) {
      // Stay in the card flow and show an error:
      InAppPayments.showCardNonceProcessingError('Invalid ZipCode');
    }

    InAppPayments.completeCardEntry(
      onCardEntryComplete: _cardEntryComplete,
    );
  }

  void _cardEntryCancel() {
//cancelled card
  }
  void _cardEntryComplete() {
//successful payment
    Firestore.instance.collection('orders').document().setData({
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
    });
    Navigator.of(context).pushReplacement(PageTransition(
        type: PageTransitionType.leftToRight, child: OrderDone(order: null)));
  }
}
