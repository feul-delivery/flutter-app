import 'package:feul_delivery/pages/client/profile_cl.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'explore_cl.dart';
import 'index_cl.dart';

int selectedIndex = 0;

class ButtomBarCl extends StatefulWidget {
  @override
  State createState() => _ButtomBarClState();
}

class _ButtomBarClState extends State<ButtomBarCl> {
  final List<Item> items = [
    Item('Acceuil', Icons.home),
    Item('Explorer', Icons.explore),
    Item('Profile', Icons.account_circle),
  ];

  @override
  Widget build(BuildContext context) {
    return TitledBottomNavigationBar(
      items: items,
    );
  }
}

class TitledBottomNavigationBar extends StatefulWidget {
  final List<Item> items;

  const TitledBottomNavigationBar({Key key, this.items}) : super(key: key);

  @override
  _TitledBottomNavigationBarState createState() =>
      _TitledBottomNavigationBarState();
}

class _TitledBottomNavigationBarState extends State<TitledBottomNavigationBar>
    with SingleTickerProviderStateMixin {
  List<Item> get items => widget.items;
  static const double BAR_HEIGHT = 50;
  static const double INDICATOR_HEIGHT = 2;
  double width = 0;
  double indicatorAlignX = 0;

  Duration duration = Duration(milliseconds: 270);

  @override
  void initState() {
    _select(selectedIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Container(
      height: BAR_HEIGHT,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
          ),
        ],
      ),
      child: Stack(
//        overflow: Overflow.visible,// Debug use
        children: <Widget>[
          Positioned(
            top: INDICATOR_HEIGHT,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: items.map((item) {
                var index = items.indexOf(item);
                return GestureDetector(
                  onTap: () => setState(() {
                    _select(index);
                    if (selectedIndex == 0) {
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade, child: IndexCl()));
                    } else if (selectedIndex == 1) {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: ExploreCl()));
                    } else if (selectedIndex == 2) {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: profileCl()));
                    }
                  }),
                  child: _buildItemWidget(item, index == selectedIndex),
                );
              }).toList(),
            ),
          ),
          Positioned(
            top: 0,
            width: width,
            child: AnimatedAlign(
              alignment: Alignment(indicatorAlignX, 0),
              curve: Curves.linear,
              duration: duration,
              child: Container(
                color: Colors.red[900],
                width: width / items.length,
                height: INDICATOR_HEIGHT,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _select(int index) {
    selectedIndex = index;
    indicatorAlignX = -1 + -(2 / (items.length - 1) * index);
  }

  Widget _buildItemWidget(Item item, bool isSelected) {
    return Container(
      color: Colors.white,
      height: BAR_HEIGHT,
      width: width / items.length,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          AnimatedOpacity(
            opacity: isSelected ? 0.0 : 1.0,
            duration: duration,
            curve: Curves.linear,
            child: Text(item.title),
          ),
          AnimatedAlign(
            duration: duration,
            alignment: isSelected ? Alignment.center : Alignment(0, 2.6),
            child: Icon(
              item.icon,
              color: Colors.red[900],
            ),
          ),
        ],
      ),
    );
  }
}

class Item {
  final String title;
  final IconData icon;

  Item(this.title, this.icon);
}
