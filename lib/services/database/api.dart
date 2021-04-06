import 'package:foodz/services/database/services/accounts/service_accounts.dart';
import 'package:foodz/services/database/services/allergies/service_allergies.dart';
import 'package:foodz/services/database/services/cuisines/service_cuisines.dart';
import 'package:foodz/services/database/services/ingredients/service_ingredients.dart';

class API {
  static final entries = _Entries();
  static final configurations = _Configurations();
}

class _Entries {
  final accounts = ServiceAccounts();
}

class _Configurations {
  final allergies = ServiceAllergies();
  final cuisines = ServiceCuisines();
  final ingredients = ServiceIngredients();
}
