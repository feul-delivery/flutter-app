import 'package:FD_flutter/pages/client/explore_cl.dart';
import 'package:FD_flutter/pages/client/index_cl.dart';
import 'package:FD_flutter/pages/client/profile_cl.dart';
import 'package:FD_flutter/shared/lang.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'ClientProvider.dart';
import 'package:provider/provider.dart';

class HomeCl extends StatefulWidget {
  int index;
  HomeCl({@required this.index});

  @override
  _HomeClState createState() => _HomeClState();
}

int _currentIndex = 0;
final _pages = [new IndexCl(), new ExploreCl(), new ProfileCl()];

class _HomeClState extends State<HomeCl> {
  @override
  void initState() {
    super.initState();
    if (widget.index == null)
      _currentIndex = 0;
    else
      _currentIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ClientProvider>(
      create: (_) => ClientProvider(),
      child: Scaffold(
        body: _pages[_currentIndex],
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
                  title: Text('${Language.mapLang['home']}',
                      style: TextStyle(
                          color: _currentIndex == 0
                              ? buttonColor
                              : Color(0xFFB9BAC3)))),
              BottomNavigationBarItem(
                  icon: Icon(Icons.explore_outlined, color: Color(0xFFB9BAC3)),
                  activeIcon: Icon(Icons.explore, color: buttonColor),
                  title: Text('${Language.mapLang['explore']}',
                      style: TextStyle(
                          color: _currentIndex == 1
                              ? buttonColor
                              : Color(0xFFB9BAC3)))),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline, color: Color(0xFFB9BAC3)),
                  activeIcon: Icon(Icons.person, color: buttonColor),
                  title: Text('${Language.mapLang['profile']}',
                      style: TextStyle(
                          color: _currentIndex == 2
                              ? buttonColor
                              : Color(0xFFB9BAC3)))),
            ]),
      ),
    );
  }
}
