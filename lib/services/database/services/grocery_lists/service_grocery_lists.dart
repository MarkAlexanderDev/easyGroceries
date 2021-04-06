import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodz/services/database/config.dart';
import 'package:foodz/services/database/entities/grocery_list/entity_grocery_list.dart';
import 'package:foodz/services/database/services/i_service.dart';

class ServiceGroceryLists extends IService<EntityGroceryList> {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection(endpointGroceryLists);

  @override
  Future<void> create(EntityGroceryList entity, {String key = ""}) async {
    await _collectionReference.doc(entity.uid).set(entity.toMap());
  }

  @override
  Future<void> delete(String uid, {String key = ""}) async {
    await _collectionReference.doc(uid).delete();
  }

  @override
  Future<EntityGroceryList> read(String uid, {String key = ""}) async {
    final DocumentSnapshot snap = await _collectionReference.doc(uid).get();
    if (snap != null)
      return EntityGroceryList.fromJson(snap.data(), key: snap.id);
    return null;
  }

  @override
  Future<List<EntityGroceryList>> readAll({String key = ""}) async {
    QuerySnapshot snap = await _collectionReference.get();
    List<EntityGroceryList> entities = <EntityGroceryList>[];
    snap.docs.forEach((element) {
      entities.add(EntityGroceryList.fromJson(element.data(), key: element.id));
    });
    return entities;
  }

  @override
  Future<void> update(String uid, EntityGroceryList entityGroceryList,
      {String key = ""}) async {
    await _collectionReference.doc(uid).update(entityGroceryList.toMap());
  }

  Future<bool> isExist(uid) async {
    final DocumentSnapshot snap = await _collectionReference.doc(uid).get();

    if (snap.data() == null) return false;
    return true;
  }
}
