import 'package:FD_flutter/authentification/authenticate.dart';
import 'package:FD_flutter/modules/user.dart';
import 'package:FD_flutter/pages/admin/index_admin.dart';
import 'package:FD_flutter/pages/client/index_cl.dart';
import 'package:FD_flutter/pages/station/index_st.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    // return either the index or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else if (user.account == "client") {
      return IndexCl();
    } else if (user.account == "entreprise") {
      return IndexSt();
    } else if (user.account == "livreur") {
    } else if (user.account == "admin") {
      return IndexAdmin();
    } else if (user.account == "") {
      return Authenticate();
    }
    return Authenticate();
  }
}
