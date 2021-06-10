import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/services/auth.dart';
import 'package:foodz/services/database/api.dart';
import 'package:foodz/services/database/entities/account/entity_account.dart';
import 'package:foodz/services/database/entities/grocery_list/entity_grocery_list.dart';
import 'package:foodz/services/dynamic_link.dart';
import 'package:foodz/states/account_states.dart';
import 'package:foodz/states/app_states.dart';
import 'package:foodz/states/grocery_list_states.dart';
import 'package:foodz/style/colors.dart';
import 'package:foodz/style/text_style.dart';
import 'package:foodz/urls.dart';
import 'package:foodz/utils/picture.dart';
import 'package:foodz/utils/string.dart';
import 'package:foodz/widgets_common/profile_picture.dart';
import 'package:foodz/widgets_common/scheduler.dart';
import 'package:foodz/widgets_default/button.dart';
import 'package:foodz/widgets_default/checkbox.dart';
import 'package:foodz/widgets_default/confirm_button.dart';
import 'package:foodz/widgets_default/loading.dart';
import 'package:foodz/widgets_default/text_input.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';

class GroceryListCreation extends StatefulWidget {
  @override
  _GroceryListCreation createState() => _GroceryListCreation();
}

class _GroceryListCreation extends State<GroceryListCreation> {
  final GroceryListStates groceryListStates = Get.find();
  final AccountStates accountStates = Get.find();
  final bool isEditing = Get.arguments;

  @override
  void initState() {
    if (!isEditing) groceryListStates.groceryList = EntityGroceryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(0, 60),
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            title: AutoSizeText(
              "Grocery list " + (isEditing ? "edition" : "creation"),
              style: textFredokaOneH1,
            ),
            centerTitle: true,
            iconTheme: IconThemeData(
              color: mainColor, //change your color here
            ),
          )),
      body: Obx(() => appStates.loading.value
          ? FoodzLoading()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          groceryListStates.groceryList.pictureUrl.value =
                              await getImage(
                                  context,
                                  groceryListStates
                                          .groceryList.pictureUrl.value !=
                                      null);
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Obx(() => FoodzProfilePicture(
                                pictureUrl: groceryListStates
                                    .groceryList.pictureUrl.value,
                                editMode: true,
                                height: 100,
                                width: 100,
                                defaultChild: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child:
                                      Image.asset("assets/images/appIcon.png"),
                                ),
                                onEdit: () async {
                                  groceryListStates
                                          .groceryList.pictureUrl.value =
                                      await getImage(
                                          context,
                                          groceryListStates.groceryList
                                                  .pictureUrl.value !=
                                              null);
                                },
                              )),
                        ),
                      ),
                      SizedBox(height: 30),
                      FoodzTextInput(
                        initialValue: groceryListStates.groceryList.name.value,
                        onChanged: (value) {
                          groceryListStates.groceryList.name = value;
                        },
                        onClear: () {
                          groceryListStates.groceryList.name.value = "";
                        },
                        hint: "Name",
                      ),
                      SizedBox(height: 30),
                      FoodzTextInput(
                        initialValue: groceryListStates.groceryList.description,
                        onChanged: (value) {
                          groceryListStates.groceryList.description = value;
                        },
                        onClear: () {
                          groceryListStates.groceryList.description = "";
                        },
                        hint: "Description",
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: AutoSizeText(
                              "Enable weekly reminder ?",
                              style: textFredokaOneH2,
                              maxLines: 1,
                            ),
                          ),
                          Obx(() => FoodzCheckbox(
                                value: groceryListStates
                                    .groceryList.cronReminder.value.isNotEmpty,
                                onChanged: (bool value) {
                                  if (value)
                                    groceryListStates.groceryList.cronReminder
                                        .value = "0 10 * * 1";
                                  else
                                    groceryListStates
                                        .groceryList.cronReminder.value = "";
                                },
                              )),
                        ],
                      ),
                      SizedBox(height: 10),
                      Obx(() => Visibility(
                            visible: groceryListStates
                                .groceryList.cronReminder.value.isNotEmpty,
                            child: Obx(() => Scheduler(
                                  cronExpression: groceryListStates
                                      .groceryList.cronReminder.value,
                                  onChangedDays: (String value) {
                                    _updateWeekDay(value);
                                  },
                                  onChangedTime: (DateTime value) {
                                    _updateTime(value);
                                  },
                                )),
                          )),
                      SizedBox(height: 25),
                      Visibility(
                          visible: isEditing, child: _AccountManagement()),
                    ]),
              ),
            )),
      bottomNavigationBar: Obx(() => FoodzConfirmButton(
          label: "confirm my list",
          enabled: groceryListStates.groceryList.name.isNotEmpty,
          onClick: () async {
            appStates.setLoading(true);
            if (isEditing)
              groceryListStates.updateGroceryList();
            else {
              await groceryListStates.createGroceryList();
              await groceryListStates.createGroceryListAccount(
                  accountStates.account.uid, true);
              accountStates.account.groceryListIds
                  .add(groceryListStates.groceryList.uid);
              groceryListStates.groceryListOwned
                  .add(groceryListStates.groceryList);
              accountStates.updateAccount(authService.auth.currentUser.uid);
            }
            Get.offNamed(URL_GROCERY_LIST);
            appStates.setLoading(false);
          })),
    );
  }

  void _updateWeekDay(String value) {
    final String cronWeekDays = groceryListStates.groceryList.cronReminder.value
        .substring(
            groceryListStates.groceryList.cronReminder.value.lastIndexOf(" ") +
                1);
    if (cronWeekDays.contains(value)) {
      groceryListStates.groceryList.cronReminder.value = groceryListStates
          .groceryList.cronReminder.value
          .replaceAll("," + value, "");
      groceryListStates.groceryList.cronReminder.value = groceryListStates
          .groceryList.cronReminder.value
          .replaceAll(value + ",", "");
      if (groceryListStates.groceryList.cronReminder.value
          .substring(
              groceryListStates.groceryList.cronReminder.value.lastIndexOf(" "))
          .contains(value))
        groceryListStates.groceryList.cronReminder.value = replaceCharAt(
            groceryListStates.groceryList.cronReminder.value,
            groceryListStates.groceryList.cronReminder.value.length - 1,
            "*");
    } else if (cronWeekDays == "*")
      groceryListStates.groceryList.cronReminder.value = replaceCharAt(
          groceryListStates.groceryList.cronReminder.value,
          groceryListStates.groceryList.cronReminder.value.length - 1,
          value);
    else
      groceryListStates.groceryList.cronReminder.value =
          groceryListStates.groceryList.cronReminder.value += "," + value;
  }

  void _updateTime(DateTime value) {
    groceryListStates.groceryList.cronReminder.value = value.minute.toString() +
        " " +
        value.hour.toString() +
        " * * " +
        groceryListStates.groceryList.cronReminder.value.substring(
            groceryListStates.groceryList.cronReminder.value.lastIndexOf(" "));
  }
}

