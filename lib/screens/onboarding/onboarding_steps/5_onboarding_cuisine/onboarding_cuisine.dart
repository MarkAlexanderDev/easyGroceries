import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/screens/consts.dart';
import 'package:foodz/states/account_states.dart';
import 'package:foodz/states/cuisines_states.dart';
import 'package:foodz/style/text_style.dart';
import 'package:foodz/widgets/loading.dart';
import 'package:foodz/widgets/selectable_tags.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OnboardingCuisine extends StatefulWidget {
  @override
  _OnboardingCuisine createState() => _OnboardingCuisine();
}

class _OnboardingCuisine extends State<OnboardingCuisine> {
  final AccountStates accountStates = Get.find();
  final CuisinesStates cuisinesStates = Get.put(CuisinesStates());
  Future cuisinesFuture;

  @override
  void initState() {
    cuisinesFuture = cuisinesStates.readAllCuisines();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: cuisinesFuture,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData)
          return ListView(
            shrinkWrap: true,
            children: [
              Lottie.asset('assets/lotties/food-prepared.json', height: 200),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: AutoSizeText(
                  "What are your favorite types${nbsp}of${nbsp}food?",
                  style: textAssistantH1Black,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: EdgeInsets.all(24.0),
                child: SelectableTags(
                  activeTags: accountStates.account.cuisines,
                  tags: cuisinesStates.cuisines,
                  onClickTag: (tag) {
                    if (accountStates.account.cuisines.contains(tag))
                      accountStates.account.cuisines.remove(tag);
                    else
                      accountStates.account.cuisines.add(tag);
                  },
                ),
              ),
            ],
          );
        else
          return Loading();
      },
    );
  }
}
