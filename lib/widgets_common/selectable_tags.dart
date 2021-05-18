import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:foodz/style/colors.dart';
import 'package:foodz/style/text_style.dart';

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
    return Tags(
      itemCount: tags.length,
      spacing: 12.0,
      runSpacing: 16.0,
      itemBuilder: (int index) {
        return ItemTags(
          key: Key(index.toString()),
          index: index,
          elevation: 0.0,
          title: tags[index],
          active: activeTags.contains(tags[index]),
          textStyle: textAssistantH1BlackBold,
          padding: EdgeInsets.symmetric(horizontal: 7, vertical: 3),
          textActiveColor: Colors.black,
          activeColor: mainColor,
          splashColor: mainColor,
          border: Border.all(color: Colors.grey.withOpacity(0.5)),
          onPressed: (tag) {
            onClickTag(tag.title);
          },
        );
      },
    );
  }
}
