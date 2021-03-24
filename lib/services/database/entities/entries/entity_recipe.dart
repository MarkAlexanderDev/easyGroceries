import 'dart:convert';
import 'dart:core';

class EntityRecipe {
  String id = "";
  String name;
  String createdBy;
  String description;
  String pictureUrl;
  int difficulty;
  String time;
  int grade;
  String createdAt = "";
  // Steps
  // Comments
  // Allergies
  // Cuisines

  Map toMap() {
    return {
      "name": this.name,
      "createdBy": this.createdBy,
      "description": this.description,
      "pictureUrl": this.pictureUrl,
      "difficulty": this.difficulty,
      "time": this.time,
      "grade": this.grade,
      "createdAt": this.createdAt,
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  EntityRecipe.fromJson(Map<String, dynamic> data, String uid) {
    fromJson(data, uid);
  }

  void fromJson(Map<String, dynamic> data, String uid) {
    if (data != null) {
      this.uid = uid;
      this.name = data["name"];
      this.createdBy = data["createdBy"];
      this.description = data["description"];
      this.pictureUrl = data["pictureUrl"];
      this.difficulty = data["difficulty"];
      this.time = data["time"];
      this.grade = data["grade"];
      this.createdAt = data["createdAt"];
    }
  }
}
