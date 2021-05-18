import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/states/app_states.dart';
import 'package:foodz/style/colors.dart';
import 'package:get/get.dart';

import '../widgets_default/loading.dart';

class FoodzProfilePicture extends StatelessWidget {
  final double height;
  final double width;
  final String pictureUrl;
  final bool editMode;
  final Widget defaultChild;
  final onEdit;

  FoodzProfilePicture(
      {@required this.height,
      @required this.width,
      @required this.pictureUrl,
      @required this.editMode,
      @required this.defaultChild,
      this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: Stack(
        children: <Widget>[
          Obx(() => Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: mainColor, width: 1)),
              child: appStates.uploadingProfilePicture.value == true
                  ? Container(
                      child: FoodzLoading(),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                    )
                  : pictureUrl == "" || pictureUrl == null
                      ? defaultChild
                      : Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(pictureUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ))),
          Visibility(
            visible: editMode,
            child: Align(
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                backgroundColor: mainColor,
                radius: 15,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.edit,
                    size: height / 6,
                  ),
                  color: Colors.white,
                  onPressed: () async {
                    await onEdit();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
