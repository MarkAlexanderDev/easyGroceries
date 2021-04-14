import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodz/services/database/config.dart';

import '../i_service.dart';

class ServiceAllergies extends IService<String> {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection(endpointAllergies);

  @override
  Future<void> create(String entity, {String key = ""}) {
    return null;
  }

  @override
  Future<String> read(String id, {String key = ""}) async {
    return null;
  }

  @override
  Future<void> delete(String id, {String key = ""}) {
    return null;
  }

  @override
  Future<List<String>> readAll({String key = ""}) async {
    QuerySnapshot querySnapshot = await _collectionReference.get();
    return querySnapshot.docs.map((e) => e.id).toList();
  }

  @override
  Future<void> update(String id, String entity, {String key = ""}) {
    return null;
  }
}
