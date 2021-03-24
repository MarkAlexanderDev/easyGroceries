import 'package:EasyGroceries/services/database/consts.dart';
import 'package:EasyGroceries/services/database/entities/entries/entity_account.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceAccount {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection(endpointAccounts);

  Future<void> create(EntityAccount entityAccount) async {
    await _collectionReference.doc(entityAccount.id).set(entityAccount.toMap());
  }

  Future<EntityAccount> read(String uid) async {
    final DocumentSnapshot snap = await _collectionReference.doc(uid).get();
    return EntityAccount.fromJson(snap.data(), uid);
  }

  Future<void> update(EntityAccount entityAccount) async {
    await _collectionReference
        .doc(entityAccount.id)
        .update(entityAccount.toMap());
  }

  Future<void> delete(String uid) async {
    await _collectionReference.doc(uid).delete();
  }
}
