import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/style/colors.dart';
import 'package:foodz/style/text_style.dart';

class FoodzFloatingActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final onPressed;

  FoodzFloatingActionButton(
      {@required this.label, @required this.icon, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      label: Row(
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: 10),
          AutoSizeText(
            label,
            style: textFredokaOneH3.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      backgroundColor: mainColor,
    );
  }
}
