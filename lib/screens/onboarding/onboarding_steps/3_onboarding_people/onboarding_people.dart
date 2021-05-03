import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/screens/onboarding/onboarding.dart';
import 'package:foodz/states/account_states.dart';
import 'package:foodz/states/app_states.dart';
import 'package:foodz/style/text_style.dart';
import 'package:foodz/widgets/people_selector.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OnboardingPeople extends StatelessWidget {
  final AccountStates accountStates = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset('assets/lotties/layer.json', height: 350),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: AutoSizeText(
            "How many people are you living with ?",
            style: textAssistantH1Black,
            textAlign: TextAlign.center,
          ),
        ),
        Container(
            padding: EdgeInsets.all(24.0),
            child: Obx(() => PeopleSelector(
                  peopleNumber: accountStates.account.peopleNb.value,
                  onTap: (int index) {
                    accountStates.account.peopleNb.value = index + 1;
                  },
                ))),
        Expanded(child: Container(), flex: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
                flex: 1,
                child: Center(
                  child: GestureDetector(
                    onTap: () async {
                      await _skipOnboarding();
                    },
                    child: AutoSizeText(
                      "Skip",
                      style: textAssistantH1GreenHalfOpacity,
                    ),
                  ),
                )),
            Flexible(child: Container(), flex: 1),
            Flexible(
                flex: 1,
                child: Center(
                  child: GestureDetector(
                    onTap: () async {
                      await _nextOnboardingStep();
                    },
                    child: AutoSizeText(
                      "Next",
                      style: textAssistantH1Green,
                    ),
                  ),
                )),
          ],
        ),
        Expanded(child: Container()),
      ],
    );
  }

  _nextOnboardingStep() async {
    appStates.setLoading(true);
    accountStates.account.onboardingFlag.value =
        accountStates.account.onboardingFlag.value + 1;
    accountStates.updateAccount();
    appStates.setLoading(false);
  }

  _skipOnboarding() async {
    appStates.setLoading(true);
    accountStates.setOnboardingFlag(ONBOARDING_STEP_ID_PROFILE);
    accountStates.updateAccount();
    appStates.setLoading(false);
  }
}