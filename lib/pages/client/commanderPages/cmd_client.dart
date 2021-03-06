import 'dart:async';
import 'dart:developer';
import 'package:FD_flutter/modules/order.dart';
import 'package:FD_flutter/modules/user.dart';
import 'package:FD_flutter/pages/client/commanderPages/cmd_done.dart';
import 'package:FD_flutter/pages/client/commanderPages/online_payements.dart';
import 'package:FD_flutter/services/database.dart';
import 'package:FD_flutter/shared/custom_alert_dialog.dart';
import 'package:FD_flutter/shared/lang.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

enum pmethode { livraison, google }

class ClientOrder extends StatefulWidget {
  final DocumentSnapshot doc;
  ClientOrder({@required this.doc}) {
    WidgetsFlutterBinding.ensureInitialized();
  }
  @override
  _ClientOrderState createState() => _ClientOrderState();
}

StreamSubscription _locationSubscription;
Location _locationTracker = Location();

Future<String> getAddressFromCoordinates(Coordinates coordinates) async {
  var addresses =
      await Geocoder.local.findAddressesFromCoordinates(coordinates);
  var first = addresses.first;
  print("${first.featureName} : ${first.addressLine}");
  return first.addressLine;
}

String _adr = "";
Map<String, double> _coordinates = {};

Future<Coordinates> getCurrentLocation() async {
  var _location;
  try {
    _location = await _locationTracker.getLocation();

    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }

    _locationSubscription =
        _locationTracker.onLocationChanged().listen((newLocalData) {
      _location = newLocalData;
    });
    _coordinates = {
      'latitude': _location.latitude,
      'longitude': _location.longitude
    };
    return Coordinates(_location.latitude, _location.longitude);
  } on PlatformException catch (e) {
    if (e.code == 'PERMISSION_DENIED') {
      return null;
    }
    return null;
  }
}

double _volume;
Map<dynamic, dynamic> _type;
String _adresse;
String _matricule;
String _methode;
Color _pickerColor = Color(0xffff6b81);
Color _carColor = Color(0xffff6b81);
pmethode _methd = pmethode.livraison;

