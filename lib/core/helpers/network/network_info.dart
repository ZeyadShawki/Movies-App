import 'package:injectable/injectable.dart' as injectable;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

@injectable.Order(-3)
@injectable.Singleton(as: NetworkInfo)
class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl();

  @override
  Future<bool> get isConnected async=>await InternetConnection().hasInternetAccess;
  // Future<bool> get isConnected async => Future(() => true);
}
