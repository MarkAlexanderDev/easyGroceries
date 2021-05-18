import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodz/services/database/config.dart';
import 'package:foodz/services/database/entities/recipe/entity_recipe_ingredient.dart';
import 'package:foodz/services/database/services/i_service.dart';

class ServiceRecipeIngredients extends IService<EntityRecipeIngredient> {
  final CollectionReference _collectionReference =
  FirebaseFirestore.instance.collection(endpointRecipe);

  final String _collection = "Ingredients/";

  @override
  Future<DocumentReference> create(EntityRecipeIngredient entity,
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
  Future<EntityRecipeIngredient> read(String id, {String key = ""}) async {
    DocumentSnapshot doc = await _collectionReference
        .doc(key)
        .collection(_collection)
        .doc(id)
        .get();
    if (doc.exists)
      return EntityRecipeIngredient.fromJson(doc.data(), key: key);
    return null;
  }

  @override
  Future<List<EntityRecipeIngredient>> readAll({String key = ""}) async {
    QuerySnapshot snap =
    await _collectionReference.doc(key).collection(_collection).get();
    return snap.docs
        .map((e) => EntityRecipeIngredient.fromJson(e.data(), key: e.id))
        .toList();
  }

  @override
  Future<void> update(
      String uid, EntityRecipeIngredient entityGroceryListAccount,
      {String key = ""}) async {}
}
