import 'package:EasyGroceries/services/database/config.dart';
import 'package:EasyGroceries/services/database/database.dart';
import 'package:EasyGroceries/services/database/models/account_tag_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AllergyTagsStates extends GetxController {
  static AllergyTagsStates get to => Get.find();

  Future<bool> getTags() async {
    final List tagsAvailable = await API.tag.getTags(endpointTagAllergy);
    final accountTags = await API.accountTag.getFromUid(
        FirebaseAuth.instance.currentUser.uid, endpointAccountTagAllergy);
    tagsStates.clear();
    tagsAvailable.forEach((element) {
      tagsStates.add({"title": element, "active": false, "uid": ""});
    });
    accountTags.forEach((key, value) {
      tagsStates[value["tagId"]]["uid"] = key;
      tagsStates[value["tagId"]]["active"] = true;
    });
    return true;
  }

  setTag(int index, bool active) {
    tagsStates[index]["active"] = active;
  }

  Future<void> updateTags() async {
    for (int i = 0; i < tagsStates.length; i++) {
      if (tagsStates[i]["active"] && tagsStates[i]["uid"] == "") {
        AccountTagModel accountTag = new AccountTagModel();
        accountTag.tagId = i;
        accountTag.createdAt = DateTime.now().toUtc().toString();
        accountTag.updatedAt = DateTime.now().toUtc().toString();
        await API.accountTag.create(accountTag, endpointAccountTagAllergy);
      } else if (!tagsStates[i]["active"] && tagsStates[i]["uid"] != "")
        await API.accountTag
            .delete(endpointAccountTagAllergy, tagsStates[i]["uid"]);
    }
  }

  RxList<dynamic> tagsStates = List<dynamic>().obs;
}

final AllergyTagsStates allergyTagsStates = Get.put(AllergyTagsStates());