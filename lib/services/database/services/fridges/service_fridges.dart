import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodz/services/database/config.dart';
import 'package:foodz/services/database/entities/fridge/entity_fridge.dart';
import 'package:foodz/services/database/services/fridges/service_fridge_accounts.dart';
import 'package:foodz/services/database/services/fridges/service_fridge_ingredients.dart';
import 'package:foodz/services/database/services/i_service.dart';

class ServiceFridges extends IService<EntityFridge> {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection(endpointFridges);

  final ServiceFridgeAccounts accounts = ServiceFridgeAccounts();
  final ServiceFridgeIngredients ingredients = ServiceFridgeIngredients();

  @override
  Future<String> create(EntityFridge entity, {String key = ""}) async {
    DocumentReference docRef = await _collectionReference.add(entity.toMap());
    return docRef.id;
  }

  @override
  Future<void> delete(String uid, {String key = ""}) async {
    await _collectionReference.doc(uid).delete();
  }

  @override
  Future<EntityFridge> read(String uid, {String key = ""}) async {
    final DocumentSnapshot snap = await _collectionReference.doc(uid).get();
    if (snap != null) return EntityFridge.fromJson(snap.data(), key: snap.id);
    return null;
  }

  @override
  Future<List<EntityFridge>> readAll({String key = ""}) async {
    QuerySnapshot snap = await _collectionReference.get();
    List<EntityFridge> entities = <EntityFridge>[];
    snap.docs.forEach((element) {
      entities.add(EntityFridge.fromJson(element.data(), key: element.id));
    });
    return entities;
  }

  @override
  Future<void> update(String uid, EntityFridge entityFridge,
      {String key = ""}) async {
    await _collectionReference
        .doc(entityFridge.uid)
        .update(entityFridge.toMap());
  }
}
