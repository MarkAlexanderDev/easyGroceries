import 'package:foodz/services/database/api.dart';
import 'package:get/get.dart';

class CuisinesStates extends GetxController {
  static CuisinesStates get to => Get.find();

  final List<String> cuisines = <String>[];
  Future future;

  @override
  void onInit() {
    future = readAllCuisines();
    super.onInit();
  }

  Future<bool> readAllCuisines() async {
    cuisines.addAll(await API.configurations.cuisines.readAll());
    return true;
  }
}
