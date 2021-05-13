import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foodz/style/colors.dart';

class FoodzLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SpinKitDualRing(
          color: mainColor,
          size: 28.0,
          lineWidth: 3.0,
        ),
      ),
    );
  }
}
