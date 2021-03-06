import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/services/database/entities/grocery_list/entity_grocery_list.dart';
import 'package:foodz/states/grocery_list_states.dart';
import 'package:foodz/style/colors.dart';
import 'package:foodz/style/text_style.dart';
import 'package:foodz/widgets_common/profile_picture.dart';
import 'package:get/get.dart';

class GroceryListsItem extends StatefulWidget {
  final EntityGroceryList groceryList;
  final Function onTap;

  GroceryListsItem({@required this.groceryList, @required this.onTap});

  @override
  State<StatefulWidget> createState() =>
      _GroceryListsItem(groceryList: groceryList, onTap: onTap);
}

class _GroceryListsItem extends State<GroceryListsItem> {
  final EntityGroceryList groceryList;
  final GroceryListStates groceryListStates = Get.find();
  final List<int> weekDays = <int>[];
  final Function onTap;

  _GroceryListsItem({@required this.groceryList, this.onTap});

  @override
  void initState() {
    if (groceryList.cronReminder.value.isNotEmpty)
      groceryList.cronReminder.value
          .split(" ")
          .last
          .split(",")
          .forEach((String element) {
        if (element != "*") weekDays.add(int.parse(element));
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => onTap(),
        child: Container(
          clipBehavior: Clip.hardEdge,
          height: 100,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 0.25),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FoodzProfilePicture(
                      height: 75,
                      width: 75,
                      pictureUrl: groceryList.pictureUrl.value,
                      editMode: false,
                      defaultChild: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.asset("assets/images/appIcon.png"),
                      ),
                    ),
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
                            groceryList.description,
                            style: textAssistantH2Black,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 20,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.group,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                SizedBox(width: 5),
                                AutoSizeText(
                                  groceryList.peopleNb.toString(),
                                  style: textAssistantH3Black,
                                  maxLines: 3,
                                ),
                                SizedBox(width: 15),
                                Visibility(
                                  visible:
                                      groceryList.cronReminder.value.isNotEmpty,
                                  child: Icon(
                                    Icons.notifications_active,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: Text(
                                    _getFormatedWeekDays(weekDays),
                                    style: textAssistantH3Black,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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

  String _getFormatedWeekDays(List<int> weekDays) {
    final List<String> weekDaysNames = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday"
    ];
    String result = "";
    weekDays.sort();
    for (int i = 0; i < weekDays.length; i++) {
      if (i != 0) result += " ";
      if (i == weekDays.length - 1 && i != 0) result += "& ";
      result += weekDaysNames[weekDays[i] - 1];
    }
    return result;
  }
}
