import 'package:FD_flutter/pages/client/profile_mdf.dart';
import 'package:FD_flutter/shared/FadeAnimation.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'bbar_cl.dart';
import 'drawer_cl.dart';
import 'index_cl.dart';

// ignore: camel_case_types
class ProfileCl extends StatefulWidget {
  @override
  _ProfileClState createState() => _ProfileClState();
}

// ignore: camel_case_types
class _ProfileClState extends State<ProfileCl> {
  // Future _getEntData() async {
  //   final FirebaseAuth auth = FirebaseAuth.instance;
  //   final FirebaseUser user = await auth.currentUser();
  //   uid = user.uid;
  //   email = user.email;
  //   Firestore.instance
  //       .collection('client')
  //       .document(uid)
  //       .get()
  //       .then((value) async {
  //     print(uid);
  //     if (value.exists) {
  //       var key1 = await value.data['cin'];
  //       var key2 = await value.data['ville'];
  //       var key3 = await value.data['nom'];
  //       var key4 = await value.data['prenom'];
  //       var key5 = await value.data['sexe'];
  //       var key6 = await value.data['tele'];
  //       print(key1);
  //       setState(() {
  //         this.cin = key1;
  //         this.ville = key2;
  //         this.nom = key3;
  //         this.prenom = key4;
  //         this.sexe = key5;
  //         this.tele = key6;
  //       });
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        ButtomBarCl.selectedIndex = 0;
        Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => IndexCl()));
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "My profile",
              style: pageTitle,
            ),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ProfileCLModifier()));
                  })
            ],
            leading: Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.red[900],
            elevation: 1,
          ),
          bottomNavigationBar: ButtomBarCl(),
          drawer: DrawerCL(),
          body: Container(
            padding: EdgeInsets.only(left: 16, top: 25, right: 16),
            child: ListView(children: [
              Center(
                child: Stack(
                  children: [
                    IndexCl.client?.photoURL == null
                        ? Container(
                            width: 140,
                            height: 140,
                            child: CircleAvatar(
                              radius: 35.0,
                              backgroundImage: AssetImage('assets/profile.png'),
                            ),
                          )
                        : CachedNetworkImage(
                            imageUrl: IndexCl.client.photoURL,
                            imageBuilder: (context, imageProvider) => Container(
                              width: 140,
                              height: 140,
                              child: CircleAvatar(
                                  radius: 35.0, backgroundImage: imageProvider),
                            ),
                            placeholder: (context, url) => Container(
                              width: 140,
                              height: 140,
                              child: CircleAvatar(
                                  radius: 35.0,
                                  child: CircularProgressIndicator()),
                            ),
                            errorWidget: (context, url, error) => Container(
                              width: 140,
                              height: 140,
                              child: CircleAvatar(
                                  radius: 35.0, child: Icon(Icons.error)),
                            ),
                          ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              FadeAnimation(
                1.2,
                Row(
                  children: [
                    Text(
                      "First name : ",
                      style: textStyle,
                    ),
                    Container(
                      child: Text(
                        '${IndexCl.client?.prenom}',
                        style: strongTextStyle,
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 30,
                thickness: 1,
              ),
              FadeAnimation(
                1.2,
                Row(
                  children: [
                    Text(
                      "Last name : ",
                      style: textStyle,
                    ),
                    Container(
                      child: Text(
                        '${IndexCl.client.nom}',
                        style: strongTextStyle,
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 30,
                thickness: 1,
              ),
              FadeAnimation(
                1.2,
                Row(
                  children: [
                    Text(
                      "Phone : ",
                      style: textStyle,
                    ),
                    Container(
                      child: Text(
                        '${IndexCl.client.tele}',
                        style: strongTextStyle,
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 30,
                thickness: 1,
              ),
              FadeAnimation(
                1.2,
                Row(
                  children: [
                    Text(
                      "Email : ",
                      style: textStyle,
                    ),
                    Container(
                      child: Text(
                        '${IndexCl.client.email}',
                        style: strongTextStyle,
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 30,
                thickness: 1,
              ),
              FadeAnimation(
                1.2,
                Row(
                  children: [
                    Text(
                      "CIN : ",
                      style: textStyle,
                    ),
                    Container(
                      child: Text(
                        '${IndexCl.client.cin}',
                        style: strongTextStyle,
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 30,
                thickness: 1,
              ),
            ]),
          )),
    );
  }
}
