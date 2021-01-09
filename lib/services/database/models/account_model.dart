import 'dart:collection';
import 'dart:convert';
import 'dart:core';

import 'package:EasyGroceries/screens/consts.dart';
import 'package:EasyGroceries/screens/onboarding/onboarding.dart';

class AccountModel {
  String uid = "";
  String firstName;
  String lastName;
  String pictureUrl;
  int cookingExperience = COOKING_EXPERIENCE_ID_BEGINNER;
  int peopleNumber = 2;
  int onboardingFlag = ONBOARDING_STEP_ID_ALLERGIC;
  String createdAt = ".";
  String updatedAt = ".";

  toMap() {
    return {
      "uid": this.uid,
      "firstName": this.firstName,
      "lastName": this.lastName,
      "pictureUrl": this.pictureUrl,
      "cookingExperience": this.cookingExperience,
      "peopleNumber": this.peopleNumber,
      "onboardingFlag": this.onboardingFlag,
      "createdAt": this.createdAt,
      "updatedAt": this.updatedAt,
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  bool fromJson(LinkedHashMap<dynamic, dynamic> data) {
    if (data == null) return false;
    this.uid = data["uid"];
    this.firstName = data["firstName"];
    this.lastName = data["lastName"];
    this.pictureUrl = data["pictureUrl"];
    this.cookingExperience = data["cookingExperience"];
    this.peopleNumber = data["peopleNumber"];
    this.onboardingFlag = data["onboardingFlag"];
    this.createdAt = data["createdAt"];
    this.updatedAt = data["updatedAt"];
    return true;
  }
}