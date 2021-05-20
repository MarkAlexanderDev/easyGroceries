import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/services/database/entities/grocery_list/entity_grocery_list.dart';
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
import 'package:foodz/widgets_default/checkbox.dart';
import 'package:foodz/widgets_default/confirm_button.dart';
import 'package:foodz/widgets_default/text_input.dart';
import 'package:get/get.dart';

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
              "Grocery list creation",
              style: textFredokaOneH1,
            ),
            centerTitle: true,
            iconTheme: IconThemeData(
              color: mainColor, //change your color here
            ),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            GestureDetector(
              onTap: () async {
                groceryListStates.groceryList.pictureUrl.value = await getImage(
                    context,
                    groceryListStates.groceryList.pictureUrl.value != null);
              },
              child: Align(
                alignment: Alignment.center,
                child: Obx(() => FoodzProfilePicture(
                      pictureUrl:
                          groceryListStates.groceryList.pictureUrl.value,
                      editMode: true,
                      height: 100,
                      width: 100,
                      defaultChild: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.asset("assets/images/appIcon.png"),
                      ),
                      onEdit: () async {
                        groceryListStates.groceryList.pictureUrl.value =
                            await getImage(
                                context,
                                groceryListStates
                                        .groceryList.pictureUrl.value !=
                                    null);
                      },
                    )),
              ),
            ),
            SizedBox(height: 30),
            FoodzTextInput(
              initialValue: groceryListStates.groceryList.name.value,
              onChanged: (value) {
                groceryListStates.groceryList.name.value = value;
              },
              onClear: () {
                groceryListStates.groceryList.name.value = "";
              },
              hint: "Monday shopping",
            ),
            SizedBox(height: 30),
            FoodzTextInput(
              initialValue: groceryListStates.groceryList.description.value,
              onChanged: (value) {
                groceryListStates.groceryList.description.value = value;
              },
              onClear: () {
                groceryListStates.groceryList.description.value = "";
              },
              hint: "All my needs for the week",
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
                          groceryListStates.groceryList.cronReminder.value =
                              "0 10 * * 1";
                        else
                          groceryListStates.groceryList.cronReminder.value = "";
                      },
                    )),
              ],
            ),
            SizedBox(height: 10),
            Obx(() => Visibility(
                  visible: groceryListStates
                      .groceryList.cronReminder.value.isNotEmpty,
                  child: Obx(() => Scheduler(
                        cronExpression:
                            groceryListStates.groceryList.cronReminder.value,
                        onChangedDays: (String value) {
                          _updateWeekDay(value);
                        },
                        onChangedTime: (DateTime value) {
                          _updateTime(value);
                        },
                      )),
                )),
          ]),
        ),
      ),
      bottomNavigationBar: Obx(() => FoodzConfirmButton(
          label: "confirm my list",
          enabled: groceryListStates.groceryList.name.value.isNotEmpty,
          onClick: () async {
            appStates.setLoading(true);
            if (isEditing)
              groceryListStates.updateGroceryList();
            else {
              await groceryListStates.createGroceryList();
              await groceryListStates
                  .createGroceryListAccount(accountStates.account.uid);
              accountStates.account.groceryListIds
                  .add(groceryListStates.groceryList.uid);
              accountStates.updateAccount();
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
