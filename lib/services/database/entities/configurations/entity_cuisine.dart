import 'dart:core';

class EntityCuisine {
  String cuisineName;
  String description;
  String pictureUrl;

  EntityCuisine.fromJson(Map<String, dynamic> data, String cuisineName) {
    fromJson(data, cuisineName);
  }

  void fromJson(Map<String, dynamic> data, String cuisineName) {
    if (data != null) {
      this.cuisineName = data["cuisineName"];
      this.description = data["description"];
      this.pictureUrl = data["pictureUrl"];
    }
  }
}
