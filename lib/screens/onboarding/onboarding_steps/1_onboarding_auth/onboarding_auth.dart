import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/screens/onboarding/onboarding.dart';
import 'package:foodz/services/auth.dart';
import 'package:foodz/services/local_storage/consts.dart';
import 'package:foodz/services/local_storage/local_storage.dart';
import 'package:foodz/states/account_states.dart';
import 'package:foodz/states/app_states.dart';
import 'package:foodz/style/text_style.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OnboardingAuth extends StatelessWidget {
  final AccountStates accountStates = Get.put(AccountStates());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          "assets/images/foodz_full_logo.png",
          fit: BoxFit.cover,
          height: 75,
        ),
        Expanded(
          child: Lottie.asset('assets/lotties/cooking.json',
              height: 200, width: 200),
        ),
        AutoSizeText(
          "Your best friend app for fast and healthy groceries and cooking",
          style: textFredokaOneH1,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 50),
        OutlinedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)))),
              backgroundColor: MaterialStateProperty.all(Colors.white)),
          onPressed: () async {
            await _signIn(await authService.googleSignIn());
          },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 25,
                  child: Image.asset(
                    "assets/images/google_logo.png",
                  ),
                ),
                AutoSizeText(
                  "Sign in with google",
                  style: textAssistantH1Black,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _signIn(User firebaseUser) async {
    if (firebaseUser == null)
      Get.snackbar("Error", "something went wrong");
    else {
      appStates.setLoading(true);
      if (await accountStates.doesAccountExists(firebaseUser.uid)) {
        await accountStates.readAccount(firebaseUser.uid);
        if (accountStates.account.onboardingFlag.value ==
            ONBOARDING_STEP_ID_AUTH) {
          accountStates.account.onboardingFlag.value =
              ONBOARDING_STEP_ID_ALLERGIC;
        }
        accountStates.updateAccount();
      } else {
        accountStates.account.uid = authService.auth.currentUser.uid;
        accountStates.account.name.value = firebaseUser.displayName;
        accountStates.account.pictureUrl.value = firebaseUser.photoURL;
        accountStates.account.onboardingFlag.value =
            ONBOARDING_STEP_ID_ALLERGIC;
        accountStates.account.cookingExperience.value =
            COOKING_EXPERIENCE_ID_BEGINNER;
        accountStates.account.createdAt = DateTime.now().toUtc().toString();
        accountStates.account.isPremium = false;
        await accountStates.createAccount();
      }
      localStorage.setStringData(
          SHARED_PREF_KEY_ACCOUNT_ID, accountStates.account.uid);
      appStates.setLoading(false);
    }
  }
}
