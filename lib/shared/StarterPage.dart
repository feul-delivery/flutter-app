import 'package:FD_flutter/authentification/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:FD_flutter/shared/FadeAnimation.dart';
import 'package:google_fonts/google_fonts.dart';
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
          (f) => Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade, child: Authenticate())),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/pgstation.png'),
                  fit: BoxFit.cover)),
          child: Container(
            decoration: BoxDecoration(
                gradient:
                    LinearGradient(begin: Alignment.bottomCenter, colors: [
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
                            fontFamily: GoogleFonts.openSans().fontFamily,
                            fontSize: 50,
                            fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  FadeAnimation(
                      1,
                      Text(
                        "Get the fuel delivered to your door.",
                        style: TextStyle(
                            color: Colors.white, height: 1.4, fontSize: 18),
                      )),
                  SizedBox(
                    height: 100,
                  ),
                  FadeAnimation(
                    1.4,
                    ScaleTransition(
                        scale: _animation,
                        child: Center(
                          child: Container(
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.red[600],
                              ),
                              child: AnimatedOpacity(
                                opacity: _textVisible ? 1.0 : 0.0,
                                duration: Duration(milliseconds: 50),
                                child: MaterialButton(
                                  onPressed: () => _onTap(),
                                  minWidth: double.infinity,
                                  child: Text(
                                    "Start",
                                    style: TextStyle(color: Colors.white),
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
                            "Working 24/7",
                            style:
                                TextStyle(color: Colors.white70, fontSize: 15),
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
      ),
    );
  }
}
