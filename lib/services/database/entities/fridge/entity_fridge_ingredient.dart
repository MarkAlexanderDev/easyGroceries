import 'dart:convert';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EntityFridgeIngredient extends GetxController {
  String name;
  String pictureUrl;
  RxDouble number = 1.0.obs;
  String metric = "";
  String category;

  EntityFridgeIngredient(
      {@required this.pictureUrl,
      @required this.name,
      @required this.metric,
      @required number,
      @required this.category}) {
    this.number.value = number;
  }

  EntityFridgeIngredient.fromJson(Map<String, dynamic> data,
      {String key = ""}) {
    fromJson(data, key: key);
  }

  Map<String, dynamic> toMap() {
    return {
      "pictureUrl": this.pictureUrl,
      "number": this.number.value,
      "metric": this.metric,
      "category": this.category,
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  bool fromJson(Map<String, dynamic> data, {String key = ""}) {
    if (data == null) return false;
    this.name = key;
    this.pictureUrl = data["pictureUrl"];
    this.number.value = data["number"];
    this.metric = data["metric"];
    this.category = data["category"];
    return true;
  }
}
