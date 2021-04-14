import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodz/services/database/config.dart';
import 'package:foodz/services/database/entities/grocery_list/entity_grocery_list_account.dart';
import 'package:foodz/services/database/services/i_service.dart';

class ServiceGroceryListAccounts extends IService<EntityGroceryListAccount> {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection(endpointGroceryLists);

  final String _collection = "Accounts/";

  @override
  Future<void> create(EntityGroceryListAccount entity,
      {String key = ""}) async {
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
  Future<EntityGroceryListAccount> read(String uid, {String key = ""}) async {
    DocumentSnapshot doc = await _collectionReference
        .doc(key)
        .collection(_collection)
        .doc(uid)
        .get();
    if (doc.exists)
      return EntityGroceryListAccount.fromJson(doc.data(), key: key);
    return null;
  }

  @override
  Future<List<EntityGroceryListAccount>> readAll({String key = ""}) async {
    QuerySnapshot snap =
        await _collectionReference.doc(key).collection(_collection).get();
    return snap.docs
        .map((e) => EntityGroceryListAccount.fromJson(e.data(), key: e.id))
        .toList();
  }

  @override
  Future<void> update(
      String uid, EntityGroceryListAccount entityGroceryListAccount,
      {String key = ""}) async {}
}
