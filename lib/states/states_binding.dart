import 'package:foodz/states/account_states.dart';
import 'package:foodz/states/grocery_list_states.dart';
import 'package:get/get.dart';

class StatesBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AccountStates>(AccountStates(), permanent: true);
    Get.put<GroceryListStates>(GroceryListStates(), permanent: true);
  }
}
