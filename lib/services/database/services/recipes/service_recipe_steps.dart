import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodz/services/database/config.dart';

import 'package:foodz/services/database/entities/recipe/entity_recipe_step.dart';
import 'package:foodz/services/database/services/i_service.dart';

class ServiceRecipeSteps extends IService<EntityRecipeStep> {
  final CollectionReference _collectionReference =
  FirebaseFirestore.instance.collection(endpointRecipe);

  final String _collection = "Steps/";

  @override
  Future<DocumentReference> create(EntityRecipeStep entity,
      {String key = ""}) async {
    return await _collectionReference
        .doc(key)
        .collection(_collection)
        .add(entity.toMap());
  }

  @override
  Future<void> delete(String id, {String key = ""}) async {
    await _collectionReference
        .doc(key)
        .collection(_collection)
        .doc(id)
        .delete();
  }

  @override
  Future<EntityRecipeStep> read(String id, {String key = ""}) async {
    DocumentSnapshot doc = await _collectionReference
        .doc(key)
        .collection(_collection)
        .doc(id)
        .get();
    if (doc.exists)
      return EntityRecipeStep.fromJson(doc.data(), key: key);
    return null;
  }

  @override
  Future<List<EntityRecipeStep>> readAll({String key = ""}) async {
    QuerySnapshot snap =
    await _collectionReference.doc(key).collection(_collection).get();
    return snap.docs
        .map((e) => EntityRecipeStep.fromJson(e.data(), key: e.id))
        .toList();
  }

  @override
  Future<void> update(
      String uid, EntityRecipeStep entityGroceryListAccount,
      {String key = ""}) async {}
}
