import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodz/redirections.dart';
import 'package:foodz/screens/home/grocery_list_creation.dart';
import 'package:foodz/screens/home/grocery_lists_area/grocery_list/grocery_list.dart';
import 'package:foodz/screens/home/grocery_lists_area/grocery_list/grocery_list_options/grocery_list_options.dart';
import 'package:foodz/screens/home/grocery_lists_area/grocery_list/grocery_list_search_ingredient.dart';
import 'package:foodz/screens/profile/profile.dart';
import 'package:foodz/states/states_binding.dart';
import 'package:foodz/style/colors.dart';
import 'package:foodz/urls.dart';
import 'package:get/get.dart';

void appInitialisation() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.fade,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.light(
            primary: mainColor,
          ),
          unselectedWidgetColor: mainColor,
          primaryColor: mainColor),
      getPages: [
        GetPage(
          name: URL_HOME,
          page: () => AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                systemNavigationBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark,
                systemNavigationBarIconBrightness: Brightness.dark,
              ),
              child: Redirections()),
          binding: StatesBinding(),
        ),
        GetPage(name: URL_PROFILE, page: () => Profile()),
        GetPage(name: URL_GROCERY_LIST, page: () => GroceryList()),
        GetPage(name: URL_GROCERY_LIST_OPTION, page: () => GroceryListOption()),
        GetPage(
            name: URL_GROCERY_LIST_CREATION, page: () => GroceryListCreation()),
        GetPage(
            name: URL_GROCERY_LIST_SEARCH_INGREDIENT,
            page: () => GroceryListSearchIngredient()),
      ],
    );
  }
}
