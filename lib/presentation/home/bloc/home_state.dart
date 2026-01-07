import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

/// Home states for the HomeCubit.
@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(false) bool isLoading,
    @Default('') String userName,
    String? error,
  }) = _HomeState;
}
