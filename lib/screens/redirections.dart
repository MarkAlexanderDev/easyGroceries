import 'package:foodz/screens/home/home.dart';
import 'package:foodz/screens/onboarding/onboarding.dart';
import 'package:foodz/screens/recipes/recipes.dart';
import 'package:foodz/services/database/models/account_model.dart';
import 'package:foodz/states/account_states.dart';
import 'package:foodz/states/app_states.dart';
import 'package:foodz/style/text_style.dart';
import 'package:foodz/urls.dart';
import 'package:foodz/widgets/bottom_navigation_bar.dart';
import 'package:foodz/widgets/loading.dart';
import 'package:foodz/widgets/profile_picture.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Redirections extends StatefulWidget {
  @override
  _Redirections createState() => _Redirections();
}

class _Redirections extends State<Redirections> {
  final AccountStates accountStates = Get.put(AccountStates());
  Future<bool> _future;

  Future<bool> loader() async {
    await appStates.initApp();
    await accountStates.getAccount();
    return true;
  }

  @override
  void initState() {
    _future = loader();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData)
            return Obx(() =>
                _getPage(accountStates.account.value, appStates.loading.value));
          else
            return Container(color: Colors.white, child: Loading());
        });
  }

  _getPage(AccountModel user, bool loading) {
    final List appScreens = [Home(), Recipes()];
    if (loading)
      return Container(color: Colors.white, child: Loading());
    else if (user == null ||
        user.onboardingFlag < ONBOARDING_STEP_ID_PROFILE + 1)
      return Onboarding();
    else
      return Scaffold(
          body: appScreens[appStates.indexBar.value],
          appBar: _getFoodzAppBar(),
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
                  "Hey " + accountStates.account.value.name + "! ✌️",
                  style: textStyleH1,
                  textAlign: TextAlign.center,
                ),
                Expanded(child: Container()),
                GestureDetector(
                  onTap: () => Get.toNamed(URL_PROFILE),
                  child: ProfilePicture(
                    name: null,
                    height: 50,
                    width: 50,
                    pictureUrl: accountStates.account.value.pictureUrl,
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
