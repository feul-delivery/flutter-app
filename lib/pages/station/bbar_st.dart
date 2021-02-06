import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:feul_delivery/pages/station/index_st.dart';
import 'package:feul_delivery/pages/station/commandes_st.dart';
import 'package:feul_delivery/pages/station/livreurs_st.dart';

class ButtomBarSt extends StatefulWidget {
  @override
  _ButtomBarStState createState() => _ButtomBarStState();
}

class _ButtomBarStState extends State<ButtomBarSt> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Theme.of(context).scaffoldBackgroundColor,
      shape: CircularNotchedRectangle(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 2.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.new_releases_outlined,
                color: Colors.red[900],
                size: 30,
              ),
              onPressed: () {
                setState(() {
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade, child: IndexSt()));
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.history,
                color: Colors.red[900],
                size: 30,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: ToutCommandesSt()));
              },
            ),
            IconButton(
              icon: Icon(
                Icons.supervisor_account_outlined,
                color: Colors.red[900],
                size: 30,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade, child: Livreur()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
