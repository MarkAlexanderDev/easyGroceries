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
          clipBehavior: Clip.hardEdge,
          height: 100,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 0.25),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Spacer(),
              ProfilePicture(
                  height: 75,
                  width: 75,
                  pictureUrl: groceryList.pictureUrl.value,
                  editMode: false),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      groceryList.name.value,
                      style: textAssistantH2BlackBold,
                      textAlign: TextAlign.center,
                    ),
                    AutoSizeText(
                      groceryList.description.value,
                      style: textAssistantH2Black,
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.group,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 5),
                        AutoSizeText(
                          "2",
                          style: textAssistantH3Black,
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.refresh,
                          color: Colors.grey,
                        ),
                        AutoSizeText(
                          "Every Monday",
                          style: textAssistantH3Black,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Spacer(),
              Container(
                height: 75,
                width: 35,
                decoration: new BoxDecoration(
                    color: mainColor,
                    borderRadius: new BorderRadius.only(
                        bottomLeft: const Radius.circular(200.0),
                        topLeft: const Radius.circular(200.0))),
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              )
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
