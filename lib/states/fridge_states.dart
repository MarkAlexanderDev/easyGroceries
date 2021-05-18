import 'package:foodz/services/database/api.dart';
import 'package:foodz/services/database/entities/fridge/entity_fridge.dart';
import 'package:foodz/services/database/entities/fridge/entity_fridge_account.dart';
import 'package:foodz/services/database/entities/fridge/entity_fridge_ingredient.dart';
import 'package:get/get.dart';

class FridgeStates extends GetxController {
  EntityFridge fridge;
  RxList<EntityFridge> fridgeOwned = <EntityFridge>[].obs;
  List<EntityFridgeAccount> fridgeAcounts = [];
  List<EntityFridgeIngredient> fridgeIngredients = [];

  // CRUD

  Future<void> createFridge() async {
    fridge.uid = await API.entries.fridge.create(fridge);
    fridgeOwned.add(fridge);
  }

  Future<void> readFridge(String fridgeId) async {
    fridge = await API.entries.fridge.read(fridgeId);
  }

  void updateFridge() async {
    API.entries.fridge.update("", fridge);
  }

  void deleteFridge(String uid) {
    API.entries.fridge.delete(uid);
  }

  // CRUD FridgeAccounts

  Future<void> createFridgeAccount(String accountId) async {
    await API.entries.fridge.accounts
        .create(EntityFridgeAccount(uid: accountId), key: fridge.uid);
  }

  Future<List<EntityFridgeAccount>> readAllFridgeAccounts(
      String fridgeUid) async {
    return await API.entries.fridge.accounts.readAll(key: fridgeUid);
  }

  Future<bool> readAllAccountFridges(List<String> fridgeIds) async {
    await Future.forEach(fridgeIds, (String fridgeId) async {
      fridgeOwned.add(await API.entries.fridge.read(fridgeId));
    });
    fridge = fridgeOwned.first;
    return true;
  }

  void deleteFridgeAccount(String accountId) {
    API.entries.fridge.accounts.delete(accountId, key: fridge.uid);
  }

  // CRUD GroceryListIngredients

  Future<void> createFridgeIngredient(
      EntityFridgeIngredient fridgeIngredient) async {
    await API.entries.fridge.ingredients
        .create(fridgeIngredient, key: fridge.uid);
  }

  void updateFridgeIngredient(EntityFridgeIngredient ingredient) async {
    API.entries.fridge.ingredients.update("", ingredient, key: fridge.uid);
  }

  void deleteFridgeIngredient(String ingredientName) {
    API.entries.fridge.ingredients.delete(ingredientName, key: fridge.uid);
  }
}