class _ClientOrderState extends State<ClientOrder> {
  Future<void> _showModalSheetPayment(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context, setState) {
            return SingleChildScrollView(
              child: Container(
                  color: scaffoldBackground,
                  child: Column(
                    children: [
                      Container(
                        color: buttonColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.all(20),
                              child: Text(
                                '${Language.mapLang['modepay']}',
                                style: pageTitleX,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (_methd == pmethode.google) {
                                  _methode = 'BANK';
                                } else {
                                  _methode = 'COD';
                                }
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: scaffoldBackground,
                                    borderRadius: BorderRadius.circular(50)),
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                child: Center(
                                  child: Text(
                                    '${Language.mapLang['finish']}',
                                    style: buttonStyle,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text('${Language.mapLang['cod']}'),
                              leading: Radio(
                                  activeColor: Colors.black,
                                  value: pmethode.livraison,
                                  groupValue: _methd,
                                  onChanged: (pmethode valeur) {
                                    setState(() {
                                      _methd = valeur;
                                    });
                                  }),
                            ),
                            ListTile(
                              title: Text('${Language.mapLang['card']}'),
                              leading: Radio(
                                  activeColor: Colors.black,
                                  value: pmethode.google,
                                  groupValue: _methd,
                                  onChanged: (pmethode valeur) {
                                    setState(() {
                                      _methd = valeur;
                                    });
                                  }),
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
            );
          });
        });
  }

  void changeColor(Color color) {
    _pickerColor = color;
  }

  List<Map<dynamic, dynamic>> _types;

  @override
  Widget build(
    BuildContext context,
  ) {
    @override
    void initState() {
      super.initState();
      _types = new List();
      _type = null;
    }

    deactivate() {
      super.deactivate();
      _types = new List();
      _type = null;
    }

    final _formKey = GlobalKey<FormState>();
    var doc = widget.doc;
    _types = List<Map<dynamic, dynamic>>.from(doc['type']).toList();
    final user = Provider.of<User>(context);
    int _orderNum = 1;
    DatabaseService _auth = DatabaseService();
    _adr == "" ? _adr = "" : _adresse = _adr;
    return Scaffold(
      backgroundColor: darkGray,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.west_rounded, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "${Language.mapLang['placeorder']}",
          style: pageTitleW,
        ),
        actions: [
          IconButton(
              icon: Icon(OMIcons.payment, color: Colors.white),
              onPressed: () => _showModalSheetPayment(context)),
          SizedBox(
            width: 10.0,
          ),
          IconButton(
            icon:
                Icon(CupertinoIcons.text_badge_checkmark, color: Colors.white),
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
                      methode: _methode,
                      matricule: _matricule,
                      adresse: _adresse,
                      volume: _volume,
                      coordinates: _coordinates);
                  inspect(_order);
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
          ),
        ],
        backgroundColor: buttonColor,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Container(
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
                    cursorColor: grayColor,
                    cursorHeight: 25,
                    cursorWidth: 1,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    onChanged: (value) {
                      _volume = double.tryParse(value) ?? 0.0;
                    },
                    decoration: InputDecoration(
                        hintText: "Volume",
                        hintStyle: hintStyle,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        border: InputBorder.none),
                    keyboardType: TextInputType.number,
                    validator: (value) => value == null
                        ? '${Language.mapLang['required']}'
                        : null,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.grey[200]))),
                  child: DropdownButtonFormField(
                    hint: Text(
                      '${Language.mapLang['ftype']}',
                      style: hintStyle,
                    ),
                    value: null,
                    dropdownColor: scaffoldBackground,
                    decoration: InputDecoration(border: InputBorder.none),
                    items: _types.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text('${type['libelle']} - ${type['prix']} DH/L',
                            style: hintStyle),
                      );
                    }).toList(),
                    onChanged: (val) => _type = val,
                    validator: (value) => value.isEmpty
                        ? '${Language.mapLang['required']}'
                        : null,
                  ),
                ),
                _adr != ""
                    ? Container()
                    : Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.grey[200]))),
                        child: TextFormField(
                          cursorColor: grayColor,
                          cursorHeight: 25,
                          cursorWidth: 1,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              hintText: "${Language.mapLang['address']}",
                              hintStyle: hintStyle,
                              border: InputBorder.none),
                          onChanged: (value) => _adresse = value,
                          validator: (value) => value.isEmpty
                              ? '${Language.mapLang['required']}'
                              : null,
                        ),
                      ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.grey[200]))),
                  child: TextFormField(
                    cursorColor: grayColor,
                    cursorHeight: 25,
                    cursorWidth: 1,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    decoration: InputDecoration(
                        hintText: "${Language.mapLang['matricule']}",
                        hintStyle: hintStyle,
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15)),
                    onChanged: (value) => _matricule = value,
                    validator: (value) => value.isEmpty
                        ? '${Language.mapLang['required']}'
                        : null,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.grey[200]))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Text(
                          '${Language.mapLang['carcolor']}',
                          style: hintStyle,
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50)),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(50),
                            onTap: () {
                              showDialog(
                                context: context,
                                child: CustomAlertDialog(
                                  title: Text(
                                    '${Language.mapLang['pickcolor']}',
                                    style: tileTitleStyle,
                                  ),
                                  content: SingleChildScrollView(
                                    child: ColorPicker(
                                      pickerColor: _pickerColor,
                                      onColorChanged: changeColor,
                                      showLabel: true,
                                      pickerAreaHeightPercent: 0.8,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      child:
                                          Text('${Language.mapLang['choose']}'),
                                      onPressed: () {
                                        _carColor = _pickerColor;
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Center(
                              child: const Icon(Icons.directions_car,
                                  color: buttonColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _adr == ""
              ? Container()
              : Container(
                  padding: EdgeInsets.all(10),
                  height: 55,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[400].withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 1),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    // border: Border(bottom: BorderSide(color: Colors.grey[200])),
                  ),
                  child: Center(child: Text(_adr, style: textStyle))),
          SizedBox(width: 5),
          _adr != ""
              ? FloatingActionButton(
                  elevation: 1,
                  backgroundColor: Colors.white,
                  child: Icon(OMIcons.cancel, color: buttonColor),
                  onPressed: () async {
                    setState(() {
                      _adr = "";
                    });
                  })
              : FloatingActionButton(
                  elevation: 1,
                  backgroundColor: buttonColor,
                  child: Icon(
                    OMIcons.myLocation,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    Coordinates _crd = await getCurrentLocation();
                    if (_crd == null) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text(
                          "${Language.mapLang["LOCATION_PERMISSION_DENIED"]}",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.black,
                      ));
                    } else {
                      _adr = await getAddressFromCoordinates(_crd);
                      setState(() {});
                    }
                  }),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
