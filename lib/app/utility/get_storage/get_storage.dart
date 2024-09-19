import 'package:get_storage/get_storage.dart';

class Storage {
  const Storage._();

  static final GetStorage storage = GetStorage();

  static Future<void> saveValue(String key, value) => storage.write(key, value);

  static getValue(String key) => storage.read(key);

  static Future<void> removeValue(String key) => storage.remove(key);

  static Future<void> clearStorage() => storage.erase();
}
