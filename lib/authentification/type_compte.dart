import 'package:FD_flutter/services/database.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TypeCompte extends StatefulWidget {
  @override
  _TypeCompteState createState() => _TypeCompteState();
}

class _TypeCompteState extends State<TypeCompte> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Account type",
            style: pageTitle,
          ),
          backgroundColor: Colors.red[900],
          centerTitle: true,
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    final FirebaseAuth auth = FirebaseAuth.instance;
                    final FirebaseUser user = await auth.currentUser();
                    final uid = user.uid;
                    print(uid);
                    DatabaseService(uid: uid).updateUserData("cl");
                    //goto user inyterface
                  },
                  child: Container(
                    decoration: new BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.red[900].withOpacity(0.4),
                              blurRadius: 20,
                              offset: Offset(0, 10))
                        ]),
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text('Customer',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 34.0))
                            ],
                          ),
                          Material(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(24.0),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Icon(Icons.account_circle,
                                    color: Colors.white, size: 40.0),
                              )))
                        ]),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                    onTap: () async {
                    final FirebaseAuth auth = FirebaseAuth.instance;
                    final FirebaseUser user = await auth.currentUser();
                    final uid = user.uid;
                    print(uid);
                    DatabaseService(uid: uid).updateUserData("st");
                    // here you write the codes to input the data into firestore
                  },
                  child: Container(
                    decoration: new BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.red[900].withOpacity(0.4),
                              blurRadius: 20,
                              offset: Offset(0, 10))
                        ]),
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text('Entreprise',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 34.0))
                            ],
                          ),
                          Material(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(24.0),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Image(
                                  height: 40,
                                  width: 40,
                                  image: AssetImage('assets/fuel_tank_32.png'),
                                  color: Colors.white,
                                ),
                              )))
                        ]),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            )));
  }
}
