import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/services/database/entities/grocery_list/entity_grocery_list.dart';
import 'package:foodz/states/grocery_list_states.dart';
import 'package:foodz/style/colors.dart';
import 'package:foodz/style/text_style.dart';
import 'package:foodz/urls.dart';
import 'package:foodz/utils/color.dart';
import 'package:foodz/widgets/loading.dart';
import 'package:get/get.dart';

class GroceryLists extends StatefulWidget {
  @override
  _GroceryLists createState() => _GroceryLists();
}

class _GroceryLists extends State<GroceryLists> {
  GroceryListStates groceryListStates = Get.put(GroceryListStates());
  Future groceryListsFuture;

  @override
  void initState() {
    groceryListStates.groceryList = Get.arguments();
    groceryListsFuture = groceryListStates.readAllGroceryListAccounts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: groceryListsFuture,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.length + 1,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                ),
                itemBuilder: (BuildContext context, int i) {
                  if (i < snapshot.data.length)
                    return _GroceryListsItem(groceryList: snapshot.data[i]);
                  return _AddGroceryListButton(
                      onClick: () => Get.toNamed(URL_GROCERY_LIST_CREATION));
                });
          } else
            return Loading();
        });
  }
}

class _GroceryListsItem extends StatelessWidget {
  final EntityGroceryList groceryList;

  _GroceryListsItem({@required this.groceryList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => Get.offNamed(URL_GROCERY_LIST, arguments: groceryList),
        child: Container(
          decoration: BoxDecoration(
              color: hexToColor(groceryList.color.value),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            children: [
              Flexible(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          groceryList.name.value,
                          style: textStyleH3Bold,
                          textAlign: TextAlign.center,
                        ),
                        AutoSizeText(groceryList.description.value,
                            textAlign: TextAlign.center, style: textStyleH4),
                      ]),
                ),
              ),
              Flexible(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    image: DecorationImage(
                      image: NetworkImage(groceryList.pictureUrl.value),
                      fit: BoxFit.cover,
                    ),
                  ),
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
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: GestureDetector(
        onTap: () async {
          await onClick();
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: mainColor),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Icon(
            Icons.add,
            color: mainColor,
            size: 50,
          ),
        ),
      ),
    );
  }
}
