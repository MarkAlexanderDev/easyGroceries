import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/style/colors.dart';
import 'package:foodz/style/text_style.dart';

class FoodzButton extends StatelessWidget {
  final String label;
  final onClick;
  final bool danger;

  FoodzButton(
      {@required this.onClick, @required this.label, this.danger = false});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(danger ? red : mainColor),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
            ),
            padding: MaterialStateProperty.all(EdgeInsets.all(0.0))),
        onPressed: onClick,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AutoSizeText(
            label,
            style: textFredokaOneH3White,
          ),
        ));
  }
}
