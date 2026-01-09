import 'package:get_storage/get_storage.dart';

class AppStorage {
  static final GetStorage _box = GetStorage();

  static Future<void> init() async {
    await GetStorage.init();
  }

  // ================= TOKENS =================
  static String? get accessToken => _box.read('access');
  static String? get refreshToken => _box.read('refresh');

  static bool get isLoggedIn => accessToken != null;

  static Future<void> saveTokens({
    required String access,
    required String refresh,
  }) async {
    await _box.write('access', access);
    await _box.write('refresh', refresh);
  }

  static Future<void> clear() async {
    await _box.erase();
  }
}
