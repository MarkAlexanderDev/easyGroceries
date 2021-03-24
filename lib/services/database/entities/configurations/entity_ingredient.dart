import 'dart:core';

class EntityIngredient {
  String ingredientName;
  int seasonStart;
  int seasonEnd;
  int metric;
  String category;
  //allergies

  EntityIngredient.fromJson(Map<String, dynamic> data, String ingredientName) {
    fromJson(data, ingredientName);
  }

  void fromJson(Map<String, dynamic> data, String ingredientName) {
    if (data != null) {
      this.ingredientName = data["ingredientName"];
      this.seasonStart = data["seasonStart"];
      this.seasonEnd = data["seasonEnd"];
      this.metric = data["metric"];
      this.category = data["category"];
    }
  }
}
