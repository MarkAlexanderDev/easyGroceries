import 'package:foodz/screens/home/contextual_area/contextual_area.dart';
import 'package:foodz/screens/home/grocery_lists/grocery_lists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView(
        shrinkWrap: true,
        children: [ContextualArea(), GroceryLists()],
      ),
    );
  }
}
