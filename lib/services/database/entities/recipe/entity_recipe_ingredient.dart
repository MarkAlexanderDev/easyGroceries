import 'dart:convert';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EntityRecipeIngredient extends GetxController {
  String name;
  String pictureUrl;
  int number;

  EntityRecipeIngredient({@required name, @required pictureUrl}) {
    this.name = name;
    this.pictureUrl = pictureUrl;
    number = 1;
  }

  EntityRecipeIngredient.fromJson(Map<String, dynamic> data,
      {String key = ""}) {
    fromJson(data, key: key);
  }

  Map<String, dynamic> toMap() {
    return {
      "number": this.number,
      "pictureUrl": this.pictureUrl,
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  bool fromJson(Map<String, dynamic> data, {String key = ""}) {
    if (data == null) return false;
    this.name = key;

    this.number = data["number"];
    this.pictureUrl = data["pictureUrl"];
    return true;
  }
}
