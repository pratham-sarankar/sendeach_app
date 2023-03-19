import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthService extends GetxService {
  late final GetStorage _box;

  Future<AuthService> init() async {
    await GetStorage.init();
    _box = GetStorage();
    return this;
  }

  bool get isLoggedIn => _box.read("token") != null;

  Future<void> saveToken(String token) async {
    return await _box.write("token", token);
  }

  String? readToken() {
    return _box.read<String?>("token");
  }

  Future<void> logout() async {
    await _box.write("token", null);
    return;
  }
}
