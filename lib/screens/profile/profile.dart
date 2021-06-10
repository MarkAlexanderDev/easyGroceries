import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/screens/onboarding/onboarding.dart';
import 'package:foodz/services/auth.dart';
import 'package:foodz/states/account_states.dart';
import 'package:foodz/states/allergies_states.dart';
import 'package:foodz/states/app_states.dart';
import 'package:foodz/states/cuisines_states.dart';
import 'package:foodz/style/colors.dart';
import 'package:foodz/style/text_style.dart';
import 'package:foodz/urls.dart';
import 'package:foodz/utils/picture.dart';
import 'package:foodz/utils/urlLauncher.dart';
import 'package:foodz/widgets_common/kitchen_tools_selector.dart';
import 'package:foodz/widgets_common/people_selector.dart';
import 'package:foodz/widgets_common/profile_picture.dart';
import 'package:foodz/widgets_common/selectable_tags.dart';
import 'package:foodz/widgets_default/confirm_button.dart';
import 'package:foodz/widgets_default/dropdown_button.dart';
import 'package:foodz/widgets_default/loading.dart';
import 'package:foodz/widgets_default/section.dart';
import 'package:foodz/widgets_default/text_input.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Profile();
}

class _Profile extends State<Profile> {
  final AccountStates accountStates = Get.find();
  final AllergiesStates allergiesStates = Get.find();
  final CuisinesStates cuisinesStates = Get.find();
  Future _future;

  @override
  void initState() {
    _future = _loader();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _getAppBar(context),
        body: FutureBuilder(
            future: _future,
            builder: (BuildContext context, snap) {
              if (snap.hasData)
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () async {
                              await _onEditPicture(context);
                            },
                            child: Obx(() => FoodzProfilePicture(
                                  height: 100,
                                  width: 100,
                                  pictureUrl:
                                      accountStates.account.pictureUrl.value,
                                  editMode: true,
                                  onEdit: () async {
                                    await _onEditPicture(context);
                                  },
                                  defaultChild: Icon(Icons.person),
                                ))),
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: FoodzTextInput(
                                initialValue: accountStates.account.name.value,
                                onChanged: (value) =>
                                    accountStates.account.name.value = value,
                                onClear: () =>
                                    accountStates.account.name.value = "",
                                hint: "Name"),
                          ),
                        ),
                        FoodzSection(
                          icon: Icons.local_fire_department,
                          text: "MY COOKING EXPERIENCE",
                          placeholder: Obx(() => FoodzDropdownButton(
                                items: COOKING_EXPERIENCE_IDS,
                                currentValue: accountStates
                                    .getCookingExperienceConverted(accountStates
                                        .account.cookingExperience.value),
                                onChanged: (String value) => accountStates
                                        .account.cookingExperience.value =
                                    COOKING_EXPERIENCE_IDS.indexOf(value),
                              )),
                        ),
                        FoodzSection(
                          icon: Icons.clear,
                          text: "MY FORBIDDEN FOOD",
                          placeholder: SelectableTags(
                            activeTags: accountStates.account.allergies,
                            tags: allergiesStates.allergies,
                            onClickTag: (tag) {
                              if (accountStates.account.allergies.contains(tag))
                                accountStates.account.allergies.remove(tag);
                              else
                                accountStates.account.allergies.add(tag);
                            },
                          ),
                        ),
                        FoodzSection(
                          icon: Icons.group,
                          text: "HOW MANY PEOPLE I LIVE WITH ?",
                          placeholder: FoodzPeopleSelector(
                            peopleNumber: accountStates.account.peopleNb.value,
                            onTap: (int value) =>
                                accountStates.account.peopleNb.value = value,
                          ),
                        ),
                        FoodzSection(
                          icon: Icons.group,
                          text: "WHICH KITCHEN TOOLS DO I OWN ?",
                          placeholder: KitchenToolsSelector(
                            kitchenTools: accountStates.account.kitchenTools,
                            onTap: (int index) {
                              if (accountStates.account.kitchenTools
                                  .contains(index))
                                accountStates.account.kitchenTools
                                    .remove(index);
                              else
                                accountStates.account.kitchenTools.add(index);
                            },
                          ),
                        ),
                        FoodzSection(
                          icon: Icons.fastfood_rounded,
                          text: "MY FAVORITE CUISINE",
                          placeholder: SelectableTags(
                            activeTags: accountStates.account.cuisines,
                            tags: cuisinesStates.cuisines,
                            onClickTag: (tag) {
                              if (accountStates.account.cuisines.contains(tag))
                                accountStates.account.cuisines.remove(tag);
                              else
                                accountStates.account.cuisines.add(tag);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _ProfileButon(
                            icon: Icons.account_tree,
                            text: "SUGGEST A FEATURE",
                            onClick: () async {
                              await launchUrl(
                                  "https://c0l0dpj04sd.typeform.com/to/GaQDfqZh");
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _ProfileButon(
                            icon: Icons.bug_report,
                            text: "REPORT A BUG",
                            onClick: () async {
                              await launchUrl(
                                  "https://c0l0dpj04sd.typeform.com/to/ITUBtkL3");
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _ProfileButon(
                            icon: Icons.logout,
                            text: "LOGOUT",
                            onClick: () async {
                              await authService.signOut();
                              accountStates.account.onboardingFlag.value =
                                  ONBOARDING_STEP_ID_AUTH;
                              Get.toNamed("/");
                            },
                          ),
                        ),
                        Container(height: 75),
                      ],
                    ),
                  ),
                );
              else
                return FoodzLoading();
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Obx(() => FoodzConfirmButton(
              label: "confirm",
              enabled: !appStates.uploadingProfilePicture.value,
              onClick: () async {
                accountStates
                    .updateAccount(FirebaseAuth.instance.currentUser.uid);
                Get.toNamed(URL_HOME);
              },
            )));
  }

  Future<bool> _loader() async {
    await allergiesStates.readAllAllergies();
    await cuisinesStates.readAllCuisines();
    return true;
  }

  Future<void> _onEditPicture(context) async {
    final String imgPath =
        await getImage(context, accountStates.account.pictureUrl.value != null);
    if (imgPath != null) accountStates.account.pictureUrl.value = imgPath;
  }

  AppBar _getAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      title: AutoSizeText(
        "My profile",
        style: textFredokaOneH2,
      ),
      centerTitle: true,
      iconTheme: IconThemeData(
        color: mainColor, //change your color here
      ),
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.offNamed(URL_HOME)),
    );
  }
}

class _ProfileButon extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onClick;

  _ProfileButon({@required this.icon, this.text, this.onClick});

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
            border: Border.all(color: Colors.grey.withOpacity(0.5)),
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(icon, color: Colors.black.withOpacity(0.5)),
              Container(width: 25),
              AutoSizeText(text, style: textAssistantH1BlackBold),
            ],
          ),
        ),
      ),
    );
  }
}
