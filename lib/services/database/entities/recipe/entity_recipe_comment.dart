import 'dart:convert';
import 'dart:core';

import 'package:get/get.dart';

class EntityRecipeComment extends GetxController {
  String commentID;

  String accountID;
  String text;
  List<String> picturesUrl;
  String createdAt;

  EntityRecipeComment.fromJson(Map<String, dynamic> data,
      {String key = ""}) {
    fromJson(data, key: key);
  }

  Map<String, dynamic> toMap() {
    return {
      "accountID": this.accountID,
      "text": this.text,
      "picturesUrl": this.picturesUrl.toList(),
      "createdAt": this.createdAt
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  bool fromJson(Map<String, dynamic> data, {String key = ""}) {
    if (data == null) return false;
    this.commentID = key;

    this.accountID = data["accountID"];
    this.text = data["text"];
    this.picturesUrl.addAll(List<String>.from(data["picturesUrl"]));
    this.createdAt = data["createdAt"];
    return true;
  }
}
