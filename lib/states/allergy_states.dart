import 'package:foodz/services/database/database.dart';
import 'package:foodz/services/database/models/account_allergy_model.dart';
import 'package:foodz/services/database/models/allergy_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AllergyTagsStates extends GetxController {
  static AllergyTagsStates get to => Get.find();

  Future<bool> getAllergies() async {
    if (allergies.isEmpty) {
      allergies.assignAll(await Database.allergy.get());
      final List<String> accountAllergies = await Database.accountAllergy
          .getFromAccountUid(FirebaseAuth.instance.currentUser.uid);
      for (int i = 0; i < allergies.length; i++)
        if (accountAllergies.contains(allergies[i].name)) {
          allergies[i].active = true;
          allergies[i].wasActivated = true;
        }
    }
    return true;
  }

  setTag(int index, bool active) {
    allergies[index].active = active;
  }

  Future<void> updateAllergies() async {
    for (int i = 0; i < allergies.length; i++) {
      if (allergies[i].active && !allergies[i].wasActivated) {
        AccountAllergyModel accountAllergyModel = AccountAllergyModel();
        accountAllergyModel.name = allergies[i].name;
        await Database.accountAllergy.create(accountAllergyModel);
        allergies[i].wasActivated = true;
      } else if (!allergies[i].active && allergies[i].wasActivated) {
        await Database.accountAllergy.delete(allergies[i].name);
        allergies[i].wasActivated = false;
      }
    }
  }

  RxList<AllergyModel> allergies = <AllergyModel>[].obs;
}
