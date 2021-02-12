import 'dart:io';
import 'package:feul_delivery/pages/admin/drawer_admin.dart';
import 'package:flutter/material.dart';

class IndexAdmin extends StatefulWidget {
  @override
  _IndexAdminState createState() => _IndexAdminState();
}

class _IndexAdminState extends State<IndexAdmin> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return showDialog(
              context: context,
              builder: (context) => new AlertDialog(
                title: new Text('Etes-vous sur?'),
                content: new Text("Quitter l'application?"),
                actions: <Widget>[
                  new GestureDetector(
                    onTap: () => exit(0),
                    child: Text('OK'),
                  ),
                  SizedBox(height: 16),
                  new GestureDetector(
                    onTap: () => Navigator.of(context).pop(false),
                    child: Container(
                        child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text('Annuler'),
                    )),
                  ),
                ],
              ),
            ) ??
            false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Acceuil"),
          backgroundColor: Colors.red[900],
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  setState(() {});
                })
          ],
        ),
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                children: <Widget>[
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Total Views',
                                    style: TextStyle(color: Colors.blueAccent)),
                                Text('265K',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 34.0))
                              ],
                            ),
                            Material(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(24.0),
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Icon(Icons.timeline,
                                      color: Colors.white, size: 30.0),
                                )))
                          ]),
                    ),
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Material(
                                color: Colors.teal,
                                shape: CircleBorder(),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Icon(Icons.settings_applications,
                                      color: Colors.white, size: 30.0),
                                )),
                            Padding(padding: EdgeInsets.only(bottom: 16.0)),
                            Text('General',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24.0)),
                            Text('Images, Videos',
                                style: TextStyle(color: Colors.black45)),
                          ]),
                    ),
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Material(
                                color: Colors.amber,
                                shape: CircleBorder(),
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Icon(Icons.notifications,
                                      color: Colors.white, size: 30.0),
                                )),
                            Padding(padding: EdgeInsets.only(bottom: 16.0)),
                            Text('Alerts',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24.0)),
                            Text('All ',
                                style: TextStyle(color: Colors.black45)),
                          ]),
                    ),
                  ),
                  InkWell(
                    child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Revenue',
                                        style: TextStyle(color: Colors.green)),
                                    Text('\$16K',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 34.0)),
                                  ],
                                ),
                                // DropdownButton(
                                //     isDense: true,
                                //     value: ,
                                //     onChanged: (String value) => setState(() {
                                //           actualDropdown = value;
                                //           actualChart =
                                //               chartDropdownItems.indexOf(
                                //                   value); // Refresh the chart
                                //         }),
                                //     items: chartDropdownItems.map((String title) {
                                //       return DropdownMenuItem(
                                //         value: title,
                                //         child: Text(title,
                                //             style: TextStyle(
                                //                 color: Colors.blue,
                                //                 fontWeight: FontWeight.w400,
                                //                 fontSize: 14.0)),
                                //       );
                                //     }).toList())
                              ],
                            ),
                            Padding(padding: EdgeInsets.only(bottom: 4.0)),
                            // Sparkline(
                            //   data: charts[actualChart],
                            //   lineWidth: 5.0,
                            //   lineColor: Colors.redAccent,
                            // )
                          ],
                        )),
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Shop Items',
                                    style: TextStyle(color: Colors.redAccent)),
                                Text('173',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 34.0))
                              ],
                            ),
                            Material(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(24.0),
                                child: Center(
                                    child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Icon(Icons.store,
                                      color: Colors.white, size: 30.0),
                                )))
                          ]),
                    ),
                    onTap: () {},
                  )
                ],
                // staggeredTiles: [
                //   StaggeredTile.extent(2, 110.0),
                //   StaggeredTile.extent(1, 180.0),
                //   StaggeredTile.extent(1, 180.0),
                //   StaggeredTile.extent(2, 220.0),
                //   StaggeredTile.extent(2, 110.0),
                // ],
              ),
            )),
        drawer: DrawerAdmin(),
      ),
    );
  }
}
