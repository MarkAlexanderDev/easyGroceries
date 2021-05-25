import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:foodz/style/colors.dart';
import 'package:foodz/style/text_style.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class SelectableTags extends StatelessWidget {
  final List<String> activeTags;
  final List<String> tags;
  final onClickTag;

  SelectableTags(
      {@required this.activeTags,
      @required this.tags,
      @required this.onClickTag});

  @override
  Widget build(BuildContext context) {
    activeTags.sort();
    return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: (MediaQuery.of(context).size.height * 0.003)),
        itemCount: tags.length,
        itemBuilder: (BuildContext context, int i) {
          return Padding(
            padding: const EdgeInsets.all(6.0),
            child: Obx(() => OutlinedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        activeTags.contains(tags[i])
                            ? mainColor
                            : Colors.transparent),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                    ),
                    padding: MaterialStateProperty.all(EdgeInsets.all(0.0))),
                onPressed: () => onClickTag(tags[i]),
                child: AutoSizeText(
                  tags[i],
                  style: textAssistantH2BlackBold,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ))),
          );
        });
  }
}
