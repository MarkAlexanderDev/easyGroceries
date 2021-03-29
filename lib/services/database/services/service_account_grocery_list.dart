import 'package:foodz/services/database/config.dart';
import 'package:foodz/services/database/database.dart';
import 'package:foodz/services/database/models/account_grocery_list_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ServiceAccountGroceryList {
  DatabaseReference get() {
    return databaseReference.child(endpointAccountGroceryList);
  }

  Future<void> create(AccountGroceryListModel accountGroceryList) async {
    await get()
        .child(FirebaseAuth.instance.currentUser.uid)
        .child(accountGroceryList.groceryListUid)
        .set(accountGroceryList.toMap());
  }

  delete(String uid) async {
    await get()
        .child(FirebaseAuth.instance.currentUser.uid)
        .child(uid)
        .remove();
  }

  Future<dynamic> getFromUid(String uid) async {
    final DataSnapshot snap = await get().child(uid).once();
    if (snap.value == null) return null;
    return snap;
  }

  Future<dynamic> getFromGroceryListUid(String groceryListuid) async {
    final DataSnapshot snap = await get().orderByChild(groceryListuid).once();
    if (snap.value == null) return null;
    return snap;
  }

  Future<bool> isLinkedToAccount(String groceryListuid) async {
    final DataSnapshot snap = await get()
        .child(FirebaseAuth.instance.currentUser.uid)
        .orderByChild('groceryListUid')
        .equalTo(groceryListuid)
        .once();
    if (snap.value == null) return false;
    return true;
  }
}
