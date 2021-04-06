import 'dart:convert';
import 'dart:core';

import 'package:get/get.dart';

class EntityGroceryListAccount extends GetxController {
  String uid;
  String ownerUid;
  String createdAt;

  EntityGroceryListAccount();

  EntityGroceryListAccount.fromJson(Map<String, dynamic> data,
      {String key = ""}) {
    fromJson(data, key: key);
  }

  Map<String, dynamic> toMap() {
    return {
      "ownerUid": this.ownerUid,
      "createdAt": this.createdAt,
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  bool fromJson(Map<String, dynamic> data, {String key = ""}) {
    if (data == null) return false;
    this.uid = key;
    this.ownerUid = data["ownerUid"];
    this.createdAt = data["createdAt"];
    return true;
  }
}
