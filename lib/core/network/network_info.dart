import 'package:connectivity_plus/connectivity_plus.dart';

/// Interface for checking network connectivity.
abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<bool> get onConnectivityChanged;
}

/// Implementation of NetworkInfo using connectivity_plus package.
class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl(this._connectivity);
  final Connectivity _connectivity;

  @override
  Future<bool> get isConnected async {
    final result = await _connectivity.checkConnectivity();
    return !result.contains(ConnectivityResult.none);
  }

  @override
  Stream<bool> get onConnectivityChanged {
    return _connectivity.onConnectivityChanged.map(
      (result) => !result.contains(ConnectivityResult.none),
    );
  }
}
