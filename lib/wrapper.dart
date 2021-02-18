import 'package:FD_flutter/authentification/authenticate.dart';
import 'package:FD_flutter/modules/user.dart';
import 'package:FD_flutter/pages/client/index_cl.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    // return either the index or Authenticate widget
    if (user == null) return Authenticate();
    return IndexCl();
  }
}
