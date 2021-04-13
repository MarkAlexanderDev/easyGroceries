import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:foodz/redirections.dart';
import 'package:foodz/services/database/api.dart';
import 'package:foodz/services/database/entities/grocery_list/entity_grocery_list_account.dart';
import 'package:foodz/urls.dart';
import 'package:get/get.dart';

import '../config.dart';
import 'auth.dart';

class DynamicLink {
  Future handleDynamicLinks() async {
    print("test");
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    await _handleDeepLink(data);
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLinkData) async {
      await _handleDeepLink(dynamicLinkData);
      Get.to(Redirections());
    }, onError: (OnLinkErrorException e) async {
      print("Dynamic Link Failed: " + e.message);
    });
  }

  Future _handleDeepLink(PendingDynamicLinkData data) async {
    final Uri deepLink = data?.link;
    if (deepLink != null &&
        await API.entries.groceryList.accounts.read(
                authService.auth.currentUser.uid,
                key: deepLink.queryParameters["groceryListUid"]) ==
            null) {
      EntityGroceryListAccount groceryListAccount = EntityGroceryListAccount();
      groceryListAccount.uid = deepLink.queryParameters["groceryListUid"];
      groceryListAccount.owner = false;
      groceryListAccount.createdAt = DateTime.now().toString();
      await API.entries.groceryList.accounts.create(groceryListAccount);
      Get.to(Redirections());
    }
  }

  Future<String> createGroceryListInvitationLink(String groceryListUid) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: URL_GROCERY_LIST_INVITATION,
      link: Uri.parse(
          "https://foodz-app.com/post?groceryListUid=" + groceryListUid),
      androidParameters: AndroidParameters(
        packageName: "com.foodz.app." + EnvironmentConfig.FLAVOR,
      ),
    );
    final Uri dynamicUrl = await parameters.buildUrl();
    return dynamicUrl.toString();
  }
}

final DynamicLink dynamicLink = DynamicLink();
