import 'package:foodz/states/account_states.dart';
import 'package:foodz/states/allergies_states.dart';
import 'package:foodz/states/cuisines_states.dart';
import 'package:foodz/states/fridge_states.dart';
import 'package:foodz/states/grocery_list_states.dart';
import 'package:foodz/states/ingredient_states.dart';
import 'package:get/get.dart';

class StatesBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AccountStates>(AccountStates(), permanent: true);
    Get.put<GroceryListStates>(GroceryListStates(), permanent: true);
    Get.put<FridgeStates>(FridgeStates(), permanent: true);
    Get.put<IngredientStates>(IngredientStates(), permanent: true);
    Get.put<AllergiesStates>(AllergiesStates(), permanent: true);
    Get.put<CuisinesStates>(CuisinesStates(), permanent: true);
  }
}
