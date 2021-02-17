import 'package:flutter/material.dart';
import 'package:feul_delivery/shared/text_styles.dart';

import 'cmd_payement.dart';

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
          "Order",
          style: pageTitle,
        ),
        actions: [
          FlatButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CommandePayment()));
              }
            },
            child: Text(
              'Next',
              style: buttonStyle,
            ),
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.red[900],
        elevation: 1,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
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
                        return 'Required';
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
                        return 'Required';
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
                        labelText: "Address",
                        labelStyle: hintStyle,
                        border: InputBorder.none),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Required';
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
                        labelText: "Registration number",
                        labelStyle: hintStyle,
                        border: InputBorder.none),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Required';
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
                        labelText: "Car color",
                        labelStyle: hintStyle,
                        border: InputBorder.none),
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
