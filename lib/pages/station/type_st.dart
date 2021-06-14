import 'package:FD_flutter/modules/user.dart';
import 'package:FD_flutter/wrapper.dart';
import 'package:page_transition/page_transition.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:FD_flutter/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:FD_flutter/shared/lang.dart';

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
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text("Types de Carburant", style: pageTitleW),
            centerTitle: true,
            actions: <Widget>[
              FlatButton(
                child: new Text(
                  "enregistrer",
                  style: buttonStyle,
                ),
                textColor: Colors.white,
                color: Colors.black,
                onPressed: () {
                  AuthService.type = "entreprise";
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
                      child: Center(child: customeCircularProgress));
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
                        title: Text(
                          "${type['libelle']}",
                          style: textStyle.copyWith(color: Colors.black),
                        ),
                        subtitle: Text('${type['prix']} Dh/L',
                            style: hintStyle.copyWith(color: Colors.black54)),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              duration: Duration(seconds: 5),
                              content: Text(
                                'Êtes-vous sûr',
                                style: textStyle.copyWith(color: Colors.white),
                              ),
                              backgroundColor: Colors.black,
                              action: SnackBarAction(
                                textColor: Colors.white,
                                label: 'Confirmer',
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
            label: Text('ajouter un type',
                style: pageTitleW.copyWith(fontSize: 12)),
            icon: Icon(Icons.add),
            backgroundColor: Colors.black,
            elevation: 0,
          ),
        ),
        onWillPop: () => Navigator.of(context).pushReplacement(
            PageTransition(child: Wrapper(), type: PageTransitionType.fade)));
  }

  void _addType(String uid) {
    String _typeName;
    double _typePrix;
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(50)),
                        alignment: Alignment.centerRight,
                        width: 100,
                        height: 30,
                        margin: EdgeInsets.fromLTRB(15, 10, 20, 10),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(50),
                          child: InkWell(
                              borderRadius: BorderRadius.circular(50),
                              onTap: () async {
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
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 7, horizontal: 4),
                                  child: Text(
                                    'Ajouter',
                                    style: buttonStyle,
                                  ),
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    padding:
                        EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
                    child: Form(
                        key: _formKey,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Material(
                                  child: Center(
                                      child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      labelText: "libelle",
                                      labelStyle: hintStyle.copyWith(
                                          color: Colors.black87)),
                                  validator: (val) => val.isEmpty
                                      ? '${Language.mapLang['required']}'
                                      : null,
                                  onChanged: (val) {
                                    setState(() => _typeName = val);
                                  },
                                ),
                              ))),
                              Material(
                                  child: Center(
                                      child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      labelText: "prix",
                                      labelStyle: hintStyle.copyWith(
                                          color: Colors.black87)),
                                  keyboardType: TextInputType.number,
                                  validator: (val) => val == null
                                      ? '${Language.mapLang['required']}'
                                      : null,
                                  onChanged: (val) {
                                    setState(() => _typePrix =
                                        double.tryParse(val) ?? 0.0);
                                  },
                                ),
                              ))),
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
