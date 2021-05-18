import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodz/services/database/config.dart';
import 'package:foodz/services/database/entities/fridge/entity_fridge_account.dart';
import 'package:foodz/services/database/services/i_service.dart';

class ServiceFridgeAccounts extends IService<EntityFridgeAccount> {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection(endpointFridges);

  final String _collection = "Accounts/";

  @override
  Future<void> create(EntityFridgeAccount entity, {String key = ""}) async {
    await _collectionReference
        .doc(key)
        .collection(_collection)
        .doc(entity.uid)
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
  Future<EntityFridgeAccount> read(String uid, {String key = ""}) async {
    DocumentSnapshot doc = await _collectionReference
        .doc(key)
        .collection(_collection)
        .doc(uid)
        .get();
    if (doc.exists) return EntityFridgeAccount.fromJson(doc.data(), key: key);
    return null;
  }

  @override
  Future<List<EntityFridgeAccount>> readAll({String key = ""}) async {
    QuerySnapshot snap =
        await _collectionReference.doc(key).collection(_collection).get();
    return snap.docs
        .map((e) => EntityFridgeAccount.fromJson(e.data(), key: e.id))
        .toList();
  }

  @override
  Future<void> update(String uid, EntityFridgeAccount entityFridgeAccount,
      {String key = ""}) async {}
}
