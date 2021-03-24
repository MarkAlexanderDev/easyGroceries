import 'package:EasyGroceries/services/database/consts.dart';
import 'package:EasyGroceries/services/database/database.dart';
import 'package:EasyGroceries/services/database/models/account_cuisine_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ServiceAccountCuisine {
  DatabaseReference get() {
    return databaseReference.child(endpointAccountCuisine);
  }

  Future<void> create(AccountCuisineModel accountCuisineModel) async {
    await get()
        .child(FirebaseAuth.instance.currentUser.uid)
        .child(accountCuisineModel.name)
        .set(true);
  }

  Future<void> delete(String name) async {
    await get()
        .child(FirebaseAuth.instance.currentUser.uid)
        .child(name)
        .remove();
  }

  Future<List<String>> getFromAccountUid(String accountUid) async {
    final DataSnapshot snap = await get().child(accountUid).once();
    if (snap.value == null) return List<String>();
    final Map accountCuisinesSnap = snap.value;
    final List<String> accountCuisines = List<String>();
    accountCuisinesSnap.forEach((key, value) {
      accountCuisines.add(key);
    });
    return accountCuisines;
  }
}
