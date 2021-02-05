import 'package:flutter/material.dart';
import 'package:feul_delivery/pages/login.dart';

// ignore: camel_case_types
class drawerst extends StatelessWidget {
  const drawerst({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 260,
      child: Column(children: [
        Container(
          child: Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage(
                    "https://images.unsplash.com/photo-1594616838951-c155f8d978a0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80",
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "Station nom",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "Contact@gmail.com",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        ListTile(
          onTap: () {},
          leading: Icon(
            Icons.person,
            color: Colors.orange[900],
          ),
          title: Text("Mon Profile"),
        ),
        ListTile(
          onTap: () {},
          leading: Icon(
            Icons.receipt_rounded,
            color: Colors.orange[900],
          ),
          title: Text("Nos commandes"),
        ),
        ListTile(
          onTap: () {},
          leading: Icon(
            Icons.settings,
            color: Colors.orange[900],
          ),
          title: Text("Paramètres"),
        ),
        Expanded(
            child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 35,
            margin: EdgeInsets.symmetric(horizontal: 65, vertical: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.orange[900]),
            child: Center(
              child: FlatButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()));
                },
                child: Text(
                  "Se déconnecter",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ))
      ]),
    );
  }
}