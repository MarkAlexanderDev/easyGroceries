import 'package:foodz/style/colors.dart';
import 'package:foodz/style/text_style.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmButton extends StatelessWidget {
  final onClick;
  final bool enabled;

  ConfirmButton({@required this.onClick, @required this.enabled});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: FloatingActionButton(
        elevation: 0.0,
        onPressed: enabled ? onClick : null,
        child: Container(
          decoration: BoxDecoration(
              color: enabled ? mainColor : grey,
              borderRadius: BorderRadius.circular(10.0)),
          child: Center(
            child: AutoSizeText(
              "CONFIRM",
              style: textStyleH1White,
            ),
          ),
        ),
      ),
    );
  }
}
