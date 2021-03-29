import 'package:foodz/services/database/config.dart';
import 'package:foodz/services/database/database.dart';
import 'package:firebase_database/firebase_database.dart';

class ServiceIngredient {
  DatabaseReference get() {
    return databaseReference.child(endpointIngredient);
  }

  Future getIngredient(int ingredientId) async {
    final DataSnapshot snap = await get().child(ingredientId.toString()).once();
    return snap.value;
  }

  Future<List<dynamic>> searchIngredient(String text) async {
    List ingredients = [];
    final DataSnapshot snap = await get()
        .orderByChild('title')
        .startAt(text)
        .endAt(text + '\uf8ff')
        .once();
    if (snap.value.runtimeType.toString() == "List<dynamic>")
      ingredients.addAll(snap.value);
    else
      ingredients.addAll(snap.value.values);
    ingredients.remove(null);
    return ingredients;
  }
}
