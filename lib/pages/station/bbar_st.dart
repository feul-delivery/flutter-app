import 'package:FD_flutter/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:FD_flutter/pages/station/index_st.dart';
import 'package:FD_flutter/pages/station/commandes_st.dart';
import 'package:FD_flutter/pages/station/livreurs_st.dart';

class ButtomBarSt extends StatefulWidget {
  static int selectedIndexSt = 0;
  @override
  _ButtomBarStState createState() => _ButtomBarStState();
}

class _ButtomBarStState extends State<ButtomBarSt> {
  final List<Item> items = [
    Item('Accueil', Icons.new_releases_outlined),
    Item('Commandes', Icons.history_outlined),
    Item('Livreurs', Icons.group_outlined),
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
  static const double BAR_HEIGHT = 55;
  static const double INDICATOR_HEIGHT = 2;
  double width = 0;
  double indicatorAlignX = 0;

  Duration duration = Duration(milliseconds: 270);

  @override
  void initState() {
    _select(ButtomBarSt.selectedIndexSt);
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
                    if (ButtomBarSt.selectedIndexSt == 0) {
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade, child: IndexSt()));
                    } else if (ButtomBarSt.selectedIndexSt == 1) {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: ToutCommandesSt()));
                    } else if (ButtomBarSt.selectedIndexSt == 2) {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: LivreurSt()));
                    }
                  }),
                  child: _buildItemWidget(
                      item, index == ButtomBarSt.selectedIndexSt),
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
    ButtomBarSt.selectedIndexSt = index;
    indicatorAlignX = double.parse('${index - 1}');
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
              child: Text(
                item.title,
                style: textStyle,
              )),
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
