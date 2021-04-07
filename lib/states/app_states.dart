import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodz/services/dynamic_link.dart';
import 'package:foodz/services/local_storage/consts.dart';
import 'package:foodz/services/local_storage/local_storage.dart';
import 'package:foodz/states/account_states.dart';
import 'package:foodz/states/grocery_list_states.dart';
import 'package:foodz/widgets/bottom_navigation_bar.dart';
import 'package:get/get.dart';

class AppStates extends GetxController {
  static AppStates get to => Get.find();

  final AccountStates _accountStates = Get.put(AccountStates());
  final GroceryListStates _groceryListStates = Get.put(GroceryListStates());

  Future<void> initApp() async {
    await dynamicLink.handleDynamicLinks();
    await localStorage.init();
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
    if (accountId.isNotEmpty) {
      await _accountStates.readAccount(accountId);
      await _groceryListStates
          .readAllAccountGroceryLists(_accountStates.account.groceryListIds);
      loaded = true;
    }
  }

  void setIndexBar(int value) {
    indexBar.value = value;
  }

  void setLoading(bool value) {
    loading.value = value;
  }

  RxInt indexBar = HOME_SCREEN_ID.obs;
  RxBool loading = false.obs;
  RxBool uploadingProfilePicture = false.obs;
  bool loaded = false;
}

final AppStates appStates = Get.put(AppStates());
