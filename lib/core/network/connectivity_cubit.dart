import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mvvm_boilerplate/core/network/connectivity_state.dart';
import 'package:flutter_mvvm_boilerplate/core/network/network_info.dart';
import 'package:injectable/injectable.dart';

/// Cubit for monitoring network connectivity.
///
/// Add this to your root BlocProvider to monitor connectivity globally:
/// ```dart
/// BlocProvider(
///   create: (_) => sl<ConnectivityCubit>()..init(),
///   child: const App(),
/// )
/// ```
///
/// Listen for changes:
/// ```dart
/// BlocListener<ConnectivityCubit, ConnectivityState>(
///   listenWhen: (prev, curr) => prev.isConnected != curr.isConnected,
///   listener: (context, state) {
///     if (!state.isConnected) {
///       AppToast.error(context, 'No internet connection');
///     }
///   },
///   child: ...
/// )
/// ```
@injectable
class ConnectivityCubit extends Cubit<ConnectivityState> {
  ConnectivityCubit(this._connectivity, this._networkInfo)
    : super(const ConnectivityState());

  final Connectivity _connectivity;
  final NetworkInfo _networkInfo;
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  /// Initialize connectivity monitoring.
  Future<void> init() async {
    // Check initial status
    await _checkConnectivity();

    // Listen for changes
    _subscription = _connectivity.onConnectivityChanged.listen(
      (_) => _checkConnectivity(),
    );
  }

  /// Manually check connectivity status.
  Future<void> checkConnectivity() async {
    await _checkConnectivity();
  }

  Future<void> _checkConnectivity() async {
    final results = await _connectivity.checkConnectivity();
    final isConnected = await _networkInfo.isConnected;

    final type = _mapConnectivityType(results);

    emit(
      ConnectivityState(
        isConnected: isConnected,
        type: type,
        isInitialized: true,
      ),
    );
  }

  ConnectivityType _mapConnectivityType(List<ConnectivityResult> results) {
    if (results.isEmpty || results.contains(ConnectivityResult.none)) {
      return ConnectivityType.none;
    }
    if (results.contains(ConnectivityResult.wifi)) {
      return ConnectivityType.wifi;
    }
    if (results.contains(ConnectivityResult.mobile)) {
      return ConnectivityType.mobile;
    }
    if (results.contains(ConnectivityResult.ethernet)) {
      return ConnectivityType.ethernet;
    }
    return ConnectivityType.unknown;
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
