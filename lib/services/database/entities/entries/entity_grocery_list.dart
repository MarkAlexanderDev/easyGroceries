import 'dart:convert';
import 'dart:core';

import 'package:EasyGroceries/services/database/entities/entries/entity_account_grocery_list.dart';

class EntityGroceryList {
  String id = "";
  String name;
  String description;
  String pictureUrl;
  String color;
  String createdAt;
  String updatedAt;
  EntityAccountGroceryList accountGroceryList;
  // Ingredients

  Map toMap() {
    return {
      "name": this.name,
      "description": this.description,
      "pictureUrl": this.pictureUrl,
      "color": this.color,
      "createdAt": this.createdAt,
      "updatedAt": this.updatedAt,
      "accountGroceryList": {
        accountGroceryList.createdAt,
        accountGroceryList.ownerAccountId,
      }
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  EntityGroceryList.fromJson(Map<String, dynamic> data, String uid) {
    fromJson(data, uid);
  }

  void fromJson(Map<String, dynamic> data, String uid) {
    if (data != null) {
      this.id = uid;
      this.name = data["name"];
      this.description = data["description"];
      this.pictureUrl = data["pictureUrl"];
      this.color = data["color"];
      this.createdAt = data["createdAt"];
      this.updatedAt = data["updatedAt"];
      this.accountGroceryList = EntityAccountGroceryList.fromJson(
          data["accountGroceryList"], data["accountGroceryList"]);
    }
  }
}
