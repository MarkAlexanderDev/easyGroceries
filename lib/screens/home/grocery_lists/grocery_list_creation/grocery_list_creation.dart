import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:foodz/extensions/color.dart';
import 'package:foodz/services/database/entities/grocery_list/entity_grocery_list.dart';
import 'package:foodz/states/account_states.dart';
import 'package:foodz/states/app_states.dart';
import 'package:foodz/states/grocery_list_states.dart';
import 'package:foodz/style/colors.dart';
import 'package:foodz/style/inputs.dart';
import 'package:foodz/style/text_style.dart';
import 'package:foodz/urls.dart';
import 'package:foodz/utils/color.dart';
import 'package:foodz/utils/picture.dart';
import 'package:foodz/widgets/button.dart';
import 'package:foodz/widgets/profile_picture.dart';
import 'package:get/get.dart';

class GroceryListCreation extends StatefulWidget {
  @override
  _GroceryListCreation createState() => _GroceryListCreation();
}

class _GroceryListCreation extends State<GroceryListCreation> {
  final GroceryListStates groceryListStates = Get.find();
  final AccountStates accountStates = Get.find();

  @override
  void initState() {
    groceryListStates.groceryList = EntityGroceryList();
    groceryListStates.groceryList.name.value = "Monday shopping";
    groceryListStates.groceryList.description.value =
        "All my needs for the week !";
    groceryListStates.groceryList.color.value = mainColor.toHex();
    groceryListStates.groceryList.pictureUrl.value =
        "https://images.theconversation.com/files/282104/original/file-20190701-105182-1q7a7ji.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=320&h=213&fit=crop";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(0, 60),
          child: Obx(() => AppBar(
                backgroundColor:
                    hexToColor(groceryListStates.groceryList.color.value),
                title: AutoSizeText(
                  "Grocery list creation",
                  style: textAssistantH1WhiteBold,
                ),
                centerTitle: true,
              ))),
      bottomNavigationBar: ConfirmButton(
          enabled: true,
          onClick: () async {
            appStates.setLoading(true);
            await groceryListStates.createGroceryList();
            await groceryListStates
                .createGroceryListAccount(accountStates.account.uid);
            accountStates.account.groceryListIds
                .add(groceryListStates.groceryList.uid);
            accountStates.updateAccount();
            Get.offNamed(URL_GROCERY_LIST);
            appStates.setLoading(false);
          }),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(children: [
            GestureDetector(
              onTap: () async {
                groceryListStates.groceryList.pictureUrl.value = await getImage(
                    context,
                    groceryListStates.groceryList.pictureUrl.value != null);
              },
              child: Obx(() => ProfilePicture(
                    pictureUrl: groceryListStates.groceryList.pictureUrl.value,
                    editMode: true,
                    height: 100,
                    width: 100,
                    onEdit: () async {
                      groceryListStates.groceryList.pictureUrl.value =
                          await getImage(
                              context,
                              groceryListStates.groceryList.pictureUrl.value !=
                                  null);
                    },
                  )),
            ),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.visiblePassword,
              textAlign: TextAlign.center,
              style: textAssistantH1Black,
              decoration: getStandardInputDecoration("", ""),
              initialValue: groceryListStates.groceryList.name.value,
              onChanged: (value) {
                groceryListStates.groceryList.name.value = value;
              },
            ),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.visiblePassword,
              textAlign: TextAlign.center,
              style: textAssistantH1Black,
              decoration: getStandardInputDecoration("", ""),
              initialValue: groceryListStates.groceryList.description.value,
              onChanged: (value) {
                groceryListStates.groceryList.description.value = value;
              },
            ),
            Container(height: 20),
            BlockPicker(
              pickerColor:
                  hexToColor(groceryListStates.groceryList.color.value),
              onColorChanged: (value) {
                groceryListStates.groceryList.color.value = value.toHex();
              },
              availableColors: [mainColor, secondaryColor, accentColor],
            ),
          ]),
        ),
      ),
    );
  }
}
