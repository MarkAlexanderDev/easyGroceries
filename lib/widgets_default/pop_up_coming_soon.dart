import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/style/text_style.dart';
import 'package:get/get.dart';

import 'confirm_button.dart';

void showPopUpComingSoon(BuildContext context) async {
  await Get.dialog(AlertDialog(
    title: AutoSizeText(
      "Oops, we are currently working on this feature. Please be patient 🙏",
      style: textAssistantH1Black,
      textAlign: TextAlign.center,
    ),
    content: FoodzConfirmButton(
      enabled: true,
      label: "okay",
      onClick: () => Get.back(),
    ),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0))),
  ));
}
