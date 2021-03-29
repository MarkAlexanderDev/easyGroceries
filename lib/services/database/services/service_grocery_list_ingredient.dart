import 'package:foodz/services/database/config.dart';
import 'package:foodz/services/database/database.dart';
import 'package:foodz/services/database/models/grocery_list_ingredient_model.dart';
import 'package:firebase_database/firebase_database.dart';

class ServiceGroceryListIngredient {
  DatabaseReference get() {
    return databaseReference.child(endpointGroceryListIngredient);
  }

  Future<void> create(String name,
      GroceryListIngredientModel groceryListIngredient, String uid) async {
    await get().child(uid).child(name).set(groceryListIngredient.toMap());
  }

  Future<void> update(GroceryListIngredientModel groceryListIngredient,
      String ingredientUid, String listUid) async {
    await get()
        .child(listUid)
        .child(ingredientUid)
        .update(groceryListIngredient.toMap());
  }

  Future<void> delete(String ingredient, String listUid) async {
    await get().child(listUid).child(ingredient).remove();
  }

  Future<dynamic> getFromUid(String uid) async {
    final DataSnapshot snap = await get().child(uid).once();
    if (snap.value == null) return null;
    return snap;
  }
}
