import 'package:FD_flutter/pages/client/explore_cl.dart';
import 'package:FD_flutter/pages/client/index_cl.dart';
import 'package:FD_flutter/pages/client/profile_cl.dart';
import 'package:FD_flutter/shared/lang.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class HomeCl extends StatefulWidget {
  HomeCl({Key key}) : super(key: key);

  @override
  _HomeClState createState() => _HomeClState();
}

int _currentIndex = 0;

class _HomeClState extends State<HomeCl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 0
          ? IndexCl()
          : _currentIndex == 1
              ? ExploreCl()
              : ProfileCl(),
      bottomNavigationBar: BottomNavigationBar(
          elevation: 2,
          type: BottomNavigationBarType.fixed,
          backgroundColor: scaffoldBackground,
          currentIndex: _currentIndex,
          onTap: (value) {
            switch (value) {
              case 0:
                setState(() {
                  _currentIndex = 0;
                });
                break;
              case 1:
                setState(() {
                  _currentIndex = 1;
                });
                break;
              case 2:
                setState(() {
                  _currentIndex = 2;
                });
                break;
            }
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(OMIcons.home,
                    color:
                        _currentIndex == 0 ? buttonColor : Color(0xFFB9BAC3)),
                // ignore: deprecated_member_use
                title: Text('${Language.mapLang['home']}',
                    style: TextStyle(
                        color: _currentIndex == 0
                            ? buttonColor
                            : Color(0xFFB9BAC3)))),
            BottomNavigationBarItem(
                icon: Icon(OMIcons.explore,
                    color:
                        _currentIndex == 1 ? buttonColor : Color(0xFFB9BAC3)),
                // ignore: deprecated_member_use
                title: Text('${Language.mapLang['explore']}',
                    style: TextStyle(
                        color: _currentIndex == 1
                            ? buttonColor
                            : Color(0xFFB9BAC3)))),
            BottomNavigationBarItem(
                icon: Icon(OMIcons.person,
                    color:
                        _currentIndex == 2 ? buttonColor : Color(0xFFB9BAC3)),
                // ignore: deprecated_member_use
                title: Text('${Language.mapLang['profile']}',
                    style: TextStyle(
                        color: _currentIndex == 2
                            ? buttonColor
                            : Color(0xFFB9BAC3)))),
          ]),
    );
  }
}
