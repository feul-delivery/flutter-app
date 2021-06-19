import 'package:FD_flutter/shared/lang.dart';
import 'package:flutter/material.dart';

class CommandeCompleted extends StatefulWidget {
  @override
  _CommandeCompletedState createState() => _CommandeCompletedState();
}

class _CommandeCompletedState extends State<CommandeCompleted> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
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
            Text(
              "merci d'être patient, dans l'attente de la prochaine commande",
              style: TextStyle(fontSize: 18, color: Colors.white),
              textAlign: TextAlign.justify,
            )
          ],
        ),
      ),
    );
  }
}
