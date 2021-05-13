import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/style/colors.dart';

class FoodzCheckbox extends StatelessWidget {
  final bool value;
  final onChanged;

  FoodzCheckbox({@required this.value, @required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: mainColor,
      ),
      child: Checkbox(
          checkColor: Colors.white,
          activeColor: mainColor,
          value: value,
          onChanged: onChanged),
    );
  }
}
