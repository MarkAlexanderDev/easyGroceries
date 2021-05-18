import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodz/services/database/entities/recipe/entity_recipe.dart';
import 'package:foodz/services/database/services/recipes/service_recipe_comments.dart';
import 'package:foodz/services/database/services/recipes/service_recipe_ingredients.dart';
import 'package:foodz/services/database/services/recipes/service_recipe_steps.dart';

import '../../config.dart';
import '../i_service.dart';

class ServiceRecipes extends IService<EntityRecipe> {
  final CollectionReference _collectionReference =
  FirebaseFirestore.instance.collection(endpointRecipe);

  final ServiceRecipeComments comments = ServiceRecipeComments();
  final ServiceRecipeIngredients ingredients = ServiceRecipeIngredients();
  final ServiceRecipeSteps steps = ServiceRecipeSteps();

  @override
  Future<DocumentReference> create(EntityRecipe entity, {String key = ""}) async {
    return await _collectionReference.add(entity.toMap());
  }

  @override
  Future<EntityRecipe> read(String id, {String key = ""}) async {
    final DocumentSnapshot snap = await _collectionReference.doc(id).get();
    if (snap != null)
      return EntityRecipe.fromJson(snap.data(), key: snap.id);
    return null;
  }

  @override
  Future<void> delete(String id, {String key = ""}) async {
    await _collectionReference.doc(id).delete();
  }

  @override
  Future<List<EntityRecipe>> readAll({String key = ""}) async {
    QuerySnapshot snap = await _collectionReference.get();
    List<EntityRecipe> entities = <EntityRecipe>[];
    snap.docs.forEach((element) {
      entities.add(EntityRecipe.fromJson(element.data(), key: element.id));
    });
    return entities;
  }

  @override
  Future<void> update(String id, EntityRecipe entity, {String key = ""}) async {
    await _collectionReference.doc(id).update(entity.toMap());
  }

}
