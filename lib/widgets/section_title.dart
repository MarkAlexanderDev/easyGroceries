import 'package:foodz/style/colors.dart';
import 'package:foodz/style/text_style.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';

class SectionTitle extends StatelessWidget {
  final IconData icon;
  final String text;

  SectionTitle({@required this.icon, this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: mainColor),
        AutoSizeText(
          text,
          style: textStyleH2GreenUnderline,
        ),
      ],
    );
  }
}
