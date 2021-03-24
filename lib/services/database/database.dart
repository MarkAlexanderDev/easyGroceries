import 'package:EasyGroceries/services/database/services/entries/service_account.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

class Database {
  static final entries = _Entries();
  static final configurations = _Configurations();
}

class _Entries {
  final accounts = ServiceAccount();
}

class _Configurations {
  //
}
