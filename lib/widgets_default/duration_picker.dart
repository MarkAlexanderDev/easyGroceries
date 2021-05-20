import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:foodz/style/text_style.dart';

class FoodzDurationPicker extends StatelessWidget {
  final Duration duration;
  final Function onDurationSelected;

  FoodzDurationPicker(
      {@required this.duration, @required this.onDurationSelected});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.access_time_rounded, size: 15),
          SizedBox(width: 5),
          AutoSizeText(
            duration
                .toString()
                .substring(0, duration.toString().lastIndexOf(":")),
            style: textAssistantH2BlackBold,
          )
        ],
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          ),
          padding: MaterialStateProperty.all(EdgeInsets.all(0.0))),
      onPressed: () => _showDurationPicker(
          context: context,
          onDurationSelected: (Duration duration) =>
              onDurationSelected(duration)),
    );
  }

  void _showDurationPicker(
      {@required BuildContext context, @required onDurationSelected}) {
    Picker(
      adapter: NumberPickerAdapter(data: <NumberPickerColumn>[
        const NumberPickerColumn(begin: 0, end: 999, suffix: Text(' h')),
        const NumberPickerColumn(
            begin: 0, end: 60, suffix: Text(' min'), jump: 15),
      ]),
      delimiter: <PickerDelimiter>[
        PickerDelimiter(
          child: Container(
            width: 30.0,
            alignment: Alignment.center,
            child: Text(":"),
          ),
        )
      ],
      hideHeader: true,
      confirmText: 'ok',
      cancelText: "",
      confirmTextStyle: textAssistantH1Green,
      title: Text(
        'Select duration',
        style: textAssistantH1BlackBold,
      ),
      selectedTextStyle: textAssistantH1Green,
      onConfirm: (Picker picker, List<int> value) {
        onDurationSelected(Duration(
            hours: picker.getSelectedValues()[0],
            minutes: picker.getSelectedValues()[1]));
      },
    ).showDialog(context);
  }
}
