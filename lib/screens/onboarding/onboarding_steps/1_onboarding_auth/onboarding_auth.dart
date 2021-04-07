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
import 'package:get/get.dart';

class OnboardingAuth extends StatelessWidget {
  final AccountStates accountStates = Get.put(AccountStates());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton(
        onPressed: () async {
          await _signIn(await authService.googleSignIn());
        },
        child: AutoSizeText("Google Sign in"),
      ),
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
