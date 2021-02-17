import 'package:feul_delivery/shared/text_styles.dart';
import 'package:flutter/material.dart';

class StationsPage extends StatefulWidget {
  @override
  _StationsPageState createState() => _StationsPageState();
}

class _StationsPageState extends State<StationsPage> {
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Businesses', style: pageTitle);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          decoration: new InputDecoration(
              hintText: 'Type here',
              hintStyle: TextStyle(color: Colors.white10),
              border: InputBorder.none,
              labelText: 'Search',
              labelStyle: TextStyle(color: Colors.white10)),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Businesses');
      }
    });
  }
}
