import 'dart:ui';

import 'package:foodz/style/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const TextStyle textStyleLetter =
    TextStyle(fontWeight: FontWeight.w500, fontSize: 34.0, color: Colors.white);

const TextStyle textStyleH1 = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w300,
  fontSize: 22.0,
);

const TextStyle textStyleH1Green =
    TextStyle(fontWeight: FontWeight.w300, fontSize: 22.0, color: mainColor);

const TextStyle textStyleH1GreenUnderline = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 22.0,
    color: mainColor,
    decoration: TextDecoration.underline);

const TextStyle textStyleH1BoldUnderLine = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 22.0,
  decoration: TextDecoration.underline,
);

const TextStyle textStyleH1Accent =
    TextStyle(fontWeight: FontWeight.w400, fontSize: 22.0, color: accentColor);

const TextStyle textStyleH1White =
    TextStyle(fontWeight: FontWeight.w300, fontSize: 22.0, color: Colors.white);

// H2

const TextStyle textStyleH2 = TextStyle(
  fontWeight: FontWeight.w300,
  fontSize: 16.0,
);

const TextStyle textStyleH2BoldUnderLine = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16.0,
    decoration: TextDecoration.underline);

const TextStyle textStyleH2Accent =
    TextStyle(fontWeight: FontWeight.w300, fontSize: 15.0, color: accentColor);

const TextStyle textStyleH2White =
    TextStyle(fontWeight: FontWeight.w300, fontSize: 16.0, color: Colors.white);

const TextStyle textStyleH2Grey =
    TextStyle(fontWeight: FontWeight.w300, fontSize: 16.0, color: Colors.grey);

const TextStyle textStyleH2Green =
    TextStyle(fontWeight: FontWeight.w300, fontSize: 16.0, color: mainColor);

const TextStyle textStyleH2GreenUnderline = TextStyle(
  fontWeight: FontWeight.w300,
  fontSize: 16.0,
  color: mainColor,
  decoration: TextDecoration.underline,
);

// H3

const TextStyle textStyleH3Bold = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 14.0,
);

// H4

const TextStyle textStyleH4 = TextStyle(
  fontWeight: FontWeight.w300,
  fontSize: 11.0,
);

// special case

const TextStyle textStyleNext =
    TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0, color: mainColor);

const TextStyle textStyleSkip = TextStyle(
  fontWeight: FontWeight.normal,
  fontSize: 16.0,
  color: secondaryColor,
);

const TextStyle textStyleTags = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.w400,
);
