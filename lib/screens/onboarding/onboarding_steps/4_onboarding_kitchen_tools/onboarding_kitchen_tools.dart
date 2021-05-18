import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:foodz/states/account_states.dart';
import 'package:foodz/style/text_style.dart';
import 'package:foodz/widgets_common/kitchen_tools_selector.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OnboardingKitchenTools extends StatelessWidget {
  final AccountStates accountStates = Get.find();

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Lottie.asset('assets/lotties/cooking-with-auberigne.json', height: 200),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: AutoSizeText(
            "Which kitchen tools do you own ?",
            style: textAssistantH1Black,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 50),
        KitchenToolsSelector(
          kitchenTools: accountStates.account.kitchenTools,
          onTap: (int index) {
            if (accountStates.account.kitchenTools.contains(index))
              accountStates.account.kitchenTools.remove(index);
            else
              accountStates.account.kitchenTools.add(index);
          },
        ),
      ],
    );
  }
}
