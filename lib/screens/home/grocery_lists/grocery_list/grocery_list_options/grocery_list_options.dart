import 'package:EasyGroceries/extensions/color.dart';
import 'package:EasyGroceries/screens/consts.dart';
import 'package:EasyGroceries/screens/home/grocery_lists/grocery_list/grocery_list_states.dart';
import 'package:EasyGroceries/style/colors.dart';
import 'package:EasyGroceries/style/inputs.dart';
import 'package:EasyGroceries/style/text_style.dart';
import 'package:EasyGroceries/urls.dart';
import 'package:EasyGroceries/utils/color.dart';
import 'package:EasyGroceries/utils/picture.dart';
import 'package:EasyGroceries/widgets/button.dart';
import 'package:EasyGroceries/widgets/loading.dart';
import 'package:EasyGroceries/widgets/profile_picture.dart';
import 'package:EasyGroceries/widgets/section_title.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';

class GroceryListOption extends StatefulWidget {
  @override
  _GroceryListOption createState() => _GroceryListOption();
}

class _GroceryListOption extends State<GroceryListOption> {
  final GroceryListStates groceryListStates = Get.put(GroceryListStates());
  Future _future;

  @override
  void initState() {
    _future = groceryListStates.getOptionData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (BuildContext context, res) {
          if (res.hasData && !groceryListStates.isLoading.value)
            return Scaffold(
              body: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      Center(
                        child: AutoSizeText(
                          "GROCERY LIST OPTIONS",
                          style: textStyleH1,
                        ),
                      ),
                      Container(height: 20),
                      GestureDetector(
                          onTap: () async {
                            groceryListStates
                                .setGroceryListPictureUrl(await getImage(
                              context,
                              groceryListStates.groceryListPictureUrl.value
                                  .toString()
                                  .isNotEmpty,
                            ));
                          },
                          child: Obx(() => ProfilePicture(
                                height: 100,
                                width: 100,
                                name: groceryListStates
                                    .currentGroceryList.value.title,
                                pictureUrl: groceryListStates
                                    .groceryListPictureUrl.value,
                                editMode: true,
                                onEdit: () async {
                                  groceryListStates
                                      .setGroceryListPictureUrl(await getImage(
                                    context,
                                    groceryListStates
                                        .currentGroceryList.value.pictureUrl
                                        .toString()
                                        .isNotEmpty,
                                  ));
                                },
                              ))),
                      Container(height: 20),
                      Container(
                        width: appWidth,
                        child: TextFormField(
                          autocorrect: false,
                          keyboardType: TextInputType.visiblePassword,
                          style: textStyleH1,
                          textAlign: TextAlign.center,
                          decoration: getStandardInputDecoration("name", ""),
                          initialValue:
                              groceryListStates.currentGroceryList.value.title,
                          onChanged: (value) {
                            groceryListStates.currentGroceryList.value.title =
                                value;
                          },
                        ),
                      ),
                      Container(height: 20),
                      TextFormField(
                        autocorrect: false,
                        keyboardType: TextInputType.visiblePassword,
                        textAlign: TextAlign.center,
                        style: textStyleH2,
                        decoration:
                            getStandardInputDecoration("description", ""),
                        initialValue: groceryListStates
                            .currentGroceryList.value.description,
                        onChanged: (value) {
                          groceryListStates
                              .currentGroceryList.value.description = value;
                        },
                      ),
                      Container(height: 20),
                      BlockPicker(
                        pickerColor: hexToColor(
                            groceryListStates.currentGroceryList.value.color),
                        onColorChanged: (value) => groceryListStates
                            .currentGroceryList.value.color = value.toHex(),
                        availableColors: [
                          mainColor,
                          secondaryColor,
                          accentColor
                        ],
                      ),
                      SectionTitle(
                          icon: Icons.accessibility_outlined,
                          text: "WHO CAN ACCESS THIS LIST"),
                      Container(height: 10),
                      Container(
                        padding: EdgeInsets.all(24.0),
                        /*child: SelectableTags(
                            tagStates:
                                profileStates.favoriteFoodStates.tagsStates,
                            onClickTag: (tag) {
                              profileStates.favoriteFoodStates
                                  .setTag(tag.index, tag.active);
                            },
                                profileStates.fadsfsdfsdf
                          ),*/
                      ),
                    ],
                  ))),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: ConfirmButton(
                onClick: () async {
                  await groceryListStates.setOptionData();
                  Get.toNamed(URL_GROCERY_LIST,
                      arguments: groceryListStates.currentGroceryList.value);
                },
              ),
            );
          else
            return Loading();
        });
  }
}
