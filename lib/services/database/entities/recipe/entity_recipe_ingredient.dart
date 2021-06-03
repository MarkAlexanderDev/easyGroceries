import 'dart:convert';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EntityRecipeIngredient extends GetxController {
  String name = "";
  RxDouble number = 1.0.obs;
  String metric = "";

  EntityRecipeIngredient(
      {@required this.name, @required this.metric, @required number}) {
    this.number.value = number;
  }

  EntityRecipeIngredient.fromJson(Map<String, dynamic> data,
      {String key = ""}) {
    fromJson(data, key: key);
  }

  Map<String, dynamic> toMap() {
    return {
      "number": this.number.value,
      "metric": this.metric,
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  bool fromJson(Map<String, dynamic> data, {String key = ""}) {
    if (data == null) return false;
    this.name = key;

    this.number.value = data["number"];
    this.metric = data["metric"];
    return true;
  }
}
