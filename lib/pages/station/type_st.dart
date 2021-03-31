import 'package:FD_flutter/modules/user.dart';
import 'package:FD_flutter/wrapper.dart';
import 'package:page_transition/page_transition.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TypeSt extends StatefulWidget {
  @override
  _TypeStState createState() => _TypeStState();
}

final _formKey = GlobalKey<FormState>();

class _TypeStState extends State<TypeSt> {
  @override
  Widget build(BuildContext context) {
    User _user = Provider.of<User>(context);
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text("Types"),
            centerTitle: true,
            actions: <Widget>[
              FlatButton(
                child: new Text(
                  "Save",
                  style: buttonStyle,
                ),
                textColor: Colors.white,
                color: Colors.black,
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade, child: Wrapper()));
                },
              ),
            ],
          ),
          body: StreamBuilder<DocumentSnapshot>(
            stream: Firestore.instance
                .collection('entreprise')
                .document(_user.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Icon(Icons.cancel, color: Colors.black);
              }
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return SizedBox(
                      child: Center(
                          child: CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.white),
                              backgroundColor: Colors.black)));
                case ConnectionState.none:
                  return Icon(Icons.error_outline, color: Colors.black);
                case ConnectionState.done:
                  return Icon(
                    Icons.done,
                    color: Colors.black,
                  );
                default:
                  List<Map<dynamic, dynamic>> _types =
                      List<Map<dynamic, dynamic>>.from(snapshot.data['type'])
                          .toList();
                  return new ListView(
                      children: _types.map((type) {
                    return new ListTile(
                        title: Text("${type['libelle']}"),
                        subtitle: Text('${type['prix']} Dh/L'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              duration: Duration(seconds: 1),
                              content: Text(
                                'Are you sure',
                                style: textStyleWhite,
                              ),
                              backgroundColor: Colors.black,
                              action: SnackBarAction(
                                textColor: Colors.white,
                                label: 'Confirm',
                                onPressed: () async {
                                  try {
                                    await Firestore.instance
                                        .collection('entreprise')
                                        .document(_user.uid)
                                        .updateData(
                                      {
                                        'type': FieldValue.arrayRemove([type])
                                      },
                                    );
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                              ),
                            ));
                          },
                        ));
                  }).toList());
              }
            },
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              _addType(_user.uid);
            },
            label: Text('add type'),
            icon: Icon(Icons.add),
            backgroundColor: Colors.black,
          ),
        ),
        onWillPop: () => Navigator.of(context).pushReplacement(
            PageTransition(child: Wrapper(), type: PageTransitionType.fade)));
  }

  void _addType(String uid) {
    String _typeName;
    double _typePrix;
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(15, 5, 20, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancel",
                            style: buttonStyleBlack,
                          )),
                      FlatButton(
                          color: Colors.black,
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              // add type
                              try {
                                Map<dynamic, dynamic> _newType = {
                                  'libelle': _typeName,
                                  'prix': _typePrix
                                };
                                await Firestore.instance
                                    .collection('entreprise')
                                    .document(uid)
                                    .setData({
                                  'type': FieldValue.arrayUnion([_newType])
                                }, merge: true);
                              } catch (e) {
                                print(e);
                              }
                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            'Add',
                            style: buttonStyle,
                          )),
                    ],
                  ),
                ),
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
                                  labelText: "Label",
                                ),
                                validator: (val) => val.isEmpty
                                    ? 'This field is required'
                                    : null,
                                onChanged: (val) {
                                  setState(() => _typeName = val);
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
                                  labelText: "Price",
                                ),
                                keyboardType: TextInputType.number,
                                validator: (val) => val == null
                                    ? 'This field is required'
                                    : null,
                                onChanged: (val) {
                                  setState(() =>
                                      _typePrix = double.tryParse(val) ?? 0.0);
                                },
                              ),
                            ))),
                          ],
                        ),
                      )),
                ),
              ],
            ),
          );
        });
  }
}
