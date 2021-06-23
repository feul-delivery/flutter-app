import 'package:FD_flutter/shared/lang.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:FD_flutter/wrapper.dart';
import 'package:flutter/material.dart';

class CommandeCompleted extends StatefulWidget {
  @override
  _CommandeCompletedState createState() => _CommandeCompletedState();
}

class _CommandeCompletedState extends State<CommandeCompleted> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 5)).then((value) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Wrapper()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: scaffoldBackground,
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.width * 1 / 3,
                  width: MediaQuery.of(context).size.width * 1 / 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.green[300],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: Text(
                    "${Language.mapLang['orderdone']}",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Gotham',
                      fontSize: 35,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "merci d'être patient, dans l'attente de la prochaine commande",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'Quarion'),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 10 + MediaQuery.of(context).padding.top,
            right: 10,
            child: GestureDetector(
                onTap: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Wrapper())),
                child: Text(
                  'passer',
                  style: TextStyle(
                      fontSize: 15, color: Colors.white, fontFamily: 'Quarion'),
                )),
          )
        ],
      ),
    );
  }
}
