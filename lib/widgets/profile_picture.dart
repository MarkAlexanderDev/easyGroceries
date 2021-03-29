import 'package:foodz/states/app_states.dart';
import 'package:foodz/style/colors.dart';
import 'package:foodz/style/text_style.dart';
import 'package:foodz/widgets/loading.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePicture extends StatelessWidget {
  final double height;
  final double width;
  final String pictureUrl;
  final String name;
  final bool editMode;
  final onEdit;

  ProfilePicture(
      {@required this.height,
      @required this.width,
      @required this.pictureUrl,
      @required this.name,
      @required this.editMode,
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
              decoration:
                  BoxDecoration(color: mainColor, shape: BoxShape.circle),
              child: appStates.uploadingProfilePicture.value == true
                  ? Container(
                      child: Loading(),
                      decoration: BoxDecoration(
                          border: Border.all(color: mainColor, width: 2),
                          shape: BoxShape.circle,
                          color: Colors.white),
                    )
                  : pictureUrl == "" || pictureUrl == null
                      ? name == "" || name == null
                          ? Icon(
                              Icons.person,
                              size: height * 0.70,
                              color: Colors.white,
                            )
                          : Center(
                              child:
                                  AutoSizeText(name[0], style: textStyleLetter))
                      : Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: mainColor, width: 2),
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
                backgroundColor: accentColor,
                radius: 15,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.edit),
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
