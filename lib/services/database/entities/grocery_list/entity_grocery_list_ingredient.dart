import 'dart:convert';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EntityGroceryListIngredient extends GetxController {
  String name;
  RxInt number = 1.obs;
  RxBool checked = false.obs;
  RxString metric = "".obs;
  String category;

  EntityGroceryListIngredient(
      {@required this.name, @required metric, @required this.category}) {
    this.metric.value = metric;
  }

  EntityGroceryListIngredient.fromJson(Map<String, dynamic> data,
      {String key = ""}) {
    fromJson(data, key: key);
  }

  Map<String, dynamic> toMap() {
    return {
      "number": this.number.value,
      "checked": this.checked.value,
      "metric": this.metric.value,
      "category": this.category,
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  bool fromJson(Map<String, dynamic> data, {String key = ""}) {
    if (data == null) return false;
    this.name = key;
    this.number = data["number"];
    this.checked = data["checked"];
    this.metric = data["metric"];
    this.category = data["category"];
    return true;
  }
}
