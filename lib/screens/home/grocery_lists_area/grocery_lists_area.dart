import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/services/dynamic_link.dart';
import 'package:foodz/states/grocery_list_states.dart';
import 'package:foodz/style/text_style.dart';
import 'package:foodz/widgets_common/bubble.dart';
import 'package:foodz/widgets_default/loading.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../urls.dart';
import 'grocery_lists_item.dart';

class GroceryListsArea extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GroceryListsArea();
}

class _GroceryListsArea extends State<GroceryListsArea> {
  final GroceryListStates groceryListStates = Get.find();
  Future futureDynamicLink;

  @override
  void initState() {
    futureDynamicLink = dynamicLink.handleDynamicLinks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureDynamicLink,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData)
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "My grocery lists".toUpperCase(),
                    style: textFredokaOneH2underlined,
                  ),
                ),
                Obx(() => Visibility(
                      visible: groceryListStates.groceryListOwned.length == 0,
                      child: _EmptyGroceryListArea(),
                    )),
                Obx(() => ListView.builder(
                    shrinkWrap: true,
                    itemCount: groceryListStates.groceryListOwned.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int i) {
                      return GroceryListsItem(
                        groceryList: groceryListStates.groceryListOwned[i],
                        onTap: () {
                          groceryListStates.groceryList =
                              groceryListStates.groceryListOwned[i];
                          Get.toNamed(URL_GROCERY_LIST);
                        },
                      );
                    })),
              ],
            );
          else
            return FoodzLoading();
        });
  }
}

class _EmptyGroceryListArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/happy_avocado.png",
              fit: BoxFit.contain,
              height: 75,
            ),
            Bubble(
              content: Column(
                children: [
                  AutoSizeText(
                    "Start by adding\na new grocery list",
                    style: textAssistantH1WhiteBold,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15),
                  Lottie.asset("assets/lotties/arrow_down.json",
                      height: 50, fit: BoxFit.fitHeight),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
