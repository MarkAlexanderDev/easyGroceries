import 'package:foodz/services/database/api.dart';
import 'package:get/get.dart';

class CuisinesStates extends GetxController {
  final List<String> cuisines = <String>[];

  Future<bool> readAllCuisines() async {
    if (cuisines.isEmpty)
      cuisines.addAll(await API.configurations.cuisines.readAll());
    return true;
  }
}
