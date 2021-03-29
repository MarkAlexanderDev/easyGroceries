import 'package:foodz/services/database/services/service_account.dart';
import 'package:foodz/services/database/services/service_account_allergy.dart';
import 'package:foodz/services/database/services/service_account_cuisine.dart';
import 'package:foodz/services/database/services/service_account_grocery_list.dart';
import 'package:foodz/services/database/services/service_allergy.dart';
import 'package:foodz/services/database/services/service_cuisine.dart';
import 'package:foodz/services/database/services/service_grocery_list.dart';
import 'package:foodz/services/database/services/service_grocery_list_ingredient.dart';
import 'package:foodz/services/database/services/service_ingredient.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

final DatabaseReference databaseReference =
    FirebaseDatabase.instance.reference();
FirebaseStorage firebaseStorage = FirebaseStorage.instance;

class Database {
  static final account = ServiceAccount();
  static final groceryList = ServiceGroceryList();
  static final accountGroceryList = ServiceAccountGroceryList();
  static final groceryListIngredient = ServiceGroceryListIngredient();
  static final ingredient = ServiceIngredient();
  static final allergy = ServiceAllergy();
  static final cuisine = ServiceCuisine();
  static final accountAllergy = ServiceAccountAllergy();
  static final accountCuisine = ServiceAccountCuisine();
}
