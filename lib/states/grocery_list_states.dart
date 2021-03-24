import 'package:EasyGroceries/services/database/consts.dart';
import 'package:EasyGroceries/services/database/database.dart';
import 'package:EasyGroceries/services/database/models/account_grocery_list_model.dart';
import 'package:EasyGroceries/services/database/models/grocery_list_ingredient_model.dart';
import 'package:EasyGroceries/services/database/models/grocery_list_model.dart';
import 'package:get/get.dart';

class GroceryListStates extends GetxController {
  static GroceryListStates get to => Get.find();

  Stream streamGroceryList() async* {
    databaseReference
        .child(endpointGroceryListIngredient)
        .child(groceryList.value.uid)
        .orderByChild("createdAt")
        .endAt(DateTime.now().toString())
        .onValue
        .listen((event) async {
      final Map snapshot = Map<String, dynamic>.from(event.snapshot.value);
      for (int i = 0; i < snapshot.length; i++) {
        final GroceryListIngredientModel groceryListModel =
            GroceryListIngredientModel();
        groceryListModel.fromJson(snapshot.entries.elementAt(i).value);
        if (groceryListIngredients.length <= i) {
          groceryListIngredientsKeys.add(snapshot.entries.elementAt(i).key);
          groceryListIngredients.add(groceryListModel);
        } else
          groceryListIngredients[i] = groceryListModel;
      }
    });
    yield true;
  }

  Future<void> createGroceryList() async {
    await Database.groceryList.create(groceryList.value);
    AccountGroceryListModel accountGroceryList = AccountGroceryListModel();
    accountGroceryList.groceryListUid = groceryList.value.uid;
    accountGroceryList.owner = true;
    await Database.accountGroceryList.create(accountGroceryList);
    GroceryListIngredientModel groceryListIngredient =
        GroceryListIngredientModel();
    groceryListIngredient.checked = false;
    groceryListIngredient.createdAt = DateTime.now().toString();
    await Database.groceryListIngredient
        .create("baguette", groceryListIngredient, groceryList.value.uid);
  }

  Future<void> updateGroceryList() async {
    await Database.groceryList.update(groceryList.value);
  }

  Future<void> addIngredient(String ingredient) async {
    if (!groceryListIngredientsKeys.contains(ingredient)) {
      GroceryListIngredientModel groceryListIngredient =
          GroceryListIngredientModel();
      groceryListIngredient.checked = false;
      groceryListIngredient.createdAt = DateTime.now().toString();
      groceryListIngredients.add(groceryListIngredient);
      groceryListIngredients.refresh();
      groceryListIngredientsKeys.add(ingredient);
      groceryListIngredientsKeys.refresh();
      await Database.groceryListIngredient
          .create(ingredient, groceryListIngredient, groceryList.value.uid);
    } else
      Get.snackbar("error", ingredient + " is already present in your list");
  }

  Future<void> deleteIngredient(int index) async {
    String ingredientToRm = groceryListIngredientsKeys[index];
    groceryListIngredients.removeAt(index);
    groceryListIngredients.refresh();
    groceryListIngredientsKeys.removeAt(index);
    groceryListIngredientsKeys.refresh();
    await Database.groceryListIngredient
        .delete(ingredientToRm, groceryList.value.uid);
  }

  Future<void> setIngredientCheckValue(bool value, int index) async {
    groceryListIngredients[index].checked = value;
    groceryListIngredients.refresh();
    await Database.groceryListIngredient.update(groceryListIngredients[index],
        groceryListIngredientsKeys[index], groceryList.value.uid);
  }

  Rx<GroceryListModel> groceryList = GroceryListModel().obs;
  RxList<String> groceryListIngredientsKeys = List<String>().obs;
  RxList<GroceryListIngredientModel> groceryListIngredients =
      List<GroceryListIngredientModel>().obs;
}
