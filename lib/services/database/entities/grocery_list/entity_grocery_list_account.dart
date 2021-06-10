import 'dart:convert';
import 'dart:core';

import 'package:get/get.dart';

class EntityGroceryListAccount extends GetxController {
  String uid;
  bool owner = false;
  String createdAt;

  EntityGroceryListAccount({this.uid, this.owner});

  EntityGroceryListAccount.fromJson(Map<String, dynamic> data,
      {String key = ""}) {
    fromJson(data, key: key);
  }

  Map<String, dynamic> toMap() {
    return {
      "owner": this.owner,
      "createdAt": this.createdAt,
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  bool fromJson(Map<String, dynamic> data, {String key = ""}) {
    if (data == null) return false;
    this.uid = key;
    this.owner = data["owner"];
    this.createdAt = data["createdAt"];
    return true;
  }
}
