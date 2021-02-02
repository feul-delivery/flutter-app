import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingCl extends StatefulWidget {
  SettingCl({Key key}) : super(key: key);

  @override
  _SettingClState createState() => _SettingClState();
}

class _SettingClState extends State<SettingCl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Setting",
            style: TextStyle(),
          ),
          centerTitle: true,
          backgroundColor: Colors.orange[900],
          elevation: 1,
        ),
        body: Container(
          padding: EdgeInsets.only(left: 16, top: 25, right: 16),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(children: [
              buildAccountOptionRow(context, "Change password"),
              buildAccountOptionRow(context, "Content settings"),
              buildAccountOptionRow(context, "About us"),
              buildAccountOptionRow(context, "Privacy and security"),
              SizedBox(
                height: 40,
              ),
            ]),
          ),
        ));
  }
}

Row buildNotificationOptionRow(String title, bool isActive) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey[600]),
      ),
      Transform.scale(
          scale: 0.7,
          child: CupertinoSwitch(
            value: isActive,
            onChanged: (bool val) {},
          ))
    ],
  );
}

GestureDetector buildAccountOptionRow(BuildContext context, String title) {
  return GestureDetector(
    onTap: () {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Option 1"),
                  Text("Option 2"),
                  Text("Option 3"),
                ],
              ),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Close")),
              ],
            );
          });
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
          ),
        ],
      ),
    ),
  );
}
