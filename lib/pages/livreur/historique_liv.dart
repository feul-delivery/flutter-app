import 'package:FD_flutter/modules/user.dart';
import 'package:FD_flutter/pages/livreur/bbar_liv.dart';
import 'package:FD_flutter/pages/livreur/drawer_liv.dart';
import 'package:FD_flutter/pages/livreur/index_lv.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class HistoriqueLiv extends StatefulWidget {
  @override
  _HistoriqueLivState createState() => _HistoriqueLivState();
}

class _HistoriqueLivState extends State<HistoriqueLiv> {
  @override
  void initState() {
    super.initState();
    timeago.setLocaleMessages('fr', timeago.FrMessages());
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.menu, color: buttonColor),
              onPressed: () => _scaffoldKey.currentState.openDrawer(),
            ),
            title: Text('Historique', style: pageTitleO),
            elevation: 0,
            backgroundColor: Colors.white,
          ),
          body: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('orders')
                  .where('uidstation', isEqualTo: IndexLv.livreur.uidentreprise)
                  .where('statut', isEqualTo: 'done')
                  .where('uidlivreur',
                      isEqualTo: Provider.of<User>(context).uid)
                  .orderBy('dateheurec', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Icon(Icons.cancel, color: Colors.black);
                }
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return SizedBox(
                        child: Center(child: customeCircularProgress));
                  case ConnectionState.none:
                    return Icon(Icons.error_outline, color: Colors.black);

                  default:
                    return snapshot.data.documents.length == 0
                        ? Center(
                            child: Text('Aucun commande'),
                          )
                        : ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                leading: Text(snapshot
                                        .data.documents[index]['volume']
                                        .toString() +
                                    "L"),
                                title: Text(snapshot
                                    .data.documents[index]['idtype']
                                    .toString()),
                                subtitle: Text(snapshot
                                    .data.documents[index]['adresse']
                                    .toString()),
                                trailing: Text(timeago.format(
                                    snapshot.data.documents[index]['dateheurel']
                                        as DateTime,
                                    locale: 'fr')),
                              );
                            },
                          );
                }
              }),
          drawer: DrawerLiv(),
          bottomNavigationBar: ButtomBarLiv(),
        ));
  }
}
