import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/widgets_default/floating_action_button.dart';
import 'package:foodz/widgets_default/pop_up_coming_soon.dart';

class CookingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FoodzFloatingActionButton(
        label: "Let's cook !",
        icon: Icons.whatshot,
        onPressed: () => showPopUpComingSoon(context));
  }
}
