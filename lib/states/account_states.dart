import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodz/services/database/api.dart';
import 'package:foodz/services/database/entities/account/entity_account.dart';
import 'package:foodz/services/local_storage/consts.dart';
import 'package:foodz/services/local_storage/local_storage.dart';
import 'package:get/get.dart';

class AccountStates extends GetxController {
  EntityAccount account = EntityAccount();

  Future<bool> doesAccountExists(String accountId) async {
    return await API.entries.accounts.isExist(accountId);
  }

  String getCookingExperienceConverted(int value) {
    return COOKING_EXPERIENCE_IDS[value];
  }

  void setOnboardingFlag(int value) {
    account.onboardingFlag.value = value;
    localStorage.setIntData(SHARED_PREF_KEY_ONBOARDING_FLAG, value);
  }

  // CRUD

  Future<void> createAccount() async {
    await API.entries.accounts.create(account);
  }

  Future<void> readAccount(String accountId) async {
    account = await API.entries.accounts.read(accountId);
    if (account.onboardingFlag.value == 0) account.onboardingFlag.value = 1;
    updateAccount(FirebaseAuth.instance.currentUser.uid);
  }

  Future<void> updateAccount(String uid) async {
    await API.entries.accounts.update(uid, account);
  }

  void deleteAccount() {
    API.entries.accounts.delete(FirebaseAuth.instance.currentUser.uid);
  }
}

const List<String> COOKING_EXPERIENCE_IDS = [
  "Beginner",
  "Advanced cook",
  "Chef"
];

const COOKING_EXPERIENCE_ID_BEGINNER = 0;
const COOKING_EXPERIENCE_ID_ADVANCED = 1;
const COOKING_EXPERIENCE_ID_CHEF = 2;
