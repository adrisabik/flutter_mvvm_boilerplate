import 'package:freezed_annotation/freezed_annotation.dart';

part 'connectivity_state.freezed.dart';

/// State for connectivity status.
@freezed
class ConnectivityState with _$ConnectivityState {
  const factory ConnectivityState({
    @Default(true) bool isConnected,
    @Default(ConnectivityType.unknown) ConnectivityType type,
    @Default(false) bool isInitialized,
  }) = _ConnectivityState;
}

/// Type of network connection.
enum ConnectivityType { wifi, mobile, ethernet, none, unknown }
