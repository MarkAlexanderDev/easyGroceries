import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodz/services/database/config.dart';
import 'package:foodz/services/database/entities/fridge/entity_fridge_ingredient.dart';
import 'package:foodz/services/database/services/i_service.dart';

class ServiceFridgeIngredients extends IService<EntityFridgeIngredient> {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection(endpointFridges);

  final String _collection = "Ingredients/";

  @override
  Future<void> create(EntityFridgeIngredient entity, {String key = ""}) async {
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
  Future<EntityFridgeIngredient> read(String uid, {String key = ""}) async {
    return null;
  }

  @override
  Future<List<EntityFridgeIngredient>> readAll({String key = ""}) async {
    QuerySnapshot snap =
        await _collectionReference.doc(key).collection(_collection).get();
    return snap.docs
        .map((e) => EntityFridgeIngredient.fromJson(e.data(), key: e.id))
        .toList();
  }

  @override
  Future<void> update(String uid, EntityFridgeIngredient entityFridgeIngredient,
      {String key = ""}) async {
    await _collectionReference
        .doc(key)
        .collection(_collection)
        .doc(entityFridgeIngredient.name)
        .update(entityFridgeIngredient.toMap());
  }
}
