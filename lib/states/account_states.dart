import 'package:foodz/screens/consts.dart';
import 'package:foodz/services/database/database.dart';
import 'package:foodz/services/database/models/account_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AccountStates extends GetxController {
  static AccountStates get to => Get.find();

  Future<void> createAccount(AccountModel newAccount) async {
    account.value = await Database.account.create(newAccount);
  }

  Future<void> getAccount() async {
    if (!FirebaseAuth.instance.currentUser.isNullOrBlank)
      account.value = await Database.account
          .getFromUid(FirebaseAuth.instance.currentUser.uid);
  }

  Future<void> updateAccount() async {
    await Database.account.update(account.value);
  }

  Future<bool> doesAccountExist() async {
    return await Database.account.exist(FirebaseAuth.instance.currentUser.uid);
  }

  String getCookingExperienceConverted(int value) {
    return COOKING_EXPERIENCE_IDS[value];
  }

  Rx<AccountModel> account = AccountModel().obs;
}
