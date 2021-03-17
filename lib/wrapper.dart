import 'package:FD_flutter/authentification/authenticate.dart';
import 'package:FD_flutter/authentification/type_compte.dart';
import 'package:FD_flutter/modules/user.dart';
import 'package:FD_flutter/pages/admin/index_admin.dart';
import 'package:FD_flutter/pages/client/index_cl.dart';
import 'package:FD_flutter/pages/livreur/index_lv.dart';
import 'package:FD_flutter/pages/station/index_st.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return either the index or Authenticate widget
    if (Provider.of<User>(context, listen: true)?.uid == "" ||
        Provider.of<User>(context, listen: true)?.uid == null) {
      print(Provider.of<User>(context, listen: true)?.uid);
      return Authenticate();
    } else {
      switch (Provider.of<User>(context, listen: true)?.account) {
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
