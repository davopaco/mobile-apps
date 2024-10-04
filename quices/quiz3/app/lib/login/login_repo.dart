import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_storage/get_storage.dart';

class LoginRepository {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final GetStorage _temporalStorage = GetStorage();

  Future<void> storeLongToken(String token) async {
    await _storage.write(key: "jwt", value: token);
  }

  Future<String?> getLongToken() async {
    return await _storage.read(key: "jwt");
  }

  Future<void> removeLongToken() async {
    await _storage.delete(key: "jwt");
  }

  Future<void> storeShortToken(String token) async {
    await _temporalStorage.write("jwt", token);
  }

  Future<String?> getShortToken() async {
    return await _temporalStorage.read("jwt");
  }

  Future<void> removeShortToken() async {
    await _temporalStorage.remove("jwt");
  }
}
