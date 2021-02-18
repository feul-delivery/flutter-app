import 'package:feul_delivery/modules/user.dart';
import 'package:feul_delivery/pages/client/index_cl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    // return either the index or Authenticate widget
<<<<<<< HEAD
    if (user == null) {
      return Authenticate();
    } else {
      if (user.account == "client") {
        return IndexCl();
      } else if (user.account == "livreur") {
      } else if (user.account == "entreprise") {
        return IndexSt();
      } else if (user.account == "admin") {
        return IndexAdmin();
      }
    }
=======
    return IndexCl();
>>>>>>> parent of 877fa47 (x)
  }
}
