import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/screens/fridge/fridge.dart';
import 'package:foodz/screens/grocery_lists/grocery_lists.dart';
import 'package:foodz/screens/onboarding/onboarding.dart';
import 'package:foodz/screens/recipes/recipes.dart';
import 'package:foodz/services/database/entities/account/entity_account.dart';
import 'package:foodz/states/account_states.dart';
import 'package:foodz/states/app_states.dart';
import 'package:foodz/style/text_style.dart';
import 'package:foodz/urls.dart';
import 'package:foodz/widgets_common/bottom_navigation_bar.dart';
import 'package:foodz/widgets_common/profile_picture.dart';
import 'package:foodz/widgets_default/loading.dart';
import 'package:get/get.dart';

class Redirections extends StatefulWidget {
  @override
  _Redirections createState() => _Redirections();
}

class _Redirections extends State<Redirections> {
  final AccountStates accountStates = Get.find();
  Future<bool> futureLoader;

  @override
  void initState() {
    futureLoader = appStates.initApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureLoader,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData)
            return Obx(
                () => _getPage(accountStates.account, appStates.loading.value));
          else
            return Container(color: Colors.white, child: FoodzLoading());
        });
  }

  _getPage(EntityAccount account, bool loading) {
    List appScreens = [GroceryLists(), Fridge(), Recipes()];
    if (loading)
      return Container(color: Colors.white, child: FoodzLoading());
    else if (account == null ||
        account.onboardingFlag.value < ONBOARDING_STEP_ID_PROFILE + 1)
      return Onboarding();
    else
      return Scaffold(
          appBar: _getFoodzAppBar(),
          body: Obx(() => appScreens[appStates.indexBar.value]),
          bottomNavigationBar: NavBar(sizeIcon: 25.0));
  }

  _getFoodzAppBar() {
    return AppBar(
        leading: Container(),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          Expanded(
            child: Row(
              children: [
                Container(width: 20),
                AutoSizeText(
                  "Hey " +
                      accountStates.account.name.value.split(" ").first +
                      " ! 👋",
                  style: textFredokaOneH1,
                  textAlign: TextAlign.center,
                ),
                Expanded(child: Container()),
                GestureDetector(
                  onTap: () => Get.toNamed(URL_PROFILE),
                  child: FoodzProfilePicture(
                    height: 50,
                    width: 50,
                    pictureUrl: accountStates.account.pictureUrl.value,
                    editMode: false,
                  ),
                ),
                Container(width: 20),
              ],
            ),
          )
        ]);
  }
}
