import 'package:flutter/material.dart';
import 'package:foodz/style/colors.dart';
import 'package:foodz/style/text_style.dart';

class FoodzTextInput extends StatelessWidget {
  final String initialValue;
  final double height;
  final onChanged;
  final onClear;
  final TextEditingController _controller = TextEditingController();
  final bool textAlignCenter;
  final bool autofocus;

  FoodzTextInput(
      {@required this.initialValue,
      @required this.onChanged,
      @required this.onClear,
      this.height = 60,
      this.textAlignCenter = true,
      this.autofocus = false});

  @override
  Widget build(BuildContext context) {
    _controller.value = TextEditingValue(text: initialValue);
    return TextField(
      autofocus: autofocus,
      controller: _controller,
      autocorrect: false,
      keyboardType: TextInputType.visiblePassword,
      textAlign: textAlignCenter ? TextAlign.center : TextAlign.start,
      style: textAssistantH1Black,
      decoration: InputDecoration(
        hintStyle: textAssistantH1Black,
        alignLabelWithHint: true,
        labelStyle: textAssistantH1Black,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide(
            color: mainColor.withOpacity(0.5),
          ),
        ),
        suffixIcon: IconButton(
            onPressed: () {
              onClear();
              _controller.clear();
            },
            icon: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5), shape: BoxShape.circle),
              child: Icon(
                Icons.clear,
                color: Colors.white,
                size: 20.0,
              ),
            )),
      ),
      onChanged: onChanged,
    );
  }
}