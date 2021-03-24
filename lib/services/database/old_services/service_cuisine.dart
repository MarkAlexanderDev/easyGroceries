import 'package:EasyGroceries/services/database/consts.dart';
import 'package:EasyGroceries/services/database/database.dart';
import 'package:EasyGroceries/services/database/models/cuisine_model.dart';
import 'package:firebase_database/firebase_database.dart';

class ServiceCuisine {
  Future<List<CuisineModel>> get() async {
    final DataSnapshot snap =
        await databaseReference.child(endpointCuisine).once();
    final List<CuisineModel> cuisines = List<CuisineModel>();
    snap.value.forEach((key, value) {
      final CuisineModel cuisineModel = CuisineModel();
      cuisineModel.fromJson(value);
      cuisineModel.name = key;
      cuisines.add(cuisineModel);
    });
    return cuisines;
  }
}
