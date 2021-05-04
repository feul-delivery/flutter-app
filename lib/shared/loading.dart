import 'package:FD_flutter/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: scaffoldBackground,
      child: Center(
        child: SpinKitRing(
          color: Colors.white,
          size: 40.0,
        ),
      ),
    );
  }
}
