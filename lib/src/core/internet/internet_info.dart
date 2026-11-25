import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

abstract class InternetInfo {
  Future<bool> get isConnected;

  /// True when the device is on Wi‑Fi (not mobile data).
  Future<bool> get isOnWifi;
}

@LazySingleton(as: InternetInfo)
class InternetInfoImpl implements InternetInfo {
  InternetInfoImpl(Connectivity connectivity) : _connectivity = connectivity;
  final Connectivity _connectivity;

  @override
  Future<bool> get isConnected => _requestConnection(_connectivity);

  @override
  Future<bool> get isOnWifi async {
    final result = await _connectivity.checkConnectivity();
    return result.contains(ConnectivityResult.wifi) ||
        result.contains(ConnectivityResult.ethernet);
  }

  Future<bool> _requestConnection(Connectivity connectivity) async {
    var connectivityResult = await (connectivity.checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return true;
    } else {
      return false;
    }
  }
}
