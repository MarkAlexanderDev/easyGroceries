import 'dart:convert';
import 'dart:core';

import 'package:get/get.dart';

class EntityAccount extends GetxController {
  String uid;
  RxString name = "".obs;
  RxString pictureUrl = "".obs;
  RxInt onboardingFlag = 0.obs;
  RxInt cookingExperience = 0.obs;
  RxInt peopleNb = 1.obs;
  String createdAt;
  bool isPremium;
  RxList<String> allergies = <String>[].obs;
  RxList<String> cuisines = <String>[].obs;

  EntityAccount();

  EntityAccount.fromJson(Map<String, dynamic> data, {String key = ""}) {
    fromJson(data, key: key);
  }

  set updatedAt(String updatedAt) {}

  Map<String, dynamic> toMap() {
    return {
      "name": this.name.value,
      "pictureUrl": this.pictureUrl.value,
      "onboardingFlag": this.onboardingFlag.value,
      "cookingExperience": this.cookingExperience.value,
      "peopleNb": this.peopleNb.value,
      "createdAt": this.createdAt,
      "isPremium": this.isPremium,
      "allergies": this.allergies.toList(),
      "cuisines": this.cuisines.toList(),
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  bool fromJson(Map<String, dynamic> data, {String key = ""}) {
    if (data == null) return false;
    this.uid = key;
    this.name.value = data["name"];
    this.pictureUrl.value = data["pictureUrl"];
    this.onboardingFlag.value = data["onboardingFlag"];
    this.cookingExperience.value = data["cookingExperience"];
    this.peopleNb.value = data["peopleNb"];
    this.createdAt = data["createdAt"];
    this.isPremium = data["isPremium"];
    this.allergies.addAll(List<String>.from(data["allergies"]));
    this.cuisines.addAll(List<String>.from(data["cuisines"]));
    return true;
  }
}
