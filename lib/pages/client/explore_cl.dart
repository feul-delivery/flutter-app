import 'package:flutter/material.dart';
import 'package:feul_delivery/pages/client/drawer_cl.dart';
import 'package:feul_delivery/pages/client/bbar_cl.dart';

class ListSationCl extends StatefulWidget {
  @override
  _ListSationClState createState() => _ListSationClState();
}

class _ListSationClState extends State<ListSationCl> {
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Explorer');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange[900],
        title: _appBarTitle,
        actions: <Widget>[
          IconButton(
            icon: new Icon(Icons.search),
            onPressed: _searchPressed,
          ),
        ],
      ),
      drawer: DrawerCL(),
      body: createCard(),
      bottomNavigationBar: BottomNavigationBarCl(),
    );
  }

  Container createCard() {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Ink.image(
                        height: 100,
                        image: AssetImage(
                          'assets/emma.jpg',
                        ),
                        fit: BoxFit.fitWidth,
                      )
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        top: 16,
                        right: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Av. Mohammed V,Centre villed. Fès',
                            style: TextStyle(color: Colors.black54),
                          ),
                          IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.phone_rounded,
                              color: Colors.green,
                            ),
                          ),
                          IconButton(
                            onPressed: null,
                            icon: Icon(Icons.chat),
                          ),
                        ],
                      )),
                  ButtonBar(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        alignment: Alignment.topCenter,
                        child: FlatButton(
                            onPressed: () {},
                            child: Column(
                              children: [
                                Icon(
                                  Icons.near_me,
                                  color: Colors.white,
                                ),
                                Text(
                                  'Commander',
                                  style: TextStyle(color: Colors.blue[800]),
                                ),
                              ],
                            )),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        alignment: Alignment.topCenter,
                        child: FlatButton(
                            onPressed: () {},
                            child: Column(
                              children: [
                                Icon(
                                  Icons.read_more,
                                ),
                                Text(
                                  'Details',
                                  style: TextStyle(color: Colors.green[800]),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search), hintText: 'Rechercher...'),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Explorer');
      }
    });
  }
}
