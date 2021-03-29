import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  SharedPreferences data;

  init() async {
    data = await SharedPreferences.getInstance();
  }

  int getIntData(key) {
    return data.getInt(key) == null ? 0 : data.getInt(key);
  }

  Future<void> setIntData(key, value) async {
    await data.setInt(key, value);
  }

  double getDoubleData(key) {
    return data.getDouble(key) == null ? 0.0 : data.getDouble(key);
  }

  Future<void> setDoubleData(key, value) async {
    await data.setDouble(key, value);
  }

  bool getBoolData(key) {
    return data.getBool(key) == null ? false : data.getBool(key);
  }

  Future<void> setBoolData(key, value) async {
    await data.setBool(key, value);
  }

  String getStringData(key) {
    return data.getString(key) == null ? "" : data.getString(key);
  }

  Future<void> setStringData(key, value) async {
    await data.setString(key, value);
  }

  List<String> getStringListData(key) {
    return data.getStringList(key) == null
        ? <String>[]
        : data.getStringList(key);
  }

  Future<void> setStringListData(key, value) async {
    await data.setStringList(key, value);
  }

  Future<void> eraseData() async {
    await data.clear();
  }
}

LocalStorage localStorage = new LocalStorage();
