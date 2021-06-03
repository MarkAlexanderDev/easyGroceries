import 'dart:core';

import 'package:flutter/cupertino.dart';

class EntityIngredient {
  String title;
  Image image;
  List<int> seasons = [];
  String metric;
  String category;
  List<String> allergies = [];

  EntityIngredient({
    @required this.title,
    @required this.image,
    @required this.seasons,
    @required this.metric,
    @required this.category,
    @required this.allergies,
  });

  EntityIngredient.fromJson(Map<String, dynamic> data, {String key = ""}) {
    fromJson(data, key: key);
  }

  bool fromJson(Map<String, dynamic> data, {String key = ""}) {
    if (data == null) return false;
    this.title = key;
    if (data["seasons"] != null)
      this.seasons.addAll(List<int>.from(data["seasons"]));
    this.metric = data["metric"];
    this.category = data["category"];
    if (data["allergies"] != null)
      this.allergies.addAll(List<String>.from(data["allergies"]));
    return true;
  }
}
