import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodz/services/auth.dart';
import 'package:foodz/services/dynamic_link.dart';
import 'package:foodz/services/local_storage/local_storage.dart';
import 'package:foodz/states/account_states.dart';
import 'package:foodz/widgets/bottom_navigation_bar.dart';
import 'package:get/get.dart';

class AppStates extends GetxController {
  static AppStates get to => Get.find();

  final AccountStates _accountStates = Get.put(AccountStates());

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
    print("test1");
    print(authService.auth.currentUser.uid);
    await _accountStates.readAccount(authService.auth.currentUser.uid);
    print("test2");
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
}

final AppStates appStates = Get.put(AppStates());
