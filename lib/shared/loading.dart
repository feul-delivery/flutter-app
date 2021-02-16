import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: SpinKitFoldingCube(
          color: Colors.redAccent[600],
          size: 50.0,
        ),
      ),
    );
  }
}
