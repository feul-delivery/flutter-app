import 'package:FD_flutter/services/database.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Type extends StatefulWidget {
  final String id;
  Type({@required this.id});
  @override
  _TypeState createState() => _TypeState();
}

final _formKey = GlobalKey<FormState>();
String typeName;
String typePrix;

class _TypeState extends State<Type> {
  @override
  Widget build(BuildContext context) {
    var uid = widget.id;
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[900],
          title: Text("Types desponible"),
          actions: <Widget>[
            FlatButton(
              child: new Text(
                "Done",
                style: buttonStyle,
              ),
              textColor: Colors.white,
              color: Colors.red[900],
              onPressed: () {},
            ),
          ],
        ),
        body: _createlistTile(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _addType(uid);
          },
          label: Text('add type'),
          icon: Icon(Icons.add),
          backgroundColor: Colors.red[900],
        ),
      ),
    );
  }

  void _addType(String uid) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 2 / 5,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
                  child: Form(
                      key: _formKey,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Material(
                                child: Center(
                                    child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: "nom de type",
                                ),
                                validator: (val) => val.isEmpty
                                    ? 'This field is required'
                                    : null,
                                onChanged: (val) {
                                  setState(() => typeName = val);
                                },
                              ),
                            ))),
                            Material(
                                child: Center(
                                    child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: "Prix de type",
                                ),
                                validator: (val) => val.isEmpty
                                    ? 'This field is required'
                                    : null,
                                onChanged: (val) {
                                  setState(() => typePrix = val);
                                },
                              ),
                            ))),
                          ],
                        ),
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "annuler",
                          style: TextStyle(color: Colors.red[900]),
                        )),
                    FlatButton(
                        onPressed: () async {
                          final DatabaseService _auth =
                              DatabaseService(uid: uid);
                          if (_formKey.currentState.validate()) {
                            // add type
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          "Submit",
                          style: TextStyle(color: Colors.red[900]),
                        )),
                  ],
                ),
              ],
            ),
          );
        });
  }
}

Container _createlistTile({DocumentSnapshot document}) {
  return Container(
      margin: EdgeInsets.all(10),
      child: ListTile(
        title: Text(
          'klakak',
        ),
        subtitle: Text('Prix : 1.35467'),
        trailing: Wrap(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {},
            ),
          ],
        ),
      ));
}
