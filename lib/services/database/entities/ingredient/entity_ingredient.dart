import 'dart:core';

class EntityIngredient {
  String title;
  String pictureUrl;
  List<int> seasons = [];
  String metric;
  String category;
  List<String> allergies = [];

  EntityIngredient({this.title});

  EntityIngredient.fromJson(Map<String, dynamic> data, {String key = ""}) {
    fromJson(data, key: key);
  }

  bool fromJson(Map<String, dynamic> data, {String key = ""}) {
    if (data == null) return false;
    this.title = key;
    this.pictureUrl = data["pictureUrl"];
    if (data["seasons"] != null)
      this.seasons.addAll(List<int>.from(data["seasons"]));
    this.metric = data["metric"];
    this.category = data["category"];
    if (data["allergies"] != null)
      this.allergies.addAll(List<String>.from(data["allergies"]));
    return true;
  }
}
