import 'dart:convert';
import 'dart:core';

import 'package:get/get.dart';

class EntityRecipe extends GetxController {
  String uid;

  String createdBy;
  String name;
  String description;
  RxString pictureUrl = "".obs;
  RxInt difficulty = 0.obs;
  RxString time = "".obs;
  RxInt grade = 0.obs;
  RxInt peopleNumber = 0.obs;
  String createdAt;
  RxList<String> allergies = <String>[].obs;
  RxList<String> cuisines = <String>[].obs;

  EntityRecipe();

  EntityRecipe.fromJson(Map<String, dynamic> data, {String key = ""}) {
    fromJson(data, key: key);
  }

  Map<String, dynamic> toMap() {
    return {
      "createdBy": this.createdBy,
      "name": this.name,
      "description": this.description,
      "pictureUrl": this.pictureUrl.value,
      "difficulty": this.difficulty.value,
      "time": this.time.value,
      "grade": this.grade.value,
      "peopleNumber": this.peopleNumber.value,
      "createdAt": this.createdAt,
      "allergies": this.allergies.toList(),
      "cuisines": this.cuisines.toList()
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  bool fromJson(Map<String, dynamic> data, {String key = ""}) {
    if (data == null) return false;
    this.uid = key;

    this.createdBy = data["createdBy"];
    this.name = data["name"];
    this.description = data["description"];
    this.pictureUrl.value = data["pictureUrl"];
    this.difficulty.value = data["difficulty"];
    this.time.value = data["time"];
    this.grade.value = data["grade"];
    this.peopleNumber.value = data["peopleNumber"];
    this.createdAt = data["createdAt"];
    this.allergies.addAll(List<String>.from(data["allergies"]));
    this.cuisines.addAll(List<String>.from(data["cuisines"]));
    return true;
  }
}
