import 'dart:convert';
import 'dart:core';

import 'package:get/get.dart';

class EntityGroceryList extends GetxController {
  String uid;
  RxString name = "".obs;
  RxString description = "".obs;
  RxString pictureUrl = "".obs;
  RxString cronReminder = "".obs;
  String createdAt;
  String updatedAt;

  EntityGroceryList();

  EntityGroceryList.fromJson(Map<String, dynamic> data, {String key = ""}) {
    fromJson(data, key: key);
  }

  Map<String, dynamic> toMap() {
    return {
      "name": this.name.value,
      "description": this.description.value,
      "pictureUrl": this.pictureUrl.value,
      "cronReminder": this.cronReminder.value,
      "createdAt": this.createdAt,
      "updatedAt": this.updatedAt,
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  bool fromJson(Map<String, dynamic> data, {String key = ""}) {
    if (data == null) return false;
    this.uid = key;
    this.name.value = data["name"];
    this.description.value = data["description"];
    this.pictureUrl.value = data["pictureUrl"];
    this.cronReminder.value = data["cronReminder"];
    this.createdAt = data["createdAt"];
    this.updatedAt = data["updatedAt"];
    return true;
  }
}
