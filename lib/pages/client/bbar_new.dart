import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class BbarNew extends StatefulWidget {
  static int currentIndex = 0;
  BbarNew({Key key}) : super(key: key);

  @override
  _BbarNewState createState() => _BbarNewState();
}

class _BbarNewState extends State<BbarNew> {
  @override
  BottomNavigationBar build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: BbarNew.currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(OMIcons.home),
              // ignore: deprecated_member_use
              title: Text('Home', style: GoogleFonts.openSans())),
          BottomNavigationBarItem(
              icon: Icon(OMIcons.explore),
              // ignore: deprecated_member_use
              title: Text('Explore', style: GoogleFonts.openSans())),
          BottomNavigationBarItem(
              icon: Icon(OMIcons.person),
              // ignore: deprecated_member_use
              title: Text('Profile', style: GoogleFonts.openSans())),
        ]);
  }
}
