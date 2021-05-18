import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/states/app_states.dart';
import 'package:foodz/style/colors.dart';
import 'package:foodz/style/text_style.dart';
import 'package:get/get.dart';

import '../urls.dart';

const HOME_SCREEN_ID = 0;
const FRIDGE_SCREEN_ID = 1;
const RECIPE_SCREEN_ID = 2;

class NavBar extends StatelessWidget {
  final int barHeight;
  final sizeIcon;
  final AppStates appStates = Get.put(AppStates());

  NavBar({this.barHeight, this.sizeIcon});

  @override
  Widget build(BuildContext context) {
    return Obx(() => BottomNavigationBar(
          selectedFontSize: sizeIcon,
          unselectedFontSize: sizeIcon,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          currentIndex: appStates.indexBar.value,
          selectedLabelStyle: textAssistantH3BlackBold,
          unselectedLabelStyle: textAssistantH3BlackBold,
          selectedItemColor: mainColor,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            appStates.indexBar.value = index;
            Get.toNamed(URL_HOME);
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.kitchen), label: "Fridge"),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: "Recipes"),
          ],
        ));
  }
}
