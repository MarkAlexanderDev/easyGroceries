import 'package:foodz/style/colors.dart';
import 'package:foodz/style/text_style.dart';
import 'package:flutter/material.dart';

InputDecoration getStandardInputDecoration(labelText, hintText) {
  return InputDecoration(
    hintStyle: textStyleH2Grey,
    hintText: hintText,
    labelText: labelText,
    alignLabelWithHint: true,
    labelStyle: textStyleH1Green,
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
