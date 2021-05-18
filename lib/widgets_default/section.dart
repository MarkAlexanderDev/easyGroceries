import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:foodz/style/colors.dart';
import 'package:foodz/style/text_style.dart';

class FoodzSection extends StatelessWidget {
  final IconData icon;
  final String text;
  final Widget placeholder;

  FoodzSection(
      {@required this.icon, @required this.text, @required this.placeholder});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: mainColor),
            AutoSizeText(
              text,
              style: textFredokaOneH3Underlined,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: placeholder,
        ),
      ],
    );
  }
}
