import 'dart:convert';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EntityGroceryListIngredient extends GetxController {
  String name;
  String pictureUrl;
  RxDouble number = 1.0.obs;
  RxBool checked = false.obs;
  String metric = "";
  String category;

  EntityGroceryListIngredient(
      {@required this.pictureUrl,
      @required this.name,
      @required this.metric,
      @required this.category,
      @required number}) {
    this.number.value = number;
  }

  EntityGroceryListIngredient.fromJson(Map<String, dynamic> data,
      {String key = ""}) {
    fromJson(data, key: key);
  }

  Map<String, dynamic> toMap() {
    return {
      "pictureUrl": this.pictureUrl,
      "number": this.number.value,
      "checked": this.checked.value,
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
    this.checked.value = data["checked"];
    this.metric = data["metric"];
    this.category = data["category"];
    return true;
  }
}
