import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';

class Favorites extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Favorites();
}

class _Favorites extends State<Favorites> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AutoSizeText("Favorites screen"),
    );
  }
}
