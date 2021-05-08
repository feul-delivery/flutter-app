import 'package:FD_flutter/authentification/authenticate.dart';
import 'package:FD_flutter/shared/lang.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:FD_flutter/shared/FadeAnimation.dart';

import 'package:page_transition/page_transition.dart';

class StarterPage extends StatefulWidget {
  @override
  _StarterPageState createState() => _StarterPageState();
}

class _StarterPageState extends State<StarterPage>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  bool _textVisible = true;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));

    _animation =
        Tween<double>(begin: 1.0, end: 25.0).animate(_animationController);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  void _onTap() {
    setState(() {
      _textVisible = false;
    });

    _animationController.forward().then(
          (f) => Navigator.pushReplacement(
              context,
              PageTransition(
                  type: PageTransitionType.fade, child: Authenticate())),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/gas_station.jpg'),
                fit: BoxFit.fitHeight)),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.bottomCenter, colors: [
            Colors.black.withOpacity(.9),
            Colors.black.withOpacity(.8),
            Colors.black.withOpacity(.2),
          ])),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FadeAnimation(
                    .8,
                    Text(
                      'Fuel Delivery',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Quarion',
                          fontSize: 50,
                          fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: 15,
                ),
                FadeAnimation(
                    1,
                    Text(
                      "${Language.mapLang['fueltodoor']}",
                      style: TextStyle(
                          fontFamily: 'Quarion',
                          color: Colors.white,
                          height: 1.4,
                          fontSize: 18),
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.60,
                ),
                FadeAnimation(
                  1.4,
                  ScaleTransition(
                      scale: _animation,
                      child: Center(
                        child: Container(
                            width: 150,
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white,
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(50),
                                onTap: () => _onTap(),
                                child: AnimatedOpacity(
                                  opacity: _textVisible ? 1.0 : 0.0,
                                  duration: Duration(milliseconds: 50),
                                  child: Center(
                                    child: Text(
                                      "${Language.mapLang['start']}"
                                          .toUpperCase(),
                                      style: buttonStyleBlack,
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      )),
                ),
                SizedBox(
                  height: 30,
                ),
                FadeAnimation(
                    1.5,
                    AnimatedOpacity(
                      opacity: _textVisible ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 50),
                      child: Align(
                        child: Text(
                          "${Language.mapLang['work24/7']}",
                          style: TextStyle(
                              fontFamily: 'Quarion',
                              color: Colors.white70,
                              fontSize: 15),
                        ),
                      ),
                    )),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
