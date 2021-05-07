import 'package:FD_flutter/pages/client/explore_cl.dart';
import 'package:FD_flutter/pages/client/index_cl.dart';
import 'package:FD_flutter/pages/client/profile_cl.dart';
import 'package:FD_flutter/shared/lang.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:flutter/material.dart';

class HomeCl extends StatefulWidget {
  HomeCl({Key key}) : super(key: key);

  @override
  _HomeClState createState() => _HomeClState();
}

int _currentIndex = 0;
final _pages = [IndexCl(), ExploreCl(), ProfileCl()];

class _HomeClState extends State<HomeCl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: _pages
              .asMap()
              .map(
                (i, page) => MapEntry(
                  i,
                  Offstage(
                    offstage: _currentIndex != i,
                    child: page,
                  ),
                ),
              )
              .values
              .toList()),
      bottomNavigationBar: BottomNavigationBar(
          elevation: 2,
          type: BottomNavigationBarType.fixed,
          backgroundColor: scaffoldBackground,
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined, color: Color(0xFFB9BAC3)),
                activeIcon: Icon(Icons.home, color: buttonColor),
                // ignore: deprecated_member_use
                title: Text('${Language.mapLang['home']}',
                    style: TextStyle(
                        color: _currentIndex == 0
                            ? buttonColor
                            : Color(0xFFB9BAC3)))),
            BottomNavigationBarItem(
                icon: Icon(Icons.explore_outlined, color: Color(0xFFB9BAC3)),
                activeIcon: Icon(Icons.explore, color: buttonColor),
                // ignore: deprecated_member_use
                title: Text('${Language.mapLang['explore']}',
                    style: TextStyle(
                        color: _currentIndex == 1
                            ? buttonColor
                            : Color(0xFFB9BAC3)))),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline, color: Color(0xFFB9BAC3)),
                activeIcon: Icon(Icons.person, color: buttonColor),
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
