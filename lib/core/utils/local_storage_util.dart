import 'package:moovy/core/constants/key_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomSharedPreference {
  static SharedPreferences? _sharedPrefs;

  init() async {
    if (_sharedPrefs == null) {
      _sharedPrefs = await SharedPreferences.getInstance();
    }
  }

  String get token => _sharedPrefs!.getString(KeyConstants.TOKEN) ?? "";

  setToken(String token) {
    _sharedPrefs!.setString(KeyConstants.TOKEN, token);
  }


}

final customSharedPreference = CustomSharedPreference();