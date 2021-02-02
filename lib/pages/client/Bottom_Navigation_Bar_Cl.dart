import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:feul_delivery/pages/client/List_Sation_Cl.dart';
import 'package:feul_delivery/pages/client/index_cl.dart';
import 'package:feul_delivery/pages/client/profile_cl.dart';

class BottomNavigationBarCl extends StatefulWidget {
  @override
  _BottomNavigationBarClState createState() => _BottomNavigationBarClState();
}

class _BottomNavigationBarClState extends State<BottomNavigationBarCl> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Theme.of(context).scaffoldBackgroundColor,
      shape: CircularNotchedRectangle(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 2.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.orange[900],
                size: 30,
              ),
              onPressed: () {
                setState(() {
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade, child: Cl()));
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.explore,
                color: Colors.orange[900],
                size: 30,
              ),
              onPressed: () {
                setState(() {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: ListSationCl()));
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.person,
                color: Colors.orange[900],
                size: 30,
              ),
              onPressed: () {
                setState(() {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade, child: ProfileCl()));
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
