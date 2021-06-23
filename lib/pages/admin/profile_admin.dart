import 'package:FD_flutter/shared/FadeAnimation.dart';
import 'package:FD_flutter/pages/admin/index_admin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileAdmin extends StatefulWidget {
  @override
  _ProfileAdminState createState() => _ProfileAdminState();
}

class _ProfileAdminState extends State<ProfileAdmin> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => IndexAdmin()));
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "My profile",
            ),
            leading: Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.black,
            elevation: 1,
          ),
          body: Container(
            padding: EdgeInsets.only(left: 16, top: 25, right: 16),
            child: ListView(children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 7))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/profile.png'))),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              FadeAnimation(
                0.2,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "First name :",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    Container(
                      child: Text(
                        'Da7mad',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 10,
                thickness: 1,
              ),
              SizedBox(
                height: 10,
              ),
              FadeAnimation(
                0.2,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Last name :",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    Container(
                      child: Text(
                        'Lmkawi',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 15,
                thickness: 1,
              ),
              SizedBox(
                height: 15,
              ),
              FadeAnimation(
                0.2,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Phone :",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    Container(
                      child: Text(
                        '+212601020304',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 15,
                thickness: 1,
              ),
              SizedBox(
                height: 15,
              ),
              FadeAnimation(
                0.2,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Email :",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    Container(
                      child: Text(
                        'Contact@da7mad.com',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 15,
                thickness: 1,
              ),
              SizedBox(
                height: 15,
              ),
              FadeAnimation(
                0.2,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "CIN :",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    Container(
                      child: Text(
                        'CD454545',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 15,
                thickness: 1,
              ),
            ]),
          )),
    );
  }
}
