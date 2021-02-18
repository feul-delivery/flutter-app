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

    return IndexCl();
  }
}
