import 'package:shared_preferences/shared_preferences.dart';

// Helper class untuk mengelola penyimpanan data lokal (Session/Preferences) menggunakan package SharedPreferences.
class PreferenceHandler {
  // Variable static untuk menyimpan instance dari SharedPreferences.
  // Instance akan diinisialisasi melalui fungsi init sebelum digunakan aplikasi.
  static SharedPreferences? _prefs;

  // Inisialisasi SharedPreferences.
  // Wajib dipanggil sekali di awal aplikasi (misalnya di main.dart) sebelum membaca/menulis data.
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Key unik yang digunakan untuk menyimpan status login di lokal storage.
  static const _keyIsLogin = "isLogin";

  // Membantu menyimpan status login pengguna (true/false) ke dalam SharedPreferences.
  static Future<void> setLogin(bool isLogin) async {
    final prefs = _prefs ??= await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLogin, isLogin);
  }

  // Getter static untuk mengecek apakah pengguna sudah login atau belum.
  // Mengembalikan value boolean dari key 'isLogin', jika null (belum pernah disimpan) maka default-nya false.
  static bool get isLogin {
    return _prefs?.getBool(_keyIsLogin) ?? false;
  }

  // Fungsi untuk logout. Menghapus key status login dari SharedPreferences.
  static Future<void> logOut() async {
    await _prefs?.remove(_keyIsLogin);
  }
}
