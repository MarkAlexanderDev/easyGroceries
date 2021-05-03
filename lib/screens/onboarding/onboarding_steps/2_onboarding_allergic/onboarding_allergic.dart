import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/screens/onboarding/onboarding.dart';
import 'package:foodz/states/account_states.dart';
import 'package:foodz/states/allergies_states.dart';
import 'package:foodz/states/app_states.dart';
import 'package:foodz/style/text_style.dart';
import 'package:foodz/widgets/loading.dart';
import 'package:foodz/widgets/selectable_tags.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OnboardingAllergic extends StatefulWidget {
  @override
  _OnboardingAllergic createState() => _OnboardingAllergic();
}

class _OnboardingAllergic extends State<OnboardingAllergic> {
  final AccountStates accountStates = Get.find();
  final AllergiesStates allergiesStates = Get.put(AllergiesStates());
  Future allergiesFuture;

  @override
  void initState() {
    allergiesFuture = allergiesStates.readAllAllergies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: allergiesFuture,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Lottie.asset('assets/lotties/vr-sickness.json'),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: AutoSizeText(
                    "Do you have specific food that you do not eat or you are allergic of ?",
                    style: textAssistantH1Black,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(24.0),
                  child: SelectableTags(
                    activeTags: accountStates.account.allergies,
                    tags: allergiesStates.allergies,
                    onClickTag: (String tag) {
                      if (accountStates.account.allergies.contains(tag))
                        accountStates.account.allergies.remove(tag);
                      else
                        accountStates.account.allergies.add(tag);
                    },
                  ),
                ),
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
          } else
            return Loading();
        });
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
