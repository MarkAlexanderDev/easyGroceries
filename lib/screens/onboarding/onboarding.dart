import 'package:foodz/screens/onboarding/onboarding_steps/1_onboarding_auth/onboarding_auth.dart';
import 'package:foodz/screens/onboarding/onboarding_steps/2_onboarding_allergic/onboarding_allergic.dart';
import 'package:foodz/screens/onboarding/onboarding_steps/3_onboarding_cuisine/onboarding_cuisine.dart';
import 'package:foodz/screens/onboarding/onboarding_steps/4_onboarding_profile/onboarding_profile.dart';
import 'package:foodz/services/auth.dart';
import 'package:foodz/states/account_states.dart';
import 'package:foodz/states/app_states.dart';
import 'package:foodz/style/colors.dart';
import 'package:foodz/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const ONBOARDING_STEP_ID_AUTH = 0;
const ONBOARDING_STEP_ID_ALLERGIC = 1;
const ONBOARDING_STEP_ID_FAVORITE_CUISINE = 2;
const ONBOARDING_STEP_ID_PROFILE = 3;

class Onboarding extends StatelessWidget {
  final AccountStates accountStates = Get.put(AccountStates());
  final onboardingSteps = [
    OnboardingAuth(),
    OnboardingAllergic(),
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
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Obx(() => _getStepper(
                      accountStates.account.value.onboardingFlag, context))),
              Flexible(
                  fit: FlexFit.tight,
                  flex: 20,
                  child: Obx(() => onboardingSteps[
                      accountStates.account.value.onboardingFlag == null
                          ? 0
                          : accountStates.account.value.onboardingFlag])),
            ],
          ),
          bottomNavigationBar: Visibility(
              visible: accountStates.account.value.onboardingFlag ==
                  ONBOARDING_STEP_ID_PROFILE,
              child: Obx(
                () => ConfirmButton(
                    enabled: !appStates.uploadingProfilePicture.value,
                    onClick: () async {
                      appStates.setLoading(true);
                      accountStates.account.value.onboardingFlag =
                          accountStates.account.value.onboardingFlag + 1;
                      await accountStates.updateAccount();
                      appStates.setLoading(false);
                    }),
              ))),
    );
  }

  _getStepper(int onboardingStep, BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      color: mainColor,
      width: MediaQuery.of(context).size.width /
          onboardingSteps.length *
          (onboardingStep == null ? 0 : onboardingStep),
    );
  }

  Future<bool> _previousOnboardingStep() async {
    if (accountStates.account.value.onboardingFlag > 0) {
      appStates.setLoading(true);
      accountStates.account.value.onboardingFlag =
          accountStates.account.value.onboardingFlag - 1;
      await accountStates.updateAccount();
      if (accountStates.account.value.onboardingFlag == ONBOARDING_STEP_ID_AUTH)
        await authService.signOut();
      appStates.setLoading(false);
      return false;
    }
    return true;
  }
}
