import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:feul_delivery/pages/client/List_Sation_Cl.dart';
import 'package:feul_delivery/pages/client/index_cl.dart';
import 'package:feul_delivery/pages/client/profile_cl.dart';

class BottomNavigationBarCl extends StatefulWidget {
  static const _iconSize = 30.0;

  @override
  _BottomNavigationBarClState createState() => _BottomNavigationBarClState();
}

class _BottomNavigationBarClState extends State<BottomNavigationBarCl> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
<<<<<<< Updated upstream
<<<<<<< Updated upstream
      color: Colors.white,
=======
      color: Colors.orange[900],
>>>>>>> Stashed changes
=======
      color: Colors.orange[900],
>>>>>>> Stashed changes
      shape: CircularNotchedRectangle(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.white,
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
                color: Colors.white,
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
                color: Colors.white,
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
