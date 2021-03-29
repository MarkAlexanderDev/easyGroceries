import 'package:foodz/services/database/config.dart';
import 'package:foodz/services/database/database.dart';
import 'package:foodz/services/database/models/account_model.dart';
import 'package:firebase_database/firebase_database.dart';

class ServiceAccount {
  DatabaseReference get() {
    return databaseReference.child(endpointAccount);
  }

  Future<AccountModel> create(AccountModel account) async {
    var id = get().child(account.uid);
    await id.set(account.toMap());
    return account;
  }

  Future<void> update(AccountModel account) async {
    var id = get().child(account.uid);
    await id.update(account.toMap());
  }

  Future<AccountModel> getFromUid(String uid) async {
    AccountModel account = AccountModel();
    final DataSnapshot snap = await get().child(uid).once();
    if (snap.value != null) {
      account.fromJson(snap.value);
      account.uid = uid;
      return account;
    }
    return null;
  }

  Future<bool> exist(String uid) async {
    final DataSnapshot snap = await get().child(uid).once();
    if (snap.value == null) return false;
    return true;
  }
}
