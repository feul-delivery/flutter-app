import 'package:feul_delivery/pages/client/profile_cl.dart';
import 'package:feul_delivery/pages/client/settings.dart';
import 'package:flutter/material.dart';

class DrawerCL extends StatelessWidget {
  const DrawerCL({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange[900],
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
                  "Nom Prénom",
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
        //Now let's Add the button for the Menu
        //and let's copy that and modify it
        ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => ProfileCl()));
          },
          leading: Icon(
            Icons.person,
            color: Colors.black,
          ),
          title: Text("Mon Profile"),
        ),

        ListTile(
          onTap: () {},
          leading: Icon(
            Icons.inbox,
            color: Colors.black,
          ),
          title: Text("Notifucation"),
        ),

        ListTile(
          onTap: () {},
          leading: Icon(
            Icons.assessment,
            color: Colors.black,
          ),
          title: Text("Your Commande"),
        ),

        ListTile(
          onTap: () {Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => SettingCl()));
          },
          leading: Icon(
            Icons.settings,
            color: Colors.black,
          ),
          title: Text("Settings"),
        ),
      ]),
    );
  }
}