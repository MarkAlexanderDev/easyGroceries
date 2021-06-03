import 'dart:convert';
import 'dart:core';

import 'package:get/get.dart';

class EntityGroceryList extends GetxController {
  String uid;
  RxString name = "Monday shopping".obs;
  String description;
  RxString pictureUrl = "".obs;
  RxString cronReminder = "".obs;
  int peopleNb;

  EntityGroceryList() {
    description = "All my needs for the week";
    peopleNb = 1;
  }

  EntityGroceryList.fromJson(Map<String, dynamic> data, {String key = ""}) {
    fromJson(data, key: key);
  }

  Map<String, dynamic> toMap() {
    return {
      "name": this.name.value,
      "description": this.description,
      "pictureUrl": this.pictureUrl.value,
      "cronReminder": this.cronReminder.value,
      "peopleNb": this.peopleNb,
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  bool fromJson(Map<String, dynamic> data, {String key = ""}) {
    if (data == null) return false;
    this.uid = key;
    this.name.value = data["name"];
    this.description = data["description"];
    this.pictureUrl.value = data["pictureUrl"];
    this.cronReminder.value = data["cronReminder"];
    this.peopleNb = data["peopleNb"];
    return true;
  }
}
