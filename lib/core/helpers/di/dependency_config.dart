import 'dependency_config.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
@pragma("vm:entry-point")

final getIt = GetIt.instance;
@injectableInit
Future<void> configureDependencies() async => await getIt.init();
