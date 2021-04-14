import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/screens/onboarding/onboarding.dart';
import 'package:foodz/services/auth.dart';
import 'package:foodz/states/account_states.dart';
import 'package:foodz/states/app_states.dart';
import 'package:foodz/style/colors.dart';
import 'package:foodz/style/inputs.dart';
import 'package:foodz/style/text_style.dart';
import 'package:foodz/urls.dart';
import 'package:foodz/utils/picture.dart';
import 'package:foodz/utils/urlLauncher.dart';
import 'package:foodz/widgets/button.dart';
import 'package:foodz/widgets/profile_picture.dart';
import 'package:foodz/widgets/section_title.dart';
import 'package:foodz/widgets/selectable_tags.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  final AccountStates accountStates = Get.put(AccountStates());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: AutoSizeText(
                    "MY PROFILE",
                    style: textStyleH1,
                  ),
                ),
                Container(height: 20),
                GestureDetector(
                    onTap: () async {
                      await _onEditPicture(context);
                    },
                    child: Obx(() => ProfilePicture(
                          height: 100,
                          width: 100,
                          pictureUrl: accountStates.account.pictureUrl.value,
                          editMode: true,
                          onEdit: () async {
                            await _onEditPicture(context);
                          },
                        ))),
                Container(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextFormField(
                    autocorrect: false,
                    keyboardType: TextInputType.visiblePassword,
                    style: textStyleH1,
                    textAlign: TextAlign.center,
                    decoration: getStandardInputDecoration("name", ""),
                    initialValue: accountStates.account.name.value,
                    onChanged: (value) {
                      accountStates.account.name.value = value;
                    },
                  ),
                ),
                Container(height: 20),
                SectionTitle(
                    icon: Icons.local_fire_department,
                    text: "MY COOKING EXPERIENCE"),
                Container(height: 10),
                Obx(() => DropdownButton<String>(
                      value: accountStates.getCookingExperienceConverted(
                          accountStates.account.cookingExperience.value),
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
                        accountStates.account.cookingExperience.value =
                            COOKING_EXPERIENCE_IDS.indexOf(value);
                      },
                      items: COOKING_EXPERIENCE_IDS
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: AutoSizeText(value, style: textStyleH2),
                        );
                      }).toList(),
                    )),
                Container(height: 20),
                SectionTitle(icon: Icons.clear, text: "MY FORBIDDEN FOOD"),
                Container(height: 10),
                Container(
                  padding: EdgeInsets.all(24.0),
                  child: SelectableTags(
                    activeTags: accountStates.account.allergies,
                    tags: accountStates.account.allergies,
                    onClickTag: (tag) {
                      if (accountStates.account.allergies.contains(tag))
                        accountStates.account.allergies.remove(tag);
                      else
                        accountStates.account.allergies.add(tag);
                    },
                  ),
                ),
                Container(height: 20),
                SectionTitle(
                    icon: Icons.fastfood_rounded, text: "MY FAVORITE CUISINE"),
                Container(height: 10),
                Container(
                  padding: EdgeInsets.all(24.0),
                  child: SelectableTags(
                    activeTags: accountStates.account.cuisines,
                    tags: accountStates.account.cuisines,
                    onClickTag: (tag) {
                      if (accountStates.account.cuisines.contains(tag))
                        accountStates.account.cuisines.remove(tag);
                      else
                        accountStates.account.cuisines.add(tag);
                    },
                  ),
                ),
                Container(height: 20),
                _ProfileButon(
                  isFirst: true,
                  icon: Icons.account_tree,
                  text: "SUGGEST A FEATURE",
                  onClick: () async {
                    await launchUrl(
                        "https://c0l0dpj04sd.typeform.com/to/GaQDfqZh");
                  },
                ),
                _ProfileButon(
                  icon: Icons.bug_report,
                  text: "REPORT A BUG",
                  onClick: () async {
                    await launchUrl(
                        "https://c0l0dpj04sd.typeform.com/to/ITUBtkL3");
                  },
                ),
                _ProfileButon(
                  icon: Icons.logout,
                  text: "LOGOUT",
                  onClick: () async {
                    await authService.signOut();
                    accountStates.account.onboardingFlag.value =
                        ONBOARDING_STEP_ID_AUTH;
                    Get.toNamed("/");
                  },
                ),
                Container(height: 50),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Obx(() => ConfirmButton(
              enabled: !appStates.uploadingProfilePicture.value,
              onClick: () async {
                accountStates.updateAccount();
                Get.toNamed(URL_HOME);
              },
            )));
  }

  Future<void> _onEditPicture(context) async {
    final String imgPath =
        await getImage(context, accountStates.account.pictureUrl.value != null);
    if (imgPath != null) accountStates.account.pictureUrl.value = imgPath;
  }
}

class _ProfileButon extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onClick;
  final bool isFirst;

  _ProfileButon({this.isFirst, @required this.icon, this.text, this.onClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await onClick();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: isFirst == null || !isFirst
                        ? Colors.transparent
                        : mainColor),
                left: BorderSide(color: mainColor),
                right: BorderSide(color: mainColor),
                bottom: BorderSide(color: mainColor))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(icon, color: mainColor),
              Container(width: 25),
              AutoSizeText(text, style: textStyleH1Green),
            ],
          ),
        ),
      ),
    );
  }
}
