import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moovy/core/constants/key_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

final localStorageServiceProvider = Provider<LocalStorageService>((ref)=>throw UnimplementedError());

class LocalStorageService{
  final SharedPreferences sharedPreferences;
  LocalStorageService(this.sharedPreferences);

  Future<void> setToken(String token)async{
    await sharedPreferences.setString(KeyConstants.TOKEN, token);
  }

  String get token=>sharedPreferences.getString(KeyConstants.TOKEN)??"";
}