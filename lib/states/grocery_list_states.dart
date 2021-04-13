import 'package:foodz/services/auth.dart';
import 'package:foodz/services/database/api.dart';
import 'package:foodz/services/database/entities/grocery_list/entity_grocery_list.dart';
import 'package:foodz/services/database/entities/grocery_list/entity_grocery_list_account.dart';
import 'package:foodz/services/database/entities/grocery_list/entity_grocery_list_ingredient.dart';
import 'package:foodz/services/database/entities/ingredient/entity_ingredient.dart';
import 'package:get/get.dart';

class GroceryListStates extends GetxController {
  EntityGroceryList groceryList; // TO RM
  List<EntityGroceryList> groceryListOwned = [];
  List<EntityGroceryListAccount> groceryListAcounts = [];
  List<EntityGroceryListIngredient> groceryListIngredients = [];

  // CRUD

  Future<void> createGroceryList() async {
    groceryList.uid = await API.entries.groceryList.create(groceryList);
    groceryListOwned.add(groceryList);
  }

  Future<void> readGroceryList(String groceryListId) async {
    groceryList = await API.entries.groceryList.read(groceryListId);
  }

  void updateGroceryList() async {
    API.entries.groceryList
        .update(authService.auth.currentUser.uid, groceryList);
  }

  void deleteGroceryList(String uid) {
    API.entries.groceryList.delete(uid);
  }

  // CRUD GroceryListAccounts

  Future<void> createGroceryListAccount(String accountId) async {
    await API.entries.groceryList.accounts
        .create(EntityGroceryListAccount(uid: accountId), key: groceryList.uid);
  }

  Future<bool> readAllGroceryListAccounts() async {
    groceryListAcounts.assignAll(
        await API.entries.groceryList.accounts.readAll(key: groceryList.uid));
    return true;
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

  Future<void> createGroceryListIngredient(EntityIngredient ingredient) async {
    final EntityGroceryListIngredient groceryListIngredient =
        EntityGroceryListIngredient(
            pictureUrl: ingredient.pictureUrl,
            name: ingredient.title,
            category: ingredient.category,
            metric: ingredient.metric);
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
