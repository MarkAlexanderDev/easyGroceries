import 'package:foodz/states/app_states.dart';
import 'package:foodz/style/colors.dart';
import 'package:foodz/style/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const HOME_SCREEN_ID = 0;
const FAV_RECIPE_SCREEN_ID = 1;

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
          selectedLabelStyle: textStyleH1Green,
          unselectedLabelStyle: textStyleH1,
          selectedItemColor: mainColor,
          onTap: (index) => {appStates.setIndexBar(index)},
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.kitchen), label: ""),
          ],
        ));
  }
}
