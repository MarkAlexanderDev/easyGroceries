import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:foodz/style/colors.dart';
import 'package:foodz/style/text_style.dart';

class Scheduler extends StatelessWidget {
  final String cronExpression;
  final onChangedDays;
  final onChangedTime;

  Scheduler(
      {@required this.cronExpression,
      @required this.onChangedDays,
      @required this.onChangedTime});

  @override
  Widget build(BuildContext context) {
    String minutes = _cronExpressionToMinutes();
    String hours = _cronExpressionToHours();
    final List<int> weekDaysSelected = <int>[];
    cronExpression.split(" ").last.split(",").forEach((String element) {
      if (element != "*") weekDaysSelected.add(int.parse(element));
    });
    return Column(
      children: [
        TextButton(
          onPressed: () async {
            final DateTime result = await DatePicker.showTimePicker(context);
            if (result != null) onChangedTime(result);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(mainColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            ),
          ),
          child: AutoSizeText(
            (hours + ":" + minutes),
            style: textAssistantH1WhiteBold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: _ButtonChooseMany(
              options: ["M", "T", "W", "T", "F", "S", "S"],
              selectedOptions: weekDaysSelected,
              onClick: onChangedDays,
              offset: 1),
        )
      ],
    );
  }

  String _cronExpressionToMinutes() {
    if (cronExpression[1] == " ") return "0" + cronExpression[0];
    return cronExpression.substring(0, 2);
  }

  String _cronExpressionToHours() {
    final cronExpressionWithoutMinutes =
        cronExpression.substring(cronExpression.indexOf(" ") + 1);
    return cronExpressionWithoutMinutes.substring(
        0, cronExpressionWithoutMinutes.indexOf(" "));
  }
}

class _ButtonChooseMany extends StatelessWidget {
  final List<String> options;
  final List<int> selectedOptions;
  final Function onClick;
  final int offset;

  _ButtonChooseMany(
      {@required this.options,
      @required this.selectedOptions,
      @required this.onClick,
      this.offset = 0});

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      for (int i = 0; i < options.length; i++)
        Expanded(
            child: Container(
                decoration: BoxDecoration(
                    color: selectedOptions.contains(i + offset)
                        ? mainColor
                        : Colors.transparent,
                    shape: BoxShape.circle),
                child: TextButton(
                    onPressed: () {
                      onClick((i + offset).toString());
                    },
                    child: Text(
                      options[i],
                      style: TextStyle(
                          color: selectedOptions.contains(i + offset)
                              ? Colors.white
                              : Colors.black),
                    )))),
    ]);
  }
}
