import 'package:foodz/screens/consts.dart';
import 'package:foodz/screens/onboarding/onboarding.dart';
import 'package:foodz/services/auth.dart';
import 'package:foodz/services/database/models/account_model.dart';
import 'package:foodz/states/account_states.dart';
import 'package:foodz/states/app_states.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      if (await accountStates.doesAccountExist()) {
        await accountStates.getAccount();
        if (accountStates.account.value.onboardingFlag ==
            ONBOARDING_STEP_ID_AUTH) {
          accountStates.account.value.onboardingFlag =
              ONBOARDING_STEP_ID_ALLERGIC;
        }
        await accountStates.updateAccount();
      } else {
        AccountModel account = AccountModel();
        account.uid = FirebaseAuth.instance.currentUser.uid;
        account.name = firebaseUser.displayName;
        account.pictureUrl = firebaseUser.photoURL;
        account.onboardingFlag = ONBOARDING_STEP_ID_ALLERGIC;
        account.peopleNumber = 2;
        account.cookingExperience = COOKING_EXPERIENCE_ID_BEGINNER;
        account.createdAt = DateTime.now().toUtc().toString();
        await accountStates.createAccount(account);
      }
      appStates.setLoading(false);
    }
  }
}
