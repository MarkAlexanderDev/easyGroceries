import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/style/text_style.dart';

class FoodzDropdownButton extends StatelessWidget {
  final List<String> items;
  final String currentValue;
  final onChanged;

  FoodzDropdownButton(
      {@required this.items,
      @required this.currentValue,
      @required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        fontFamily: "FredokaOne",
        canvasColor: Colors.white,
      ),
      child: DropdownButton<String>(
        value: currentValue,
        icon: Icon(Icons.keyboard_arrow_down_rounded),
        iconSize: 24,
        elevation: 16,
        underline: Container(
          height: 1,
          color: Colors.grey.withOpacity(0.5),
        ),
        onChanged: (String value) => onChanged(value),
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: AutoSizeText(value, style: textAssistantH1Black),
          );
        }).toList(),
      ),
    );
  }
}
