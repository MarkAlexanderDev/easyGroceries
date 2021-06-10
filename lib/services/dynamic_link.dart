import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:foodz/states/account_states.dart';
import 'package:foodz/states/grocery_list_states.dart';
import 'package:get/get.dart';

import '../flavors.dart';

class DynamicLink {
  bool groceryListInvitationLinkTriggered = false;

  Future<bool> handleDynamicLinks() async {
    if (!groceryListInvitationLinkTriggered) {
      final PendingDynamicLinkData data =
          await FirebaseDynamicLinks.instance.getInitialLink();
      await handleLinkData(data);
      FirebaseDynamicLinks.instance.onLink(
          onSuccess: (PendingDynamicLinkData dynamicLink) async {
        await handleLinkData(dynamicLink);
      });
      groceryListInvitationLinkTriggered = true;
    }
    return true;
  }

  Future<void> handleLinkData(PendingDynamicLinkData data) async {
    final Uri deepLink = data?.link;
    if (deepLink != null) {
      final GroceryListStates groceryListStates = Get.find();
      await groceryListStates
          .readGroceryList(deepLink.queryParameters["groceryListUid"]);
      await groceryListStates.readAllGroceryListAccounts(
          deepLink.queryParameters["groceryListUid"]);
      if (groceryListStates.groceryListAccounts
              .where((element) =>
                  element.uid == FirebaseAuth.instance.currentUser.uid)
              .length ==
          0) {
        final AccountStates accountStates = Get.find();
        groceryListStates.groceryListOwned.add(groceryListStates.groceryList);
        groceryListStates.createGroceryListAccount(
            FirebaseAuth.instance.currentUser.uid, false);
        groceryListStates.groceryList.peopleNb =
            groceryListStates.groceryList.peopleNb + 1;
        groceryListStates.updateGroceryList();
        accountStates.account.groceryListIds
            .add(groceryListStates.groceryList.uid);
        accountStates.updateAccount(FirebaseAuth.instance.currentUser.uid);
        Get.snackbar("Wouhou!",
            "You have joined " + groceryListStates.groceryList.name.value);
      }
    }
  }

  Future<String> createInvitationLinkGroceryList(String groceryListUid) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: "https://foodz" + F.title + ".page.link",
      link: Uri.parse(
          "https://foodzdev.page.link/post?groceryListUid=$groceryListUid"),
      androidParameters: AndroidParameters(
        packageName: "com.foodz.app." + F.title,
        minimumVersion: 0,
      ),
      dynamicLinkParametersOptions: DynamicLinkParametersOptions(
        shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
      ),
    );
    final link = await parameters.buildUrl();
    final ShortDynamicLink shortenedLink =
        await DynamicLinkParameters.shortenUrl(
      link,
      DynamicLinkParametersOptions(
          shortDynamicLinkPathLength: ShortDynamicLinkPathLength.unguessable),
    );
    return shortenedLink.shortUrl.toString();
  }
}

final DynamicLink dynamicLink = DynamicLink();
