import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/style/colors.dart';
import 'package:foodz/style/text_style.dart';

class StepItem extends StatelessWidget {
  final int number;
  final String text;
  final Function onDelete;

  StepItem(
      {@required this.number, @required this.text, @required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: () => _modalBottomSheetMenu(context),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 0.05),
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: mainColor, width: 1)),
                  child: Center(
                    child: AutoSizeText(
                      number.toString(),
                      style: textFredokaOneH1,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                    child: AutoSizeText(text, style: textAssistantH2BlackBold))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _modalBottomSheetMenu(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Column(
            children: [
              Container(
                width: 20,
                height: 5,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
              ),
              SizedBox(height: 5),
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0))),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: mainColor, width: 1)),
                              child: Center(
                                child: AutoSizeText(
                                  number.toString(),
                                  style: textFredokaOneH1,
                                ),
                              ),
                            ),
                            Text(
                              text,
                              style: textAssistantH1Black,
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  onDelete();
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
              ),
            ],
          );
        });
  }
}
