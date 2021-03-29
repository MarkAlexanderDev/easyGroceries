import 'package:foodz/services/database/config.dart';
import 'package:foodz/services/database/database.dart';
import 'package:foodz/services/database/models/account_allergy_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ServiceAccountAllergy {
  DatabaseReference get() {
    return databaseReference.child(endpointAccountAllergy);
  }

  Future<void> create(AccountAllergyModel accountAllergyModel) async {
    await get()
        .child(FirebaseAuth.instance.currentUser.uid)
        .child(accountAllergyModel.name)
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
    if (snap.value == null) return <String>[];
    final List<String> accountAllergies = <String>[];
    snap.value.forEach((key, value) {
      accountAllergies.add(key);
    });
    return accountAllergies;
  }
}
