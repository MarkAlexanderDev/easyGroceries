import 'dart:collection';
import 'dart:convert';
import 'dart:core';

import 'package:foodz/screens/consts.dart';
import 'package:foodz/screens/onboarding/onboarding.dart';

class AccountModel {
  String uid = "";
  String name;
  String pictureUrl;
  int cookingExperience = COOKING_EXPERIENCE_ID_BEGINNER;
  int peopleNumber = 2;
  int onboardingFlag = ONBOARDING_STEP_ID_AUTH;
  String createdAt = ".";

  toMap() {
    return {
      "name": this.name,
      "pictureUrl": this.pictureUrl,
      "cookingExperience": this.cookingExperience,
      "peopleNumber": this.peopleNumber,
      "onboardingFlag": this.onboardingFlag,
      "createdAt": this.createdAt,
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  bool fromJson(LinkedHashMap<dynamic, dynamic> data) {
    if (data == null) return false;
    this.name = data["name"];
    this.pictureUrl = data["pictureUrl"];
    this.cookingExperience = data["cookingExperience"];
    this.peopleNumber = data["peopleNumber"];
    this.onboardingFlag = data["onboardingFlag"];
    this.createdAt = data["createdAt"];
    return true;
  }
}
