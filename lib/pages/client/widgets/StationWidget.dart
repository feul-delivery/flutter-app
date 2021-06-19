import 'package:provider/provider.dart';
import 'package:FD_flutter/modules/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:FD_flutter/shared/lang.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:FD_flutter/services/auth.dart';

// ignore: must_be_immutable
class StationWidget extends StatefulWidget {
  String id;
  GlobalKey<ScaffoldState> scaffoldKey;
  StationWidget({@required this.id, @required this.scaffoldKey});

  @override
  _StationWidgetState createState() => _StationWidgetState();
}

class _StationWidgetState extends State<StationWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection('entreprise')
              .document(widget.id)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return SizedBox.shrink();
            }
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return SizedBox.shrink();

              case ConnectionState.waiting:
                return SizedBox.shrink();
              default:
                return ListTile(
                  title: Text(
                    snapshot.data['titre'].toString(),
                    style: tileTitleStyleW,
                  ),
                  trailing: Wrap(
                    children: [
                      Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(50),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                              padding: EdgeInsets.all(5),
                              child: Icon(
                                Icons.check_circle,
                                color: Colors.greenAccent,
                              )),
                          onTap: () {
                            // Firestore.instance
                            //     .collection('client')
                            //     .document(Provider.of<User>(context).uid)
                            //     .get()
                            //     .then((value) {
                            //   AuthService auth = AuthService();
                            //   auth.changeClientToLivreur(value, widget.id);
                            //   AuthService.type = "livreur";

                            // });
                            Navigator.pop(context);
                            showInSnackBar(
                                "${Language.mapLang['redirectClToLv']}");
                            Future.delayed(Duration(seconds: 5))
                                .then((value) {});
                          },
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(50),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                              padding: EdgeInsets.all(5),
                              child: Icon(
                                Icons.remove_circle,
                                color: Colors.redAccent,
                              )),
                          onTap: () => _deleteRequest(
                              Provider.of<User>(context).uid, widget.id),
                        ),
                      ),
                    ],
                  ),
                );
            }
          }),
    );
  }

  void showInSnackBar(String value) {
    SnackBar snackBar = new SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Colors.white,
        content: new Text(value, style: textStyle));
    widget.scaffoldKey.currentState.showSnackBar(snackBar);
  }
}

Future<bool> _deleteRequest(String documentID, String uid) {
  Firestore.instance.collection('client').document(documentID).setData({
    'requests': FieldValue.arrayRemove([uid])
  }, merge: true).then((value) {
    return true;
  }).catchError((onError) {
    return false;
  });
}
