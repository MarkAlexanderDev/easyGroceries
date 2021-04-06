import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodz/services/database/config.dart';
import 'package:foodz/services/database/entities/account/entity_account.dart';
import 'package:foodz/services/database/services/i_service.dart';

class ServiceAccounts extends IService<EntityAccount> {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection(endpointAccounts);

  @override
  Future<void> create(EntityAccount entity, {String key = ""}) async {
    await _collectionReference.doc(entity.uid).set(entity.toMap());
  }

  @override
  Future<void> delete(String uid, {String key = ""}) async {
    await _collectionReference.doc(uid).delete();
  }

  @override
  Future<EntityAccount> read(String uid, {String key = ""}) async {
    final DocumentSnapshot snap = await _collectionReference.doc(uid).get();
    if (snap != null) return EntityAccount.fromJson(snap.data(), key: snap.id);
    return null;
  }

  @override
  Future<List<EntityAccount>> readAll({String key = ""}) async {
    QuerySnapshot snap = await _collectionReference.get();

    List<EntityAccount> entities = <EntityAccount>[];
    snap.docs.forEach((element) {
      entities.add(EntityAccount.fromJson(element.data(), key: element.id));
    });
    return entities;
  }

  @override
  Future<void> update(String uid, EntityAccount entityAccount,
      {String key = ""}) async {
    await _collectionReference.doc(uid).update(entityAccount.toMap());
  }

  Future<bool> isExist(uid) async {
    final DocumentSnapshot snap = await _collectionReference.doc(uid).get();

    if (snap.data() == null) return false;
    return true;
  }
}
