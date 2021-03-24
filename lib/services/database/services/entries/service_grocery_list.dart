import 'package:EasyGroceries/services/database/consts.dart';
import 'package:EasyGroceries/services/database/entities/entries/entity_grocery_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceGroceryList {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection(endpointGroceryLists);

  Future<void> create(EntityGroceryList entityGroceryList) async {
    await _collectionReference
        .doc(entityGroceryList.id)
        .set(entityGroceryList.toMap());
  }

  Future<EntityGroceryList> read(String uid) async {
    final DocumentSnapshot snapGroceryList =
        await _collectionReference.doc(uid).get();
    final DocumentSnapshot snapGroceryList =
        await _collectionReference.doc(uid).collection("Accounts").get();

    return EntityGroceryList.fromJson(snap.data(), list, uid);
  }

  Future<void> update(EntityGroceryList entityGroceryList) async {
    await _collectionReference
        .doc(entityGroceryList.id)
        .update(entityGroceryList.toMap());
  }

  Future<void> delete(String uid) async {
    await _collectionReference.doc(uid).delete();
  }
}
