import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/style/colors.dart';
import 'package:foodz/style/text_style.dart';

class StepItem extends StatelessWidget {
  final int number;
  final String text;

  StepItem({@required this.number, @required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0.05),
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: mainColor, width: 1)),
                child: Center(
                  child: AutoSizeText(
                    number.toString(),
                    style: textFredokaOneH1,
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                  child: AutoSizeText(text, style: textAssistantH2BlackBold))
            ],
          ),
        ),
      ),
    );
  }
}
