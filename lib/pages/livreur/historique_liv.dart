import 'package:FD_flutter/pages/livreur/bbar_liv.dart';
import 'package:FD_flutter/pages/livreur/drawer_liv.dart';
import 'package:FD_flutter/pages/livreur/index_lv.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistoriqueLiv extends StatefulWidget {
  @override
  _HistoriqueLivState createState() => _HistoriqueLivState();
}

class _HistoriqueLivState extends State<HistoriqueLiv> {
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
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('Historique', style: pageTitleO),
            elevation: 0,
            backgroundColor: Colors.white,
          ),
          drawer: DrawerLiv(),
          bottomNavigationBar: ButtomBarLiv(),
        ));
  }
}
