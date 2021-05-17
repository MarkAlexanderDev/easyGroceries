import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:foodz/services/database/api.dart';
import 'package:foodz/services/database/entities/grocery_list/entity_grocery_list_account.dart';
import 'package:foodz/states/account_states.dart';
import 'package:foodz/states/grocery_list_states.dart';
import 'package:foodz/urls.dart';
import 'package:get/get.dart';

import '../flavors.dart';
import 'auth.dart';

class DynamicLink {
  final AccountStates accountStates = Get.find();
  final GroceryListStates groceryStates = Get.find();

  Future<bool> handleDynamicLinks() async {
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    await _handleDeepLink(data);
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLinkData) async {
      await _handleDeepLink(dynamicLinkData);
    }, onError: (OnLinkErrorException e) async {
      print("Dynamic Link Failed: " + e.message);
    });
    return true;
  }

  Future<void> _handleDeepLink(PendingDynamicLinkData data) async {
    final Uri deepLink = data?.link;
    if (deepLink != null &&
        await API.entries.groceryList.accounts.read(
                authService.auth.currentUser.uid,
                key: deepLink.queryParameters["groceryListUid"]) ==
            null) {
      EntityGroceryListAccount groceryListAccount = EntityGroceryListAccount();
      groceryListAccount.uid = accountStates.account.uid;
      groceryListAccount.owner = false;
      groceryListAccount.createdAt = DateTime.now().toString();
      await API.entries.groceryList.accounts.create(groceryListAccount,
          key: deepLink.queryParameters["groceryListUid"]);
      accountStates.account.groceryListIds
          .add(deepLink.queryParameters["groceryListUid"]);
      groceryStates.groceryListOwned.add(await API.entries.groceryList
          .read(deepLink.queryParameters["groceryListUid"]));
      await accountStates.updateAccount();
    }
  }

  Future<String> createGroceryListInvitationLink(String groceryListUid) async {
    print(F.appFlavor.toString());
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: URL_GROCERY_LIST_INVITATION,
      link: Uri.parse(
          "https://foodz-app.com/post?groceryListUid=" + groceryListUid),
      androidParameters: AndroidParameters(
        packageName: "com.foodz.app." + F.appFlavor.toString(),
        minimumVersion: 0,
      ),
      dynamicLinkParametersOptions: DynamicLinkParametersOptions(
        shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
      ),
    );
    final Uri dynamicUrl = await parameters.buildUrl();
    return dynamicUrl.toString();
  }
}

final DynamicLink dynamicLink = DynamicLink();
