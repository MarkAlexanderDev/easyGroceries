import 'package:EasyGroceries/services/database/consts.dart';
import 'package:EasyGroceries/services/database/entities/configurations/entity_ingredient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceIngredient {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection(endpointIngredients);

  Future<EntityIngredient> read(String ingredientName) async {
    final DocumentSnapshot snap =
        await _collectionReference.doc(ingredientName).get();
    return EntityIngredient.fromJson(snap.data(), ingredientName);
  }

  Future<List<EntityIngredient>> readAll() async {
    final DocumentSnapshot snap = await _collectionReference.doc().get();
    final List<EntityIngredient> entityCuisineList = List<EntityIngredient>();
    snap.data().forEach((key, value) {
      entityCuisineList.add(EntityIngredient.fromJson(value, key));
    });
    return entityCuisineList;
  }
}
