import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/states/account_states.dart';
import 'package:foodz/style/text_style.dart';
import 'package:foodz/utils/picture.dart';
import 'package:foodz/widgets_common/profile_picture.dart';
import 'package:foodz/widgets_default/dropdown_button.dart';
import 'package:foodz/widgets_default/text_input.dart';
import 'package:get/get.dart';

class OnboardingProfile extends StatefulWidget {
  @override
  _OnboardingProfile createState() => _OnboardingProfile();
}

class _OnboardingProfile extends State<OnboardingProfile> {
  final AccountStates accountStates = Get.put(AccountStates());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        GestureDetector(
          onTap: () async {
            await _onEditPicture();
          },
          child: Obx(() => FoodzProfilePicture(
                pictureUrl: accountStates.account.pictureUrl.value,
                defaultChild: Icon(Icons.person),
                editMode: true,
                height: 100,
                width: 100,
                onEdit: () async {
                  await _onEditPicture();
                },
              )),
        ),
        SizedBox(height: 30),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width * 0.1,
          child: Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: AutoSizeText(
              "How should we call you?",
              style: textAssistantH1Black,
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.025),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          child: FoodzTextInput(
            hint: "Name",
            initialValue: accountStates.account.name.value,
            onChanged: (value) {
              accountStates.account.name.value = value;
            },
            onClear: () {
              accountStates.account.name.value = "";
            },
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.1,
          child: Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: AutoSizeText(
              "What is your cooking experience ?",
              style: textAssistantH1Black,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.025),
        Obx(() => FoodzDropdownButton(
              items: COOKING_EXPERIENCE_IDS,
              currentValue: accountStates.getCookingExperienceConverted(
                  accountStates.account.cookingExperience.value),
              onChanged: (String value) => accountStates
                  .account
                  .cookingExperience
                  .value = COOKING_EXPERIENCE_IDS.indexOf(value),
            )),
        Spacer(),
      ],
    );
  }

  Future<void> _onEditPicture() async {
    final String imgPath =
        await getImage(context, accountStates.account.pictureUrl.value != null);
    if (imgPath != null) accountStates.account.pictureUrl.value = imgPath;
  }
}
