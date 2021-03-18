import 'package:FD_flutter/modules/user.dart';
import 'package:FD_flutter/services/auth.dart';
import 'package:FD_flutter/services/database.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddLivreur extends StatefulWidget {
  const AddLivreur({Key key}) : super(key: key);

  @override
  _AddLivreurState createState() => _AddLivreurState();
}

class _AddLivreurState extends State<AddLivreur> {
  TextEditingController searchController = TextEditingController();
  String searchTerm;
  String message = '';
  @override
  Widget build(BuildContext context) {
    final User _user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text("New Deliveryman"),
      ),
      body: Column(
        children: [
          Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: searchController,
                textInputAction: TextInputAction.search,
                onChanged: (value) {
                  setState(() {
                    searchTerm = value;
                  });
                },
                decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: "Type an email",
                    suffixIcon: IconButton(
                      onPressed: () => searchController.clear(),
                      icon: Icon(Icons.clear),
                      color: Colors.black26,
                    )),
              )),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: (searchTerm == null || searchTerm.trim() == '')
                  ? Firestore.instance.collection('client').snapshots()
                  : Firestore.instance
                      .collection('client')
                      .where('email', isEqualTo: searchTerm)
                      .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Icon(Icons.cancel, color: Colors.red[900]);
                }
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return SizedBox(
                        child: Center(
                            child: CircularProgressIndicator(
                                backgroundColor: Colors.red[900])));
                  case ConnectionState.none:
                    return Icon(Icons.error_outline, color: Colors.red[900]);
                  case ConnectionState.done:
                    return Icon(
                      Icons.done,
                      color: Colors.red[900],
                    );
                  default:
                    return new ListView(
                        children: snapshot.data.documents
                            .map((DocumentSnapshot document) {
                      return new ListTile(
                          title:
                              Text("${document['nom']} ${document['prenom']}"),
                          subtitle: Text(document['tele']),
                          trailing: IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              _showMyDialog(document, _user.uid);
                              if (message != '') {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  duration: Duration(seconds: 1),
                                  content: Text(
                                    message,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.red[900],
                                ));
                              } else {
                                message = '';
                              }
                            },
                          ));
                    }).toList());
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showMyDialog(DocumentSnapshot document, String uid) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text('${document['nom']} ${document['prenom']} will '),
                Text('work for you?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                _addToLv(document, uid);
                Navigator.of(context).pop();
                setState(() {
                  message = 'Done';
                });
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  message = 'Canceled';
                });
              },
            ),
          ],
        );
      },
    );
  }
}

Future<bool> _addToLv(DocumentSnapshot document, String uid) async {
  final DatabaseService _auth = DatabaseService(uid: document.documentID);
  _auth.updateLivreurData(
      document['nom'],
      document['prenom'],
      document['email'],
      document['cin'],
      document['sexe'],
      document['tele'],
      'Waiting',
      uid);
  return true;
}
