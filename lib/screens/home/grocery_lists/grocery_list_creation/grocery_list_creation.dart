import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:foodz/extensions/color.dart';
import 'package:foodz/services/database/models/grocery_list_model.dart';
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
  final GroceryListStates groceryListStates = Get.put(GroceryListStates());

  @override
  void initState() {
    groceryListStates.groceryList.value = GroceryListModel();
    groceryListStates.groceryList.value.title = "New grocery list";
    groceryListStates.groceryList.value.description = "New description";
    groceryListStates.groceryList.value.color = mainColor.toHex();
    groceryListStates.groceryList.value.pictureUrl =
        "https://firebasestorage.googleapis.com/v0/b/foodz-2aec5.appspot.com/o/assets%2Fgrocery.png?alt=media&token=d808b0ab-eccf-4bcf-a5ae-36d4dca1b53f";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(0, 60),
          child: Obx(() => AppBar(
                backgroundColor:
                    hexToColor(groceryListStates.groceryList.value.color),
                title: AutoSizeText(
                  "Grocery list creation",
                  style: textStyleH3Bold,
                ),
                centerTitle: true,
              ))),
      bottomNavigationBar: ConfirmButton(
          enabled: true,
          onClick: () async {
            appStates.setLoading(true);
            await groceryListStates.createGroceryList();
            Get.offNamed(URL_GROCERY_LIST,
                arguments: groceryListStates.groceryList.value);
            appStates.setLoading(false);
          }),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(children: [
            GestureDetector(
              onTap: () async {
                groceryListStates.groceryList.value.pictureUrl = await getImage(
                    context,
                    groceryListStates.groceryList.value.pictureUrl != null);
              },
              child: Obx(() => ProfilePicture(
                    name: groceryListStates.groceryList.value.title,
                    pictureUrl: groceryListStates.groceryList.value.pictureUrl,
                    editMode: true,
                    height: 100,
                    width: 100,
                    onEdit: () async {
                      groceryListStates.groceryList.value.pictureUrl =
                          await getImage(
                              context,
                              groceryListStates.groceryList.value.pictureUrl !=
                                  null);
                    },
                  )),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.1,
              child: Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: AutoSizeText(
                  "How should we name your new list?",
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
              initialValue: groceryListStates.groceryList.value.title,
              onChanged: (value) {
                groceryListStates.groceryList.value.title = value;
              },
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.1,
              child: Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: AutoSizeText(
                  "How would you describe it?",
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
              initialValue: groceryListStates.groceryList.value.description,
              onChanged: (value) {
                groceryListStates.groceryList.value.description = value;
              },
            ),
            Container(height: 20),
            BlockPicker(
              pickerColor:
                  hexToColor(groceryListStates.groceryList.value.color),
              onColorChanged: (value) {
                groceryListStates.groceryList.update((groceryList) {
                  groceryList.color = value.toHex();
                });
              },
              availableColors: [mainColor, secondaryColor, accentColor],
            ),
          ]),
        ),
      ),
    );
  }
}
