import 'dart:convert';
import 'dart:core';

import 'package:get/get.dart';

class EntityFridge extends GetxController {
  String uid;

  EntityFridge();

  EntityFridge.fromJson(Map<String, dynamic> data, {String key = ""}) {
    fromJson(data, key: key);
  }

  set updatedAt(String updatedAt) {}

  Map<String, dynamic> toMap() {
    return {};
  }

  String toJson() {
    return json.encode(toMap());
  }

  bool fromJson(Map<String, dynamic> data, {String key = ""}) {
    if (data == null) return false;
    this.uid = key;
    return true;
  }
}
