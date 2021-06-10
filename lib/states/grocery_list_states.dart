import 'package:foodz/services/database/api.dart';
import 'package:foodz/services/database/entities/account/entity_account.dart';
import 'package:foodz/services/database/entities/grocery_list/entity_grocery_list.dart';
import 'package:foodz/services/database/entities/grocery_list/entity_grocery_list_account.dart';
import 'package:foodz/services/database/entities/grocery_list/entity_grocery_list_ingredient.dart';
import 'package:get/get.dart';

class GroceryListStates extends GetxController {
  EntityGroceryList groceryList;
  RxList<EntityGroceryList> groceryListOwned = <EntityGroceryList>[].obs;
  List<EntityGroceryListIngredient> groceryListIngredients = [];
  List<EntityGroceryListAccount> groceryListAccounts = [];
  List<EntityAccount> accounts = [];

  // CRUD

  Future<void> createGroceryList() async {
    groceryList.uid = await API.entries.groceryList.create(groceryList);
  }

  Future<void> readGroceryList(String groceryListId) async {
    groceryList = await API.entries.groceryList.read(groceryListId);
  }

  Future<void> updateGroceryList() async {
    await API.entries.groceryList.update("", groceryList);
  }

  Future<void> deleteGroceryList(String uid) async {
    await API.entries.groceryList.delete(uid);
  }

  // CRUD GroceryListAccounts

  Future<void> createGroceryListAccount(String accountId, bool isOwner) async {
    await API.entries.groceryList.accounts.create(
        EntityGroceryListAccount(uid: accountId, owner: isOwner),
        key: groceryList.uid);
  }

  Future<bool> readAllGroceryListAccounts(String groceryListUid) async {
    accounts.clear();
    groceryListAccounts.clear();
    groceryListAccounts =
        await API.entries.groceryList.accounts.readAll(key: groceryListUid);
    await Future.forEach(groceryListAccounts, (groceryListAccount) async {
      accounts.add(await API.entries.accounts.read(groceryListAccount.uid));
    });
    return true;
  }

  Future<bool> readAllAccountGroceryLists(List<String> groceryListIds) async {
    await Future.forEach(groceryListIds, (String groceryListId) async {
      groceryListOwned.add(await API.entries.groceryList.read(groceryListId));
    });
    return true;
  }

  Future<void> deleteGroceryListAccount(String accountId) async {
    await API.entries.groceryList.accounts
        .delete(accountId, key: groceryList.uid);
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
