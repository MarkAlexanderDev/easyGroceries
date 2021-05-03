import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/services/database/entities/grocery_list/entity_grocery_list.dart';
import 'package:foodz/services/dynamic_link.dart';
import 'package:foodz/states/grocery_list_states.dart';
import 'package:foodz/style/colors.dart';
import 'package:foodz/style/text_style.dart';
import 'package:foodz/urls.dart';
import 'package:foodz/widgets/loading.dart';
import 'package:foodz/widgets/profile_picture.dart';
import 'package:get/get.dart';

class GroceryLists extends StatefulWidget {
  @override
  _GroceryLists createState() => _GroceryLists();
}

class _GroceryLists extends State<GroceryLists> {
  final GroceryListStates groceryListStates = Get.find();
  Future dynamicLinkGroceryList;

  @override
  void initState() {
    dynamicLinkGroceryList = dynamicLink.handleDynamicLinks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: dynamicLinkGroceryList,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData)
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "My groceries list".toUpperCase(),
                style: textFredokaOneH2underlined,
              ),
              SizedBox(height: 10),
              Obx(() => ListView.builder(
                  shrinkWrap: true,
                  itemCount: groceryListStates.groceryListOwned.length + 1,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int i) {
                    if (i < groceryListStates.groceryListOwned.length)
                      return _GroceryListsItem(
                          groceryList: groceryListStates.groceryListOwned[i]);
                    return _AddGroceryListButton(onClick: () {
                      Get.toNamed(URL_GROCERY_LIST_CREATION);
                    });
                  })),
            ],
          );
        else
          return Loading();
      },
    );
  }
}

class _GroceryListsItem extends StatelessWidget {
  final EntityGroceryList groceryList;
  final GroceryListStates groceryListStates = Get.find();

  _GroceryListsItem({@required this.groceryList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          groceryListStates.groceryList = groceryList;
          Get.offNamed(URL_GROCERY_LIST);
        },
        child: Container(
          height: 100,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 0.25),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ProfilePicture(
                  height: 75,
                  width: 75,
                  pictureUrl: groceryList.pictureUrl.value,
                  editMode: false),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: AutoSizeText(
                  groceryList.name.value,
                  style: textAssistantH1Black,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddGroceryListButton extends StatelessWidget {
  final onClick;

  _AddGroceryListButton({@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        GestureDetector(
          onTap: () async {
            await onClick();
          },
          child: Icon(
            Icons.add_circle_outlined,
            color: mainColor,
            size: 50,
          ),
        ),
      ],
    );
  }
}
