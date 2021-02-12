import 'package:flutter/material.dart';
import 'package:feul_delivery/styles/textStyles.dart';

class Cmd1 extends StatefulWidget {
  @override
  _Cmd1State createState() => _Cmd1State();
}

class _Cmd1State extends State<Cmd1> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "faire un commande",
          style: TextStyle(),
        ),
        centerTitle: true,
        backgroundColor: Colors.red[900],
        elevation: 1,
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.grey[200]))),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "Volume",
                        labelStyle: hintStyle,
                        border: InputBorder.none),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'cet information est obligatoire';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.grey[200]))),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "Type",
                        labelStyle: hintStyle,
                        border: InputBorder.none),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'cet information est obligatoire';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey[200]))),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "Adresse",
                        labelStyle: hintStyle,
                        border: InputBorder.none),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'cet information est obligatoire';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red[700]),
                  child: Center(
                    child: FlatButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {}
                      },
                      child: Text(
                        'Submit',
                        style: buttonStyle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
