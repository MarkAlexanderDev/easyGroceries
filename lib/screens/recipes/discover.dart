import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';

class Discover extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Discover();
}

class _Discover extends State<Discover> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AutoSizeText("Discover screen"),
    );
  }
}
