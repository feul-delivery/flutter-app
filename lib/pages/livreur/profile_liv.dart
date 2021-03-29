import 'package:FD_flutter/shared/FadeAnimation.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'bbar_liv.dart';
import 'index_lv.dart';
import 'drawer_liv.dart';
import 'profile_liv_mdf.dart';

class ProfileLiv extends StatefulWidget {
  @override
  _ProfileLivState createState() => _ProfileLivState();
}

class _ProfileLivState extends State<ProfileLiv> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        ButtomBarLiv.selectedIndex = 0;
        Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => IndexLv()));
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
                            ProfileLivModifier()));
                  })
            ],
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
          bottomNavigationBar: ButtomBarLiv(),
          drawer: DrawerLiv(),
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
                            image: IndexLv.livreur?.photoURL == null
                                ? AssetImage('assets/Liv_exp.jpg')
                                : CachedNetworkImage(
                                    imageUrl: IndexLv.livreur.photoURL,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                            colorFilter: ColorFilter.mode(
                                                Colors.red,
                                                BlendMode.colorBurn)),
                                      ),
                                    ),
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                          )),
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
                        '${IndexLv.livreur.prenom}',
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
                        '${IndexLv.livreur.nom}',
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
                        '${IndexLv.livreur.tele}',
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
                        '${IndexLv.livreur.email}',
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
                        '${IndexLv.livreur.cin}',
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
