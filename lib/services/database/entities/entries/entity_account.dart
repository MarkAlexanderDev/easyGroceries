import 'dart:convert';
import 'dart:core';

import 'package:EasyGroceries/screens/consts.dart';
import 'package:EasyGroceries/screens/onboarding/onboarding.dart';

class EntityAccount {
  String id = "";
  String name;
  String pictureUrl;
  int onboardingFlag = ONBOARDING_STEP_ID_AUTH;
  int cookingExperience = COOKING_EXPERIENCE_ID_BEGINNER;
  int peopleNumber = 2;
  String createdAt = ".";
  bool isPremium = false;

  Map toMap() {
    return {
      "name": this.name,
      "pictureUrl": this.pictureUrl,
      "onboardingFlag": this.onboardingFlag,
      "cookingExperience": this.cookingExperience,
      "peopleNumber": this.peopleNumber,
      "createdAt": this.createdAt,
      "isPremium": this.isPremium,
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  EntityAccount.fromJson(Map<String, dynamic> data, String uid) {
    fromJson(data, uid);
  }

  void fromJson(Map<String, dynamic> data, String uid) {
    if (data != null) {
      this.uid = uid;
      this.name = data["name"];
      this.pictureUrl = data["pictureUrl"];
      this.onboardingFlag = data["onboardingFlag"];
      this.cookingExperience = data["cookingExperience"];
      this.peopleNumber = data["peopleNumber"];
      this.createdAt = data["createdAt"];
      this.isPremium = data["isPremium"];
    }
  }
}
