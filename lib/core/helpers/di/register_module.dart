// ignore_for_file: invalid_annotation_target

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  @Order(-4)
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
