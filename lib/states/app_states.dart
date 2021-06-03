import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodz/services/assets_loader.dart';
import 'package:foodz/services/local_storage/consts.dart';
import 'package:foodz/services/local_storage/local_storage.dart';
import 'package:foodz/states/account_states.dart';
import 'package:foodz/states/fridge_states.dart';
import 'package:foodz/states/grocery_list_states.dart';
import 'package:foodz/states/recipe_states.dart';
import 'package:foodz/widgets_common/bottom_navigation_bar.dart';
import 'package:get/get.dart';

class AppStates extends GetxController {
  static AppStates get to => Get.find();

  final AccountStates _accountStates = Get.find();
  final GroceryListStates _groceryListStates = Get.find();
  final FridgeStates _fridgeStates = Get.find();
  final RecipeStates _recipeStates = Get.find();

  Future<bool> initApp() async {
    if (!loaded) {
      await localStorage.init();
      await assetsLoader.loadSVGs();
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        systemNavigationBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      );
      final String accountId =
          localStorage.getStringData(SHARED_PREF_KEY_ACCOUNT_ID);
      if (accountId.isNotEmpty) await loadUserData(accountId);
      loaded = true;
    }
    return true;
  }

  Future<void> loadUserData(String accountId) async {
    await _accountStates.readAccount(accountId);
    await _groceryListStates
        .readAllAccountGroceryLists(_accountStates.account.groceryListIds);
    await _fridgeStates.readAllAccountFridges(_accountStates.account.fridgeIds);
    await _recipeStates.readAllAccountRecipes(_accountStates.account.recipeIds);
  }

  void setLoading(bool value) {
    loading.value = value;
  }

  RxInt indexBar = HOME_SCREEN_ID.obs;
  RxInt recipeIndex = 0.obs;
  RxBool loading = false.obs;
  RxBool uploadingProfilePicture = false.obs;
  bool loaded = false;
}

final AppStates appStates = Get.put(AppStates());
