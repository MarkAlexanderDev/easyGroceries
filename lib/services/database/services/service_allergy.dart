import 'package:foodz/services/database/config.dart';
import 'package:foodz/services/database/database.dart';
import 'package:foodz/services/database/models/allergy_model.dart';
import 'package:firebase_database/firebase_database.dart';

class ServiceAllergy {
  Future<List<AllergyModel>> get() async {
    final DataSnapshot snap =
        await databaseReference.child(endpointAllergy).once();
    final List<AllergyModel> allergies = <AllergyModel>[];
    snap.value.forEach((key, value) {
      final AllergyModel allergyModel = AllergyModel();
      allergyModel.fromJson(value);
      allergyModel.name = key;
      allergies.add(allergyModel);
    });
    return allergies;
  }
}
