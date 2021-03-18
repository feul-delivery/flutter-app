import 'package:FD_flutter/authentification/authenticate.dart';
import 'package:FD_flutter/authentification/type_compte.dart';
import 'package:FD_flutter/modules/user.dart';
import 'package:FD_flutter/pages/admin/index_admin.dart';
import 'package:FD_flutter/pages/client/index_cl.dart';
import 'package:FD_flutter/pages/livreur/index_lv.dart';
import 'package:FD_flutter/pages/station/index_st.dart';
import 'package:FD_flutter/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    // return either the index or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      print(user?.uid);
      print(user.account);
      print(AuthService.type);
      switch (AuthService.type) {
        case "Client":
          {
            return IndexCl();
          }
          break;

        case "Entreprise":
          {
            return IndexSt();
          }
          break;
        case "Admin":
          {
            return IndexAdmin();
          }
          break;
        case "Livreur":
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
