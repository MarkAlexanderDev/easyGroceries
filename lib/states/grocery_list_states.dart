import 'package:foodz/services/database/api.dart';
import 'package:foodz/services/database/entities/grocery_list/entity_grocery_list.dart';
import 'package:foodz/services/database/entities/grocery_list/entity_grocery_list_account.dart';
import 'package:foodz/services/database/entities/grocery_list/entity_grocery_list_ingredient.dart';
import 'package:get/get.dart';

class GroceryListStates extends GetxController {
  EntityGroceryList groceryList;
  RxList<EntityGroceryList> groceryListOwned = <EntityGroceryList>[].obs;
  List<EntityGroceryListAccount> groceryListAcounts = [];
  List<EntityGroceryListIngredient> groceryListIngredients = [];

  // CRUD

  Future<void> createGroceryList() async {
    groceryList.uid = await API.entries.groceryList.create(groceryList);
  }

  Future<void> readGroceryList(String groceryListId) async {
    groceryList = await API.entries.groceryList.read(groceryListId);
  }

  void updateGroceryList() async {
    API.entries.groceryList.update("", groceryList);
  }

  void deleteGroceryList(String uid) {
    API.entries.groceryList.delete(uid);
  }

  // CRUD GroceryListAccounts

  Future<void> createGroceryListAccount(String accountId) async {
    await API.entries.groceryList.accounts
        .create(EntityGroceryListAccount(uid: accountId), key: groceryList.uid);
  }

  Future<List<EntityGroceryListAccount>> readAllGroceryListAccounts(
      String groceryListUid) async {
    return await API.entries.groceryList.accounts.readAll(key: groceryListUid);
  }

  Future<bool> readAllAccountGroceryLists(List<String> groceryListIds) async {
    await Future.forEach(groceryListIds, (String groceryListId) async {
      groceryListOwned.add(await API.entries.groceryList.read(groceryListId));
    });
    return true;
  }

  void deleteGroceryListAccount(String accountId) {
    API.entries.groceryList.accounts.delete(accountId, key: groceryList.uid);
  }

  // CRUD GroceryListIngredients

  Future<void> createGroceryListIngredient(
      EntityGroceryListIngredient groceryListIngredient) async {
    await API.entries.groceryList.ingredients
        .create(groceryListIngredient, key: groceryList.uid);
  }

  void updateGroceryListIngredient(
      EntityGroceryListIngredient ingredient) async {
    API.entries.groceryList.ingredients
        .update("", ingredient, key: groceryList.uid);
  }

  void deleteGroceryListIngredient(String ingredientName) {
    API.entries.groceryList.ingredients
        .delete(ingredientName, key: groceryList.uid);
  }
}
