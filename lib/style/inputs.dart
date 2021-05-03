import 'package:flutter/material.dart';
import 'package:foodz/style/colors.dart';
import 'package:foodz/style/text_style.dart';

InputDecoration getStandardInputDecoration(labelText, hintText) {
  return InputDecoration(
    hintStyle: textAssistantH1Black,
    hintText: hintText,
    labelText: labelText,
    alignLabelWithHint: true,
    labelStyle: textAssistantH1Black,
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black,
        width: 1.0,
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: mainColor,
        width: 1.0,
      ),
    ),
  );
}