class _AccountManagement extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => __AccountManagement();
}

class __AccountManagement extends State<_AccountManagement> {
  final GroceryListStates groceryListStates = Get.find();
  Future futureGroceryListAccounts;

  @override
  void initState() {
    futureGroceryListAccounts = groceryListStates
        .readAllGroceryListAccounts(groceryListStates.groceryList.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureGroceryListAccounts,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData)
            return Column(
              children: [
                ListView.builder(
                  itemCount: groceryListStates.accounts.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            final bool isCurrentUser =
                                FirebaseAuth.instance.currentUser.uid ==
                                    groceryListStates.accounts[index].uid;
                            final bool isOwner = groceryListStates
                                .groceryListAccounts
                                .where((element) =>
                                    element.owner &&
                                    element.uid ==
                                        FirebaseAuth.instance.currentUser.uid)
                                .isNotEmpty;
                            showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (BuildContext context) {
                                  return SizedBox(
                                    height: 300,
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 20,
                                          height: 5,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0))),
                                        ),
                                        SizedBox(height: 5),
                                        Expanded(
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  30.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  30.0))),
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(height: 20),
                                                      FoodzProfilePicture(
                                                        height: 100,
                                                        width: 100,
                                                        pictureUrl:
                                                            groceryListStates
                                                                .accounts[index]
                                                                .pictureUrl
                                                                .value,
                                                        editMode: false,
                                                        defaultChild:
                                                            Icon(Icons.person),
                                                      ),
                                                      SizedBox(height: 20),
                                                      Text(
                                                        groceryListStates
                                                            .accounts[index]
                                                            .name
                                                            .value,
                                                        style:
                                                            textAssistantH1Black,
                                                      ),
                                                      Spacer(),
                                                      Visibility(
                                                        visible: isCurrentUser,
                                                        child: FoodzButton(
                                                            danger: true,
                                                            onClick: () async {
                                                              Navigator.pop(
                                                                  context);
                                                              if (isOwner)
                                                                await _deleteGroceryList();
                                                              else
                                                                await _leaveGroceryList();
                                                            },
                                                            label: (isOwner
                                                                    ? "Delete"
                                                                    : "Leave") +
                                                                " the grocery list"),
                                                      ),
                                                      Visibility(
                                                        visible: isOwner &&
                                                            !isCurrentUser,
                                                        child: FoodzButton(
                                                          danger: true,
                                                          onClick: () async {
                                                            Navigator.pop(
                                                                context);
                                                            await _kickFromGroceryList(
                                                                groceryListStates
                                                                        .accounts[
                                                                    index]);
                                                          },
                                                          label:
                                                              "Remove from the grocery list",
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            height: 75,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: grey, width: 0.25),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Row(
                              children: [
                                SizedBox(width: 20),
                                FoodzProfilePicture(
                                  height: 50,
                                  width: 50,
                                  pictureUrl: groceryListStates
                                      .accounts[index].pictureUrl.value,
                                  editMode: false,
                                  defaultChild: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Image.asset(
                                        "assets/images/appIcon.png"),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          AutoSizeText(
                                            groceryListStates
                                                .accounts[index].name.value,
                                            style: textAssistantH2BlackBold,
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(width: 7),
                                          groceryListStates
                                                      .accounts[index].uid ==
                                                  FirebaseAuth
                                                      .instance.currentUser.uid
                                              ? Text(
                                                  "(you)",
                                                  style:
                                                      textAssistantH3GreyBold,
                                                )
                                              : Container(),
                                        ],
                                      ),
                                      AutoSizeText(
                                        groceryListStates.groceryListAccounts
                                                .where((element) =>
                                                    element.uid ==
                                                    groceryListStates
                                                        .accounts[index].uid)
                                                .first
                                                .owner
                                            ? "Owner"
                                            : "Member",
                                        style: textAssistantH2Black,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    );
                  },
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: grey, width: 0.25)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        await Share.share(
                            await dynamicLink.createInvitationLinkGroceryList(
                                groceryListStates.groceryList.uid));
                      },
                      child: Icon(
                        Icons.add_outlined,
                        color: mainColor,
                      ),
                    ),
                  ),
                ),
              ],
            );
          else
            return FoodzLoading();
        });
  }

  Future<void> _deleteGroceryList() async {
    appStates.loading.value = true;
    await Future.forEach(groceryListStates.accounts,
        (EntityAccount element) async {
      element.groceryListIds.removeWhere(
          (element) => element == groceryListStates.groceryList.uid);
      API.entries.accounts.update(element.uid, element);
    });
    await groceryListStates
        .deleteGroceryList(groceryListStates.groceryList.uid);
    groceryListStates.groceryListOwned.remove(groceryListStates.groceryList);
    appStates.loading.value = false;
    Get.toNamed(URL_HOME);
  }

  Future<void> _leaveGroceryList() async {
    final AccountStates accountStates = Get.find();
    appStates.loading.value = true;
    await groceryListStates
        .deleteGroceryListAccount(FirebaseAuth.instance.currentUser.uid);
    groceryListStates.groceryList.peopleNb -= 1;
    await groceryListStates.updateGroceryList();
    accountStates.account.groceryListIds
        .removeWhere((element) => element == groceryListStates.groceryList.uid);
    await accountStates.updateAccount(FirebaseAuth.instance.currentUser.uid);
    groceryListStates.groceryListOwned.remove(groceryListStates.groceryList);
    appStates.loading.value = false;
    Get.toNamed(URL_HOME);
  }

  Future<void> _kickFromGroceryList(EntityAccount account) async {
    appStates.loading.value = true;
    await groceryListStates
        .deleteGroceryListAccount(FirebaseAuth.instance.currentUser.uid);
    groceryListStates.groceryList.peopleNb -= 1;
    await groceryListStates.updateGroceryList();
    await groceryListStates.deleteGroceryListAccount(account.uid);
    futureGroceryListAccounts = groceryListStates
        .readAllGroceryListAccounts(groceryListStates.groceryList.uid);
    appStates.loading.value = false;
  }
}
