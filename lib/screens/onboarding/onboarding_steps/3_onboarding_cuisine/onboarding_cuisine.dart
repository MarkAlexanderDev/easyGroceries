import 'package:foodz/screens/consts.dart';
import 'package:foodz/screens/onboarding/onboarding.dart';
import 'package:foodz/states/account_states.dart';
import 'package:foodz/states/app_states.dart';
import 'package:foodz/states/cuisine_states.dart';
import 'package:foodz/style/text_style.dart';
import 'package:foodz/widgets/loading.dart';
import 'package:foodz/widgets/selectable_tags.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OnboardingCuisine extends StatefulWidget {
  @override
  _OnboardingCuisine createState() => _OnboardingCuisine();
}

class _OnboardingCuisine extends State<OnboardingCuisine> {
  final AccountStates accountStates = Get.put(AccountStates());
  final CuisineStates cuisineStates = Get.put(CuisineStates());
  Future _future;

  @override
  void initState() {
    _future = cuisineStates.getCuisines();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData)
            return Column(
              children: [
                Lottie.asset('assets/lotties/food-prepared.json'),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: AutoSizeText(
                    "What are your favorite types${nbsp}of${nbsp}food?",
                    style: textStyleH1,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(24.0),
                  child: SelectableTags(
                    tags: cuisineStates.cuisines,
                    onClickTag: (tag) {
                      cuisineStates.setTag(tag.index, tag.active);
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
                              style: textStyleSkip,
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
                              style: textStyleNext,
                            ),
                          ),
                        )),
                  ],
                ),
                Expanded(child: Container()),
              ],
            );
          else
            return Loading();
        });
  }

  _nextOnboardingStep() async {
    appStates.setLoading(true);
    accountStates.account.value.onboardingFlag =
        accountStates.account.value.onboardingFlag + 1;
    await accountStates.updateAccount();
    await cuisineStates.updateCuisines();
    appStates.setLoading(false);
  }

  _skipOnboarding() async {
    appStates.setLoading(true);
    accountStates.account.value.onboardingFlag = ONBOARDING_STEP_ID_PROFILE;
    await accountStates.updateAccount();
    appStates.setLoading(false);
  }
}
