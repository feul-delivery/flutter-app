import 'package:FD_flutter/pages/livreur/bbar_liv.dart';
import 'package:FD_flutter/pages/livreur/index_lv.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistoriqueLiv extends StatefulWidget {
  @override
  _HistoriqueLivState createState() => _HistoriqueLivState();
}

class _HistoriqueLivState extends State<HistoriqueLiv> {
  // ignore: unused_field
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Historique', style: pageTitle);
  get _searchPressed => null;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(

        // ignore: missing_return
        onWillPop: () {
          ButtomBarLiv.selectedIndex = 0;
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (BuildContext context) => IndexLv()));
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.red[900],
            title: _appBarTitle,
            actions: <Widget>[
              IconButton(
                icon: new Icon(Icons.search),
                onPressed: _searchPressed,
              ),
            ],
          ),
        ));
  }
}
