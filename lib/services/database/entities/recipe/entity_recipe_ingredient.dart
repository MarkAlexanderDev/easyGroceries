import 'dart:convert';
import 'dart:core';

import 'package:get/get.dart';

class EntityRecipeIngredient extends GetxController {
  String ingredientName;

  int number;

  EntityRecipeIngredient.fromJson(Map<String, dynamic> data,
      {String key = ""}) {
    fromJson(data, key: key);
  }

  Map<String, dynamic> toMap() {
    return {
      "number": this.number
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  bool fromJson(Map<String, dynamic> data, {String key = ""}) {
    if (data == null) return false;
    this.ingredientName = key;

    this.number = data["number"];
    return true;
  }
}
