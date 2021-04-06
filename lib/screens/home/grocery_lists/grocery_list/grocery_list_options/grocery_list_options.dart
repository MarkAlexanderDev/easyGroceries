import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:foodz/extensions/color.dart';
import 'package:foodz/services/auth.dart';
import 'package:foodz/services/database/entities/account/entity_account.dart';
import 'package:foodz/services/dynamic_link.dart';
import 'package:foodz/states/app_states.dart';
import 'package:foodz/states/grocery_list_states.dart';
import 'package:foodz/style/colors.dart';
import 'package:foodz/style/inputs.dart';
import 'package:foodz/style/text_style.dart';
import 'package:foodz/urls.dart';
import 'package:foodz/utils/color.dart';
import 'package:foodz/utils/picture.dart';
import 'package:foodz/widgets/button.dart';
import 'package:foodz/widgets/loading.dart';
import 'package:foodz/widgets/profile_picture.dart';
import 'package:foodz/widgets/section_title.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';

class GroceryListOption extends StatefulWidget {
  @override
  _GroceryListOption createState() => _GroceryListOption();
}

class _GroceryListOption extends State<GroceryListOption> {
  final GroceryListStates groceryListStates = Get.put(GroceryListStates());
  Future futureGroceryListAccounts;

  @override
  void initState() {
    futureGroceryListAccounts = groceryListStates.readAllGroceryListAccounts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureGroceryListAccounts,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData)
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
                            await _onEditPicture(context);
                          },
                          child: Obx(() => ProfilePicture(
                                height: 100,
                                width: 100,
                                name: groceryListStates.groceryList.name.value,
                                pictureUrl: groceryListStates
                                    .groceryList.pictureUrl.value,
                                editMode: true,
                                onEdit: () async {
                                  await _onEditPicture(context);
                                },
                              ))),
                      Container(height: 20),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          autocorrect: false,
                          keyboardType: TextInputType.visiblePassword,
                          style: textStyleH1,
                          textAlign: TextAlign.center,
                          decoration: getStandardInputDecoration("name", ""),
                          initialValue:
                              groceryListStates.groceryList.name.value,
                          onChanged: (value) {
                            groceryListStates.groceryList.name.value = value;
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
                        initialValue:
                            groceryListStates.groceryList.description.value,
                        onChanged: (value) {
                          groceryListStates.groceryList.description.value =
                              value;
                        },
                      ),
                      Container(height: 20),
                      _Members(
                          members: snapshot.data,
                          groceryListUid: groceryListStates.groceryList.uid),
                      Container(height: 10),
                      BlockPicker(
                        pickerColor: hexToColor(
                            groceryListStates.groceryList.color.value),
                        onColorChanged: (value) => groceryListStates
                            .groceryList.color.value = value.toHex(),
                        availableColors: [
                          mainColor,
                          secondaryColor,
                          accentColor
                        ],
                      ),
                    ],
                  ))),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: ConfirmButton(
                enabled: !appStates.uploadingProfilePicture.value,
                onClick: () async {
                  groceryListStates.updateGroceryList();
                  Get.toNamed(URL_GROCERY_LIST,
                      arguments: groceryListStates.groceryList);
                },
              ),
            );
          else
            return Container(color: Colors.white, child: Loading());
        });
  }

  Future<void> _onEditPicture(context) async {
    final String imgPath = await getImage(
        context, groceryListStates.groceryList.pictureUrl.value != null);
    if (imgPath != null)
      groceryListStates.groceryList.pictureUrl.value = imgPath;
  }
}

class _Members extends StatelessWidget {
  final List<EntityAccount> members;
  final String groceryListUid;

  _Members({@required this.members, @required this.groceryListUid});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SectionTitle(
                icon: Icons.accessibility_outlined,
                text: "WHO CAN ACCESS THIS LIST"),
            Expanded(child: Container()),
            GestureDetector(
              onTap: () async {
                await Share.share(
                    'Hello! I would like to share with you my grocery list from Foodz : ' +
                        await dynamicLink
                            .createGroceryListInvitationLink(groceryListUid));
              },
              child: Icon(Icons.share),
            )
          ],
        ),
        Container(height: 10),
        ListView.builder(
            shrinkWrap: true,
            itemCount: members.length,
            itemBuilder: (BuildContext context, int i) {
              return Center(
                child: AutoSizeText(
                    members[i].uid == authService.auth.currentUser.uid
                        ? "You"
                        : members[i].name),
              );
            })
      ],
    );
  }
}
