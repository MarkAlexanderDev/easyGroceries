import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';

class MyRecipes extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyRecipes();
}

class _MyRecipes extends State<MyRecipes> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AutoSizeText("My recipes screen"),
    );
  }
}
