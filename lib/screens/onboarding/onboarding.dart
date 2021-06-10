import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/screens/onboarding/onboarding_steps/1_onboarding_auth/onboarding_auth.dart';
import 'package:foodz/screens/onboarding/onboarding_steps/2_onboarding_allergic/onboarding_allergic.dart';
import 'package:foodz/services/auth.dart';
import 'package:foodz/states/account_states.dart';
import 'package:foodz/states/app_states.dart';
import 'package:foodz/style/colors.dart';
import 'package:foodz/widgets_default/confirm_button.dart';
import 'package:get/get.dart';

import 'onboarding_steps/3_onboarding_people/onboarding_people.dart';
import 'onboarding_steps/4_onboarding_kitchen_tools/onboarding_kitchen_tools.dart';
import 'onboarding_steps/5_onboarding_cuisine/onboarding_cuisine.dart';
import 'onboarding_steps/6_onboarding_profile/onboarding_profile.dart';

const ONBOARDING_STEP_ID_AUTH = 0;
const ONBOARDING_STEP_ID_ALLERGIC = 1;
const ONBOARDING_STEP_ID_PEOPLE = 2;
const ONBOARDING_STEP_ID_KITCHEN_TOOLS = 3;
const ONBOARDING_STEP_ID_FAVORITE_CUISINE = 4;
const ONBOARDING_STEP_ID_PROFILE = 5;

class Onboarding extends StatelessWidget {
  final AccountStates accountStates = Get.put(AccountStates());
  final onboardingSteps = [
    OnboardingAuth(),
    OnboardingAllergic(),
    OnboardingPeople(),
    OnboardingKitchenTools(),
    OnboardingCuisine(),
    OnboardingProfile()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return (await _previousOnboardingStep());
        },
        child: Scaffold(
          backgroundColor: accountStates.account.onboardingFlag.value ==
                  ONBOARDING_STEP_ID_KITCHEN_TOOLS
              ? lightGrey
              : Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => _getStepper(
                  accountStates.account.onboardingFlag.value, context)),
              Expanded(
                child: Obx(() => onboardingSteps[
                    accountStates.account.onboardingFlag.value == null
                        ? 0
                        : accountStates.account.onboardingFlag.value]),
              ),
            ],
          ),
          bottomNavigationBar: Visibility(
              visible: accountStates.account.onboardingFlag.value >
                  ONBOARDING_STEP_ID_AUTH,
              child: Obx(
                () => FoodzConfirmButton(
                    label: accountStates.account.onboardingFlag.value !=
                            ONBOARDING_STEP_ID_PROFILE
                        ? "next"
                        : "Let's go!",
                    enabled: !appStates.uploadingProfilePicture.value,
                    onClick: () {
                      _nextOnboardingStep();
                    }),
              )),
        ));
  }

  _getStepper(int onboardingStep, BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      color: mainColor,
      height: 25,
      width: MediaQuery.of(context).size.width /
          onboardingSteps.length *
          (onboardingStep == null ? 0 : onboardingStep),
    );
  }

  _nextOnboardingStep() async {
    appStates.setLoading(true);
    accountStates.account.onboardingFlag.value =
        accountStates.account.onboardingFlag.value + 1;
    accountStates.updateAccount(FirebaseAuth.instance.currentUser.uid);
    appStates.setLoading(false);
  }

  Future<bool> _previousOnboardingStep() async {
    if (accountStates.account.onboardingFlag.value > 0) {
      appStates.setLoading(true);
      accountStates.account.onboardingFlag.value =
          accountStates.account.onboardingFlag.value - 1;
      accountStates.updateAccount(FirebaseAuth.instance.currentUser.uid);
      if (accountStates.account.onboardingFlag.value == ONBOARDING_STEP_ID_AUTH)
        await authService.signOut();
      appStates.setLoading(false);
      return false;
    }
    return true;
  }
}
