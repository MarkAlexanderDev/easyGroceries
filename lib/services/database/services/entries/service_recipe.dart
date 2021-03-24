import 'package:EasyGroceries/services/database/consts.dart';
import 'package:EasyGroceries/services/database/entities/entries/entity_recipe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceRecipe {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection(endpointRecipes);

  Future<void> create(EntityRecipe entityRecipe) async {
    await _collectionReference.doc(entityRecipe.uid).set(entityRecipe.toMap());
  }

  Future<EntityRecipe> read(String uid) async {
    final DocumentSnapshot snap = await _collectionReference.doc(uid).get();
    return EntityRecipe.fromJson(snap.data(), uid);
  }

  Future<void> update(EntityRecipe entityRecipe) async {
    await _collectionReference
        .doc(entityRecipe.id)
        .update(entityRecipe.toMap());
  }

  Future<void> delete(String uid) async {
    await _collectionReference.doc(uid).delete();
  }
}
