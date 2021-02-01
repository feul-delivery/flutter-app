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
      color: Colors.white,
      shape: CircularNotchedRectangle(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 7.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(
                OMIcons.home,
                size: BottomNavigationBarCl._iconSize,
                color: Colors.orange[900],
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
                OMIcons.explore,
                size: BottomNavigationBarCl._iconSize,
                color: Colors.orange[900],
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
                OMIcons.accountCircle,
                size: BottomNavigationBarCl._iconSize,
                color: Colors.orange[900],
              ),
              onPressed: () {
                setState(() {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: ProfileCl()));
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
