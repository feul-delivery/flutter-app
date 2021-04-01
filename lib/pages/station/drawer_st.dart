import 'package:FD_flutter/pages/station/index_st.dart';
import 'package:FD_flutter/pages/station/type_st.dart';
import 'package:FD_flutter/services/auth.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:FD_flutter/pages/station/profile_st.dart';
import 'package:FD_flutter/pages/station/commandes_st.dart';
import 'package:FD_flutter/pages/station/settings_st.dart';
import '../../wrapper.dart';
import 'bbar_st.dart';

class DrawerSt extends StatelessWidget {
  DrawerSt({Key key}) : super(key: key);
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width * 2 / 3,
      child: Column(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(50)),
                child: IndexSt.entreprise?.photoURL == null
                    ? Image.asset(
                        'assets/total.png',
                      )
                    : CachedNetworkImage(
                        imageUrl: IndexSt.entreprise?.photoURL,
                        imageBuilder: (context, imageProvider) => Container(
                          width: MediaQuery.of(context).size.width * 2 / 3,
                          height: MediaQuery.of(context).size.width * 1 / 3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              // colorFilter: ColorFilter.mode(
                              //     Colors.red, BlendMode.colorBurn)
                            ),
                          ),
                        ),
                        progressIndicatorBuilder: (context, url,
                                downloadProgress) =>
                            CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.white),
                                backgroundColor: Colors.black,
                                value: downloadProgress.progress),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error, color: Colors.black),
                      ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      '${IndexSt.entreprise?.titre?.toUpperCase()}',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      '${IndexSt.entreprise?.email}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        ListTile(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade, child: ProfilSt()));
          },
          leading: Icon(
            Icons.person,
            color: Colors.black,
          ),
          title: Text(
            "Profile",
            style: textStyle,
          ),
        ),
        ListTile(
          onTap: () {
            ButtomBarSt.selectedIndexSt = 1;
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade, child: ToutCommandesSt()));
          },
          leading: Icon(
            Icons.receipt,
            color: Colors.black,
          ),
          title: Text(
            "Orders",
            style: textStyle,
          ),
        ),
        ListTile(
          onTap: () {
            ButtomBarSt.selectedIndexSt = 1;
            Navigator.pushReplacement(context,
                PageTransition(type: PageTransitionType.fade, child: TypeSt()));
          },
          leading: Icon(
            Icons.offline_bolt_rounded,
            color: Colors.black,
          ),
          title: Text(
            "Fuel types",
            style: textStyle,
          ),
        ),
        Expanded(
            child: Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () async {
                  _auth.signOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => Wrapper()));
                },
                child: Container(
                  height: 30,
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  width: MediaQuery.of(context).size.width * 1 / 4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.black),
                  child: Center(
                    child: Text(
                      "Sign out",
                      style: buttonStyle,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
                onPressed: () {
                  _auth.signOut();
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade, child: SettingsSt()));
                },
              )
            ],
          ),
        ))
      ]),
    );
  }
}
