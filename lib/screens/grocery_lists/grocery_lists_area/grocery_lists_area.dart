import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/services/dynamic_link.dart';
import 'package:foodz/states/grocery_list_states.dart';
import 'package:foodz/style/colors.dart';
import 'package:foodz/style/text_style.dart';
import 'package:foodz/urls.dart';
import 'package:foodz/widgets_default/loading.dart';
import 'package:get/get.dart';

import 'grocery_lists_item.dart';

class GroceryListsArea extends StatefulWidget {
  @override
  _GroceryListsArea createState() => _GroceryListsArea();
}

class _GroceryListsArea extends State<GroceryListsArea> {
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
                "My grocery lists".toUpperCase(),
                style: textFredokaOneH2underlined,
              ),
              SizedBox(height: 10),
              Obx(() => ListView.builder(
                  shrinkWrap: true,
                  itemCount: groceryListStates.groceryListOwned.length + 1,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int i) {
                    if (i < groceryListStates.groceryListOwned.length)
                      return GroceryListsItem(
                          groceryList: groceryListStates.groceryListOwned[i]);
                    return _AddGroceryListButton(onClick: () {
                      Get.toNamed(URL_GROCERY_LIST_CREATION, arguments: false);
                    });
                  })),
            ],
          );
        else
          return FoodzLoading();
      },
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
