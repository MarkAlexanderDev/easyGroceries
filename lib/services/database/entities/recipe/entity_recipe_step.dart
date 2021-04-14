import 'dart:convert';
import 'dart:core';

import 'package:get/get.dart';

class EntityRecipeStep extends GetxController {
  String stepID;

  int number;
  String pictureUrl;
  String text;

  EntityRecipeStep.fromJson(Map<String, dynamic> data,
      {String key = ""}) {
    fromJson(data, key: key);
  }

  Map<String, dynamic> toMap() {
    return {
      "number": this.number,
      "pictureUrl": this.pictureUrl,
      "text": this.text
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  bool fromJson(Map<String, dynamic> data, {String key = ""}) {
    if (data == null) return false;
    this.stepID = key;

    this.number = data["number"];
    this.pictureUrl = data["pictureUrl"];
    this.text = data["text"];
    return true;
  }
}
