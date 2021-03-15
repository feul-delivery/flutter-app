import 'package:FD_flutter/authentification/authenticate.dart';
import 'package:FD_flutter/modules/user.dart';
import 'package:FD_flutter/pages/client/index_cl.dart';
import 'package:FD_flutter/pages/station/index_st.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return either the index or Authenticate widget
    switch (Provider.of<User>(context, listen: true).getAccount()) {
      case "cl":
        {
          return IndexCl();
        }
        break;

      case "st":
        {
          return IndexSt();
        }
        break;

      default:
        {
          return Authenticate();
        }
        break;
    }
  }
}
