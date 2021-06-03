import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/states/app_states.dart';
import 'package:foodz/style/colors.dart';

import '../widgets_default/loading.dart';

class FoodzIngredientPicture extends StatelessWidget {
  final double height;
  final double width;
  final Image image;

  FoodzIngredientPicture(
      {@required this.height, @required this.width, @required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: mainColor, width: 1)),
        child: appStates.uploadingProfilePicture.value == true
            ? Container(
                child: FoodzLoading(),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              )
            : image == null
                ? Container()
                : Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: image.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ));
  }
}
