import 'package:feul_delivery/authentification/authenticate.dart';
import 'package:feul_delivery/modules/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    // return either the Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      if (user.account == "client") {
      } else if (user.account == "livreur") {
      } else if (user.account == "entreprise") {
      } else if (user.account == "admin") {}
    }
  }
}
