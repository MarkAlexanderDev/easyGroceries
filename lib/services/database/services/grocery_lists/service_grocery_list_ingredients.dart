import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodz/services/database/config.dart';
import 'package:foodz/services/database/entities/grocery_list/entity_grocery_list_ingredient.dart';
import 'package:foodz/services/database/services/i_service.dart';

class ServiceGroceryListIngredients
    extends IService<EntityGroceryListIngredient> {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection(endpointGroceryLists);

  final String _collection = "Ingredients/";

  @override
  Future<void> create(EntityGroceryListIngredient entity,
      {String key = ""}) async {
    await _collectionReference
        .doc(key)
        .collection(_collection)
        .doc(entity.name)
        .set(entity.toMap());
  }

  @override
  Future<void> delete(String uid, {String key = ""}) async {
    await _collectionReference
        .doc(key)
        .collection(_collection)
        .doc(uid)
        .delete();
  }

  @override
  Future<EntityGroceryListIngredient> read(String uid,
      {String key = ""}) async {
    return null;
  }

  @override
  Future<List<EntityGroceryListIngredient>> readAll({String key = ""}) async {
    QuerySnapshot snap =
        await _collectionReference.doc(key).collection(_collection).get();
    return snap.docs
        .map((e) => EntityGroceryListIngredient.fromJson(e.data(), key: e.id))
        .toList();
  }

  Stream<List<EntityGroceryListIngredient>> streamAll(
      {String key = ""}) async* {
    QuerySnapshot snap =
        await _collectionReference.doc(key).collection(_collection).get();
    final List<EntityGroceryListIngredient> stream = snap.docs
        .map((e) => EntityGroceryListIngredient.fromJson(e.data(), key: e.id))
        .toList();
    yield stream;
  }

  @override
  Future<void> update(
      String uid, EntityGroceryListIngredient entityGroceryListIngredient,
      {String key = ""}) async {
    await _collectionReference
        .doc(key)
        .collection(_collection)
        .doc(entityGroceryListIngredient.name)
        .update(entityGroceryListIngredient.toMap());
  }
}
