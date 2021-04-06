import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodz/services/database/config.dart';
import 'package:foodz/services/database/entities/ingredient/entity_ingredient.dart';

import '../i_service.dart';

class ServiceIngredients extends IService<String> {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection(endpointIngredients);

  @override
  Future<void> create(String entity, {String key = ""}) {
    return null;
  }

  @override
  Future<String> read(String id, {String key = ""}) async {
    return null;
  }

  @override
  Future<void> delete(String id, {String key = ""}) {
    return null;
  }

  @override
  Future<List<String>> readAll({String key = ""}) async {
    QuerySnapshot querySnapshot = await _collectionReference.get();
    return querySnapshot.docs.map((e) => e.id).toList();
  }

  @override
  Future<void> update(String id, String entity, {String key = ""}) {
    return null;
  }

  Future<List<EntityIngredient>> search(String text) async {
    QuerySnapshot querySnapshot = await _collectionReference.get();
    List<EntityIngredient> ingredientsQuery =
        querySnapshot.docs.where((e) => e.id.contains(text)).map((e) {
      return EntityIngredient.fromJson(e.data(), key: e.id);
    }).toList();
    print(ingredientsQuery.first.title);
    return ingredientsQuery;
  }
}
