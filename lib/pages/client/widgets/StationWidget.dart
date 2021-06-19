import 'package:provider/provider.dart';
import 'package:FD_flutter/modules/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:FD_flutter/shared/lang.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:FD_flutter/services/auth.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:FD_flutter/wrapper.dart';

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
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              2 /
                                              3,
                                      width: MediaQuery.of(context).size.width *
                                          2 /
                                          3,
                                      child: QrImage(
                                        foregroundColor: Colors.black,
                                        data: '${widget.id}' +
                                            '${Provider.of<User>(context).uid}',
                                        //   embeddedImage: AssetImage('assets/profile.png'),
                                        //   embeddedImageStyle:
                                        //       QrEmbeddedImageStyle(size: Size(50, 50)),
                                      ),
                                    ),
                                  );
                                });
                            Firestore.instance
                                .collection('user')
                                .document(Provider.of<User>(context).email)
                                .snapshots()
                                .listen((event) {
                              String accType = event.data['type'];
                              if (accType == 'livreur') {
                                Navigator.pop(context);
                                AuthService.type = "livreur";
                                showInSnackBar(
                                    "${Language.mapLang['redirectClToLv']}");
                                Future.delayed(Duration(seconds: 2))
                                    .then((value) {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => Wrapper()));
                                });
                              }
                            });
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

// ignore: missing_return
Future<bool> _deleteRequest(String documentID, String uid) {
  Firestore.instance.collection('client').document(documentID).setData({
    'requests': FieldValue.arrayRemove([uid])
  }, merge: true).then((value) {
    return true;
  }).catchError((onError) {
    return false;
  });
}
