import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FoodzPeopleSelector extends StatelessWidget {
  final int peopleNumber;
  final onTap;

  FoodzPeopleSelector({@required this.peopleNumber, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
        ),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () => onTap(index),
              child: Opacity(
                  opacity: index < peopleNumber ? 1 : 0.1,
                  child: Image.asset("assets/images/man.png")));
        });
  }
}
