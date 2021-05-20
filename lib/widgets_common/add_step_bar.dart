import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/style/colors.dart';
import 'package:foodz/style/text_style.dart';
import 'package:get/get.dart';

import '../urls.dart';

class AddStepBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(URL_STEP_CREATION),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: accentColor,
            border: Border.all(color: Colors.orange, width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Text("Click here to add an instruction",
                  style:
                      textAssistantH3BlackBold.copyWith(color: Colors.orange)),
              Expanded(child: Container()),
              Icon(
                Icons.add,
                color: Colors.orange,
              )
            ],
          ),
        ),
      ),
    );
  }
}
