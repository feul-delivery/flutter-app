import 'package:FD_flutter/authentification/authenticate.dart';
import 'package:FD_flutter/authentification/type_compte.dart';
import 'package:FD_flutter/modules/user.dart';
import 'package:FD_flutter/pages/admin/index_admin.dart';
import 'package:FD_flutter/pages/client/bbar_cl.dart';
import 'package:FD_flutter/pages/client/favoris_cl.dart';
import 'package:FD_flutter/pages/client/index_cl.dart';
import 'package:FD_flutter/pages/livreur/index_lv.dart';
import 'package:FD_flutter/pages/station/bbar_st.dart';
import 'package:FD_flutter/pages/station/index_st.dart';
import 'package:FD_flutter/services/auth.dart';
import 'package:FD_flutter/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wrapper extends StatelessWidget {
  // getClientFavEntreprises(String userUID) async {
  //   Future.delayed(Duration(seconds: 5)).then((value) async {
  //     await Firestore.instance
  //         .collection('client')
  //         .document(userUID)
  //         .get()
  //         .then((value) async =>
  //             FavorisCl.favList = await value.data['favorite']);
  //   });
  // }

  Future<void> _typeAccountChangeStateSharedPrefs() async {
    print("dzt mhna");
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('typeAccount', AuthService.type);
  }

  void initState() {}

  getEntreprise() async {
    ButtomBarSt.selectedIndexSt = 0;
    DatabaseService databaseService = DatabaseService();
    IndexSt.entreprise = await databaseService.entrepriseData();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    // return either the index or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      if (AuthService?.type != null) _typeAccountChangeStateSharedPrefs();
      print(user?.uid);
      print(user.account);
      print(AuthService.type);
      switch (AuthService.type) {
        case "client":
          {
            ButtomBarCl.selectedIndex = 0;
            return IndexCl();
          }
          break;

        case "entreprise":
          {
            getEntreprise();
            return IndexSt();
          }
          break;
        case "admin":
          {
            return IndexAdmin();
          }
          break;
        case "livreur":
          {
            return IndexLv();
          }
          break;
        default:
          {
            return TypeCompte();
          }
          break;
      }
    }
  }
}
