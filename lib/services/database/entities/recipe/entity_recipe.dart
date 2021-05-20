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
      "pictureUrl": this.pictureUrl,
      "difficulty": this.difficulty,
      "time": this.time,
      "grade": this.grade,
      "peopleNumber": this.peopleNumber,
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
    this.pictureUrl = data["pictureUrl"];
    this.difficulty = data["difficulty"];
    this.time = data["time"];
    this.grade = data["grade"];
    this.peopleNumber = data["peopleNumber"];
    this.createdAt = data["createdAt"];
    this.allergies.addAll(List<String>.from(data["allergies"]));
    this.cuisines.addAll(List<String>.from(data["cuisines"]));
    return true;
  }
}
