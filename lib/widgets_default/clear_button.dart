import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/style/text_style.dart';

class FoodzClearButton extends StatelessWidget {
  final String label;
  final onClick;

  FoodzClearButton({@required this.onClick, this.label = "Clear"});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
            ),
            padding: MaterialStateProperty.all(EdgeInsets.all(0.0))),
        onPressed: onClick,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                Icons.clear,
                color: Colors.grey,
                size: 15,
              ),
              AutoSizeText(
                label,
                style: textAssistantH3GreyBold,
              ),
            ],
          ),
        ));
  }
}
