import 'package:foodz/screens/consts.dart';
import 'package:foodz/states/account_states.dart';
import 'package:foodz/style/inputs.dart';
import 'package:foodz/style/text_style.dart';
import 'package:foodz/utils/picture.dart';
import 'package:foodz/widgets/profile_picture.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                await _onEditPicture();
              },
              child: ProfilePicture(
                name: null,
                pictureUrl: accountStates.account.value.pictureUrl,
                editMode: true,
                height: 100,
                width: 100,
                onEdit: () async {
                  await _onEditPicture();
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 0.1,
              child: Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: AutoSizeText(
                  "How should we call you?",
                  style: textStyleH2,
                ),
              ),
            ),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.visiblePassword,
              textAlign: TextAlign.center,
              style: textStyleH2,
              decoration: getStandardInputDecoration("", ""),
              initialValue: accountStates.account.value.name,
              onChanged: (value) {
                accountStates.account.value.name = value;
              },
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.1,
              child: Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: AutoSizeText(
                  "How many people are living with you ?",
                  style: textStyleH2,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.visiblePassword,
              style: textStyleH2,
              textAlign: TextAlign.center,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: getStandardInputDecoration("", ""),
              initialValue: accountStates.account.value.peopleNumber.toString(),
              onChanged: (value) {
                accountStates.account.value.peopleNumber = int.parse(value);
              },
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.1,
              child: Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: AutoSizeText(
                  "What is your cooking experience ?",
                  style: textStyleH2,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(height: MediaQuery.of(context).size.height * 0.025),
            DropdownButton<String>(
              value: accountStates.getCookingExperienceConverted(
                  accountStates.account.value.cookingExperience),
              icon: Icon(Icons.keyboard_arrow_down_rounded),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(
                color: Colors.black,
              ),
              underline: Container(
                height: 1,
                color: Colors.black,
              ),
              onChanged: (String value) {
                accountStates.account.update((account) {
                  account.cookingExperience =
                      COOKING_EXPERIENCE_IDS.indexOf(value);
                });
              },
              items: COOKING_EXPERIENCE_IDS
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: AutoSizeText(value, style: textStyleH2),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onEditPicture() async {
    final String imgPath = await getImage(
        context, !accountStates.account.value.pictureUrl.isNullOrBlank);
    accountStates.account.update((account) {
      if (!imgPath.isNull) account.pictureUrl = imgPath;
    });
  }
}
