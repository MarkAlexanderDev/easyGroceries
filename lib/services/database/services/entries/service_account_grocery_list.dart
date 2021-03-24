import 'package:EasyGroceries/services/database/consts.dart';
import 'package:EasyGroceries/services/database/entities/entries/entity_account_grocery_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceAccountGroceryList {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection(endpointGroceryLists);

  Future<void> create(EntityAccountGroceryList entityGroceryList) async {
    await _collectionReference
        .doc(entityGroceryList.accountId)
        .set(entityGroceryList.toMap());
  }

  Future<EntityAccountGroceryList> read(String accountId) async {
    final DocumentSnapshot snap =
        await _collectionReference.doc(accountId).get();
    return EntityAccountGroceryList.fromJson(snap.data(), accountId);
  }

  Future<void> update(EntityAccountGroceryList entityAccountGroceryList) async {
    await _collectionReference
        .doc(entityAccountGroceryList.accountId)
        .update(entityAccountGroceryList.toMap());
  }

  Future<void> delete(String uid) async {
    await _collectionReference.doc(uid).delete();
  }
}
