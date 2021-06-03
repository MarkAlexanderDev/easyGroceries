import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Rater extends StatelessWidget {
  final int currentGrade;

  Rater({@required this.currentGrade});

  @override
  Widget build(BuildContext context) {
    return Container();
    /*return SizedBox(
      width: 125,
      height: 50,
      child: ListView.builder(
        itemCount: 5,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          if (currentGrade <= index)
            return Icon(Icons.star_border, color: mainColor);
          return Icon(Icons.star, color: mainColor);
        },
      ),
    );*/
  }
}
