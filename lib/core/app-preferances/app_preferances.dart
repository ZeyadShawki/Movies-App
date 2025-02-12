// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: constant_identifier_names

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';


const String TOKEN = 'TOKEN';

@Order(-4)
@LazySingleton()
class AppPreferences {
  SharedPreferences sharedPreferences;
  AppPreferences({
    required this.sharedPreferences,
  });


  Future<void> removeToken() async => await sharedPreferences.remove(TOKEN);
  Future<void> saveToken(String token) async =>
      await sharedPreferences.setString(TOKEN, token);

  String? getToken() => sharedPreferences.getString(TOKEN);


  

}
