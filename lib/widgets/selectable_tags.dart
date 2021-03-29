import 'package:foodz/style/colors.dart';
import 'package:foodz/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';

class SelectableTags extends StatelessWidget {
  final List<ItemTags> _items = <ItemTags>[];
  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
  final onClickTag;
  final List tags;

  SelectableTags({@required this.onClickTag, @required this.tags}) {
    for (var i = 0; i < tags.length; i++)
      _items.add(ItemTags(
        index: i,
        title: tags[i].name,
        active: tags[i].active,
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Tags(
      key: _tagStateKey,
      itemCount: _items.length,
      spacing: 12.0,
      runSpacing: 16.0,
      itemBuilder: (int index) {
        final item = _items[index];
        return ItemTags(
          key: Key(index.toString()),
          index: index,
          title: item.title,
          active: _items[index].active,
          textStyle: textStyleTags,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          textActiveColor: Colors.black,
          activeColor: mainColor,
          splashColor: mainColor,
          onPressed: (tag) {
            onClickTag(tag);
          },
        );
      },
    );
  }
}
