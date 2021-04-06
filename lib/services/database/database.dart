import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:foodz/services/database/services/service_account_grocery_list.dart';
import 'package:foodz/services/database/services/service_grocery_list.dart';
import 'package:foodz/services/database/services/service_grocery_list_ingredient.dart';

final DatabaseReference databaseReference =
    FirebaseDatabase.instance.reference();
FirebaseStorage firebaseStorage = FirebaseStorage.instance;

class Database {
  static final groceryList = ServiceGroceryList();
  static final accountGroceryList = ServiceAccountGroceryList();
  static final groceryListIngredient = ServiceGroceryListIngredient();
}
