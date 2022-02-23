import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class StorageService {
  // Create storage
  final storage = const FlutterSecureStorage();
  Future<void> saveString({required String key, required String value}) async {
    await storage.write(key: key, value: value);
  }

  Future<String?> getString(String key) async {
    return await storage.read(key: key);
  }

  Future<void> deleteString(String key) async {
    await storage.delete(key: key);
  }
}
