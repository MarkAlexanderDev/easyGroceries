import 'package:foodz/screens/redirections.dart';
import 'package:foodz/services/database/database.dart';
import 'package:foodz/services/database/models/account_grocery_list_model.dart';
import 'package:foodz/urls.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';

class DynamicLink {
  Future handleDynamicLinks() async {
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
        !await Database.accountGroceryList
            .isLinkedToAccount(deepLink.queryParameters["groceryListUid"])) {
      AccountGroceryListModel accountGroceryList = AccountGroceryListModel();
      accountGroceryList.groceryListUid =
          deepLink.queryParameters["groceryListUid"];
      accountGroceryList.owner = false;
      await Database.accountGroceryList.create(accountGroceryList);
      Get.to(Redirections());
    }
  }

  Future<String> createGroceryListInvitationLink(String groceryListUid) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: URL_GROCERY_LIST_INVITATION,
      link: Uri.parse(
          "https://foodz-app.com/post?groceryListUid=" + groceryListUid),
      androidParameters: AndroidParameters(
        packageName: "com.foodz.foodz",
      ),
    );
    final Uri dynamicUrl = await parameters.buildUrl();
    return dynamicUrl.toString();
  }
}

final DynamicLink dynamicLink = DynamicLink();
