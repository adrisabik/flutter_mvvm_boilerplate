import 'package:flutter_mvvm_boilerplate/core/error/failures.dart';
import 'package:flutter_mvvm_boilerplate/domain/entities/example_item.dart';
import 'package:flutter_mvvm_boilerplate/presentation/shared_widgets/feedback/app_status_handler.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'example_state.freezed.dart';

/// Example state demonstrating proper state structure for [AppStatusHandler].
///
/// This shows how to structure BLoC states to work seamlessly
/// with [AppStatusHandler].
///
/// Note: We don't use StatusMixin here because freezed already generates
/// the required getters. The mixin is for non-freezed states.
@freezed
class ExampleState with _$ExampleState {
  const factory ExampleState({
    @Default(Status.initial) Status status,
    @Default(<ExampleItem>[]) List<ExampleItem> data,
    Failure? failure,
    @Default(false) bool isRefreshing,
  }) = _ExampleState;

  const ExampleState._();

  // Convenience getters (same as StatusMixin provides)
  bool get isInitial => status == Status.initial;
  bool get isLoading => status == Status.loading;
  bool get isSuccess => status == Status.success;
  bool get isError => status == Status.error;
  bool get hasData => data.isNotEmpty;

  /// Check if we have no items to display.
  bool get isEmpty => data.isEmpty && status == Status.success;
}
