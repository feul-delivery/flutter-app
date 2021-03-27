import 'package:FD_flutter/pages/station/index_st.dart';
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
          child: Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IndexSt.entreprise?.photoURL == null
                    ? AssetImage('assets/total.png')
                    : CachedNetworkImage(
                        imageUrl: IndexSt.entreprise?.photoURL,
                        imageBuilder: (context, imageProvider) => CircleAvatar(
                          radius: 50.0,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                                // colorFilter: ColorFilter.mode(
                                //     Colors.red, BlendMode.colorBurn)
                              ),
                            ),
                          ),
                        ),
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error, color: Colors.red[900]),
                      ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  '${IndexSt.entreprise?.titre}',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  '${IndexSt.entreprise?.email}',
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
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade, child: ProfilSt()));
          },
          leading: Icon(
            Icons.person,
            color: Colors.red[900],
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
            color: Colors.red[900],
          ),
          title: Text(
            "Orders",
            style: textStyle,
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade, child: SettingsSt()));
          },
          leading: Icon(
            Icons.settings,
            color: Colors.red[900],
          ),
          title: Text(
            "Settings",
            style: textStyle,
          ),
        ),
        Expanded(
            child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 35,
            margin: EdgeInsets.symmetric(horizontal: 55, vertical: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red[900]),
            child: Center(
              child: FlatButton(
                onPressed: () async {
                  _auth.signOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => Wrapper()));
                },
                child: Text(
                  "Sign out",
                  style: buttonStyle,
                ),
              ),
            ),
          ),
        ))
      ]),
    );
  }
}
