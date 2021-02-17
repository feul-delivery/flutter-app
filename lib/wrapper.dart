import 'package:feul_delivery/authentification/authenticate.dart';
import 'package:feul_delivery/modules/user.dart';
import 'package:feul_delivery/pages/admin/index_admin.dart';
import 'package:feul_delivery/pages/client/index_cl.dart';
import 'package:feul_delivery/pages/station/index_st.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    //return either the index or Authenticate widget
    // if (currentUser.account == "client") {
    //   return IndexCl();
    // } else if (currentUser.account == "livreur") {
    // } else if (currentUser.account == "entreprise") {
    //   return IndexSt();
    // } else if (currentUser.account == "admin") {
    //   return IndexAdmin();
    // }
    return Authenticate();
  }
}
