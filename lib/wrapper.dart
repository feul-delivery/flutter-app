import 'package:FD_flutter/authentification/authenticate.dart';
import 'package:FD_flutter/authentification/type_compte.dart';
import 'package:FD_flutter/modules/user.dart';
import 'package:FD_flutter/pages/admin/index_admin.dart';
import 'package:FD_flutter/pages/client/home.dart';
import 'package:FD_flutter/pages/livreur/bbar_liv.dart';
import 'package:FD_flutter/pages/livreur/index_lv.dart';
import 'package:FD_flutter/pages/station/bbar_st.dart';
import 'package:FD_flutter/pages/station/index_st.dart';
import 'package:FD_flutter/services/auth.dart';
import 'package:FD_flutter/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wrapper extends StatelessWidget {
  Future<void> _typeAccountChangeStateSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('typeAccount', AuthService.type);
  }

  _getEntreprise() async {
    ButtomBarSt.selectedIndexSt = 0;
    DatabaseService databaseService = DatabaseService();
    IndexSt.entreprise = await databaseService.entrepriseData();
  }

  _getLivreur() async {
    ButtomBarLiv.selectedIndex = 0;
    DatabaseService databaseService = DatabaseService();
    IndexLv.livreur = await databaseService.livreurData();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

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
            return HomeCl();
          }
          break;

        case "entreprise":
          {
            _getEntreprise();
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
            _getLivreur();
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
