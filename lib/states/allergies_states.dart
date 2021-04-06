import 'package:foodz/services/database/api.dart';
import 'package:get/get.dart';

class AllergiesStates extends GetxController {
  static AllergiesStates get to => Get.find();

  final List<String> allergies = <String>[];
  Future future;

  @override
  void onInit() {
    future = readAllAllergies();
    super.onInit();
  }

  Future<bool> readAllAllergies() async {
    allergies.addAll(await API.configurations.allergies.readAll());
    return true;
  }
}
