import 'package:FD_flutter/modules/order.dart';
import 'package:FD_flutter/modules/user.dart';
import 'package:FD_flutter/pages/client/commanderPages/cmd_done.dart';
import 'package:FD_flutter/pages/client/commanderPages/online_payements.dart';
import 'package:FD_flutter/services/database.dart';
import 'package:FD_flutter/shared/custom_alert_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

enum pmethode { livraison, google }

class ClientOrder extends StatefulWidget {
  final DocumentSnapshot doc;
  ClientOrder({@required this.doc});
  @override
  _ClientOrderState createState() => _ClientOrderState();
}

class _ClientOrderState extends State<ClientOrder> {
  double _volume;
  Map<dynamic, dynamic> _type;
  String _adresse;
  String _matricule;
  String _methode;
  Color _pickerColor = Color(0xffff6b81);
  Color _carColor = Color(0xffff6b81);
  pmethode _methd = pmethode.livraison;

  Future<void> _showModalSheetPayment(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context, setState) {
            return Container(
                height: MediaQuery.of(context).size.height * 1 / 4,
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.all(20),
                          child: Text(
                            'Payment',
                            style: pageTitle,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (_methd == pmethode.google) {
                              _methode = 'GPAY';
                            } else {
                              _methode = 'COD';
                            }
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(50)),
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: Center(
                              child: Text(
                                'Finish',
                                style: buttonStyle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text('Cash on delivery'),
                            leading: Radio(
                                activeColor: Colors.black,
                                value: pmethode.livraison,
                                groupValue: _methd,
                                onChanged: (pmethode valeur) {
                                  _methd = valeur;
                                }),
                          ),
                          ListTile(
                            title: Text('G-Pay'),
                            leading: Radio(
                                activeColor: Colors.black,
                                value: pmethode.google,
                                groupValue: _methd,
                                onChanged: (pmethode valeur) {
                                  _methd = valeur;
                                }),
                          )
                        ],
                      ),
                    ),
                  ],
                ));
          });
        });
  }

  void changeColor(Color color) {
    setState(() => _pickerColor = color);
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final _formKey = GlobalKey<FormState>();
    var doc = widget.doc;
    List<Map<dynamic, dynamic>> _types =
        List<Map<dynamic, dynamic>>.from(doc['type']).toList();
    final user = Provider.of<User>(context);
    int _orderNum = 1;
    DatabaseService _auth = DatabaseService();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order",
          style: pageTitle,
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.payment,
                color: Colors.white,
              ),
              onPressed: () => _showModalSheetPayment(context)),
          SizedBox(
            width: 10.0,
          ),
          IconButton(
            onPressed: () async {
              if (_methode == null) {
                _showModalSheetPayment(context);
              } else {
                if (_formKey.currentState.validate()) {
                  _orderNum =
                      _orderNum + await _auth.countOrdersDocuments(user.uid);
                  Order _order = Order(
                    idorder: _orderNum,
                    prixtotal: _volume * _type['prix'],
                    uidentreprise: doc.documentID,
                    uidclient: user.uid,
                    idtype: _type['libelle'],
                    dateheurec: DateTime.now(),
                    color: _carColor.value,
                    matricule: _matricule,
                    adresse: _adresse,
                    volume: _volume,
                  );
                  // inspect(Order(
                  //   idorder: _orderNum,
                  //   prixtotal: _volume * _type['prix'],
                  //   uidentreprise: doc.documentID,
                  //   uidclient: user.uid,
                  //   idtype: _type['libelle'],
                  //   dateheurec: DateTime.now(),
                  //   color: _carColor.toString(),
                  //   matricule: _matricule,
                  //   adresse: _adresse,
                  //   volume: _volume,
                  // ));
                  if (_order.methode == 'COD') {
                    Navigator.of(context).pushReplacement(PageTransition(
                        type: PageTransitionType.leftToRight,
                        child: OrderDone(
                          order: _order,
                        )));
                  } else {
                    Navigator.of(context).pushReplacement(PageTransition(
                        type: PageTransitionType.leftToRight,
                        child: OnlinePayments(
                          order: _order,
                        )));
                  }
                }
              }
            },
            icon: Icon(Icons.navigate_next),
          ),
          SizedBox(
            width: 10.0,
          ),
        ],
        backgroundColor: Colors.black,
        elevation: 1,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Colors.grey[200]))),
                child: TextFormField(
                  onChanged: (value) {
                    _volume = double.tryParse(value) ?? 0.0;
                  },
                  decoration: InputDecoration(
                      labelText: "Volume",
                      labelStyle: hintStyle,
                      border: InputBorder.none),
                  keyboardType: TextInputType.number,
                  validator: (value) => value == null ? 'Required' : null,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Colors.grey[200]))),
                child: DropdownButtonFormField(
                  value: _type,
                  decoration: InputDecoration(border: InputBorder.none),
                  items: _types.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(
                        '${type['libelle']} - ${type['prix']} DH/L',
                        style: hintStyle,
                      ),
                    );
                  }).toList(),
                  onChanged: (val) => _type = val,
                  validator: (value) => value.isEmpty ? 'Required' : null,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Colors.grey[200]))),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Address",
                      labelStyle: hintStyle,
                      border: InputBorder.none),
                  onChanged: (value) => _adresse = value,
                  validator: (value) => value.isEmpty ? 'Required' : null,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Colors.grey[200]))),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Registration number",
                      labelStyle: hintStyle,
                      border: InputBorder.none),
                  onChanged: (value) => _matricule = value,
                  validator: (value) => value.isEmpty ? 'Required' : null,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Colors.grey[200]))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Car Color :',
                      style: hintStyle,
                    ),
                    FlatButton(
                      color: _carColor,
                      child: const Icon(
                        Icons.directions_car,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          child: CustomAlertDialog(
                            title: const Text('Pick a color'),
                            content: SingleChildScrollView(
                              child: ColorPicker(
                                pickerColor: _pickerColor,
                                onColorChanged: changeColor,
                                showLabel: true,
                                pickerAreaHeightPercent: 0.8,
                              ),
                              // Use Material color picker:
                              //
                              // child: MaterialPicker(
                              //   pickerColor: pickerColor,
                              //   onColorChanged: changeColor,
                              //   showLabel: true, // only on portrait mode
                              // ),
                              //
                              // Use Block color picker:
                              //
                              // child: BlockPicker(
                              //   pickerColor: currentColor,
                              //   onColorChanged: changeColor,
                              // ),
                              //
                              // child: MultipleChoiceBlockPicker(
                              //   pickerColors: currentColors,
                              //   onColorsChanged: changeColors,
                              // ),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: const Text('Choose'),
                                onPressed: () {
                                  setState(() => _carColor = _pickerColor);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
