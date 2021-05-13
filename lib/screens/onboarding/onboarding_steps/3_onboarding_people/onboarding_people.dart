import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/states/account_states.dart';
import 'package:foodz/style/text_style.dart';
import 'package:foodz/widgets_common/people_selector.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OnboardingPeople extends StatelessWidget {
  final AccountStates accountStates = Get.find();

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Lottie.asset('assets/lotties/group.json', height: 200),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: AutoSizeText(
            "How many people are you living with ? (including yourself)",
            style: textAssistantH1Black,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(() => FoodzPeopleSelector(
                peopleNumber: accountStates.account.peopleNb.value,
                onTap: (int index) {
                  accountStates.account.peopleNb.value = index + 1;
                },
              )),
        ),
      ],
    );
  }
}
