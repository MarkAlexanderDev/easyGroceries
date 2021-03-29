import 'package:foodz/services/database/database.dart';
import 'package:foodz/services/database/models/account_cuisine_model.dart';
import 'package:foodz/services/database/models/cuisine_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CuisineStates extends GetxController {
  static CuisineStates get to => Get.find();

  Future<bool> getCuisines() async {
    if (cuisines.isEmpty) {
      cuisines.assignAll(await Database.cuisine.get());
      final List<String> accountCuisines = await Database.accountCuisine
          .getFromAccountUid(FirebaseAuth.instance.currentUser.uid);
      for (int i = 0; i < cuisines.length; i++)
        if (accountCuisines.contains(cuisines[i].name)) {
          cuisines[i].active = true;
          cuisines[i].wasActivated = true;
        }
    }
    return true;
  }

  setTag(int index, bool active) {
    cuisines[index].active = active;
  }

  Future<void> updateCuisines() async {
    for (int i = 0; i < cuisines.length; i++) {
      if (cuisines[i].active && !cuisines[i].wasActivated) {
        AccountCuisineModel accountCuisineModel = AccountCuisineModel();
        accountCuisineModel.name = cuisines[i].name;
        await Database.accountCuisine.create(accountCuisineModel);
        cuisines[i].wasActivated = true;
      } else if (!cuisines[i].active && cuisines[i].wasActivated) {
        await Database.accountCuisine.delete(cuisines[i].name);
        cuisines[i].wasActivated = false;
      }
    }
  }

  RxList<CuisineModel> cuisines = <CuisineModel>[].obs;
}
