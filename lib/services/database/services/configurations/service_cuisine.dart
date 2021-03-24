import 'package:EasyGroceries/services/database/consts.dart';
import 'package:EasyGroceries/services/database/entities/configurations/entity_cuisine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceCuisine {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection(endpointCuisines);

  Future<EntityCuisine> read(String cuisineName) async {
    final DocumentSnapshot snap =
        await _collectionReference.doc(cuisineName).get();
    return EntityCuisine.fromJson(snap.data(), cuisineName);
  }

  Future<List<EntityCuisine>> readAll() async {
    final DocumentSnapshot snap = await _collectionReference.doc().get();
    final List<EntityCuisine> entityCuisineList = List<EntityCuisine>();
    snap.data().forEach((key, value) {
      entityCuisineList.add(EntityCuisine.fromJson(value, key));
    });
    return entityCuisineList;
  }
}
