import 'package:foodz/services/database/api.dart';
import 'package:get/get.dart';

class AllergiesStates extends GetxController {
  final List<String> allergies = <String>[];

  Future<bool> readAllAllergies() async {
    if (allergies.isEmpty)
      allergies.addAll(await API.configurations.allergies.readAll());
    return true;
  }
}
