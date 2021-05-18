import 'dart:convert';
import 'dart:core';

import 'package:get/get.dart';

class EntityFridgeAccount extends GetxController {
  String uid;
  bool owner = false;

  EntityFridgeAccount({this.uid});

  EntityFridgeAccount.fromJson(Map<String, dynamic> data, {String key = ""}) {
    fromJson(data, key: key);
  }

  Map<String, dynamic> toMap() {
    return {
      "ownerUid": this.owner,
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  bool fromJson(Map<String, dynamic> data, {String key = ""}) {
    if (data == null) return false;
    this.uid = key;
    this.owner = data["owner"];
    return true;
  }
}
