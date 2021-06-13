import 'package:FD_flutter/shared/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'historique_liv.dart';
import 'index_lv.dart';
import 'profile_liv.dart';

class ButtomBarLiv extends StatefulWidget {
  static int selectedIndex = 0;
  @override
  State createState() => _ButtomBarLivState();
}

class _ButtomBarLivState extends State<ButtomBarLiv> {
  final List<Item> items = [
    Item('Home', Icons.home),
    Item('Historique', Icons.history),
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
    _select(ButtomBarLiv.selectedIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Container(
      height: BAR_HEIGHT,
      width: width,
      decoration: BoxDecoration(
        color: buttonColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
          ),
        ],
      ),
      child: Stack(
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
                    if (ButtomBarLiv.selectedIndex == 0) {
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade, child: IndexLv()));
                    } else if (ButtomBarLiv.selectedIndex == 1) {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: HistoriqueLiv()));
                    } else if (ButtomBarLiv.selectedIndex == 2) {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: ProfileLiv()));
                    }
                  }),
                  child: _buildItemWidget(
                      item, index == ButtomBarLiv.selectedIndex),
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
                color: Colors.black,
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
    ButtomBarLiv.selectedIndex = index;
    indicatorAlignX = double.parse('${index - 1}');
  }

  Widget _buildItemWidget(Item item, bool isSelected) {
    return Container(
      color: buttonColor,
      height: BAR_HEIGHT,
      width: width / items.length,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          AnimatedOpacity(
            opacity: isSelected ? 0.0 : 1.0,
            duration: duration,
            curve: Curves.linear,
            child: Text(item.title,
                style: textStyle.copyWith(color: Colors.white)),
          ),
          AnimatedAlign(
            duration: duration,
            alignment: isSelected ? Alignment.center : Alignment(0, 2.6),
            child: Icon(
              item.icon,
              color: Colors.black,
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
