import 'dart:convert';
import 'dart:core';

class EntityAccountGroceryList {
  String accountId = "";
  String ownerAccountId;
  String createdAt;

  Map toMap() {
    return {
      "ownerAccountId": this.ownerAccountId,
      "createdAt": this.createdAt,
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  EntityAccountGroceryList.fromJson(
      Map<String, dynamic> data, String accountId) {
    fromJson(data, accountId);
  }

  void fromJson(Map<String, dynamic> data, String accountId) {
    if (data != null) {
      this.accountId = accountId;
      this.ownerAccountId = data["ownerAccountId"];
      this.createdAt = data["createdAt"];
    }
  }
}
