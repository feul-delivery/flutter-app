import 'package:FD_flutter/modules/order.dart';
import 'package:FD_flutter/services/database.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class OrderDone extends StatefulWidget {
  final Order order;
  OrderDone({@required this.order});
  @override
  _OrderDoneState createState() => _OrderDoneState();
}

DatabaseService _databaseService = DatabaseService();
bool _isdone = false;

class _OrderDoneState extends State<OrderDone> {
  String qrData = 'Welcome';
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isdone)
              Column(
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
                children: [
//order infos shoud be  right here
                  InkWell(
                      onTap: () async {
                        await _databaseService.newOrderData(
                            widget.order.idorder,
                            widget.order.volume,
                            widget.order.adresse,
                            DateTime.now(),
                            DateTime(0000, 0, 0),
                            widget.order.matricule,
                            widget.order.color,
                            widget.order.prixtotal,
                            'Waiting',
                            widget.order.methode,
                            widget.order.uidclient,
                            widget.order.uidentreprise,
                            '',
                            widget.order.idtype);
                        setState(() {
                          _isdone = true;
                        });
                      },
                      child: Container(
                        child: Center(
                          child: Text('Confirm'),
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
