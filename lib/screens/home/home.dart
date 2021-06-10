import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'contextual_area/contextual_area.dart';
import 'grocery_lists_area/grocery_lists_area.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView(
        shrinkWrap: true,
        children: [ContextualArea(), GroceryListsArea()],
      ),
    );
  }
}
