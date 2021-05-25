import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/states/account_states.dart';
import 'package:foodz/states/allergies_states.dart';
import 'package:foodz/style/text_style.dart';
import 'package:foodz/widgets_common/selectable_tags.dart';
import 'package:foodz/widgets_default/button.dart';
import 'package:foodz/widgets_default/loading.dart';
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
  final List<String> vegetarianTags = [
    "Fish",
    "Poultry Meat",
    "Red Meat",
    "Shellfish"
  ];

  final List<String> veganTags = ["Cheese", "Egg"];

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
            return ListView(
              shrinkWrap: true,
              children: [
                Lottie.asset('assets/lotties/vr-sickness.json', height: 200),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: AutoSizeText(
                    "Do you have specific food that you do not eat or you are allergic of ?",
                    style: textAssistantH1Black,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FoodzButton(
                        onClick: () => _addVegetarianTags(),
                        label: "I'm vegetarian !"),
                    FoodzButton(
                        onClick: () => _addVeganTags(), label: "I'm vegan !"),
                  ],
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
              ],
            );
          } else
            return FoodzLoading();
        });
  }

  void _addVegetarianTags() {
    vegetarianTags.forEach((element) {
      if (!accountStates.account.allergies.contains(element))
        accountStates.account.allergies.add(element);
    });
  }

  _addVeganTags() {
    vegetarianTags.forEach((element) {
      if (!accountStates.account.allergies.contains(element))
        accountStates.account.allergies.add(element);
    });
    veganTags.forEach((element) {
      if (!accountStates.account.allergies.contains(element))
        accountStates.account.allergies.add(element);
    });
  }
}
