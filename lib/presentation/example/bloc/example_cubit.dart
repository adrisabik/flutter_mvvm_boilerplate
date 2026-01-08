import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mvvm_boilerplate/core/error/failures.dart';
import 'package:flutter_mvvm_boilerplate/domain/entities/example_item.dart';
import 'package:flutter_mvvm_boilerplate/presentation/example/bloc/example_state.dart';
import 'package:flutter_mvvm_boilerplate/presentation/shared_widgets/feedback/app_status_handler.dart';

/// Example Cubit demonstrating the pattern.
///
/// Usage with AppStatusHandler:
/// ```dart
/// BlocBuilder<ExampleCubit, ExampleState>(
///   builder: (context, state) {
///     return AppStatusHandler<List<ExampleItem>>(
///       status: state.status,
///       data: state.data,
///       failure: state.failure,
///       onSuccess: (items) => ListView.builder(
///         itemCount: items.length,
///         itemBuilder: (_, i) => ListTile(title: Text(items[i].title)),
///       ),
///       onRetry: () => context.read<ExampleCubit>().fetch(),
///     );
///   },
/// )
/// ```
class ExampleCubit extends Cubit<ExampleState> {
  ExampleCubit() : super(const ExampleState());

  /// Fetch data from API (initial load).
  Future<void> fetch() async {
    emit(state.copyWith(status: Status.loading, failure: null));

    try {
      // Simulate API call
      await Future<void>.delayed(const Duration(seconds: 2));

      // Simulate success with data
      final items = List.generate(
        10,
        (i) => ExampleItem(
          id: i,
          title: 'Item ${i + 1}',
          description: 'This is item number ${i + 1}',
        ),
      );

      emit(state.copyWith(status: Status.success, data: items));
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: Status.error,
          failure: ServerFailure(message: e.toString()),
        ),
      );
    }
  }

  /// Refresh data (keeps existing data visible during refresh).
  Future<void> refresh() async {
    // Don't show loading spinner, just mark as refreshing
    emit(state.copyWith(isRefreshing: true, failure: null));

    try {
      await Future<void>.delayed(const Duration(seconds: 1));

      // Simulate refreshed data with updated titles
      final items = List.generate(
        10,
        (i) => ExampleItem(
          id: i,
          title: 'Refreshed Item ${i + 1}',
          description: 'Updated at ${DateTime.now().toIso8601String()}',
        ),
      );

      emit(
        state.copyWith(
          status: Status.success,
          data: items,
          isRefreshing: false,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          isRefreshing: false,
          failure: ServerFailure(message: e.toString()),
        ),
      );
    }
  }

  /// Fetch empty data for demonstration.
  Future<void> fetchEmpty() async {
    emit(state.copyWith(status: Status.loading, failure: null));

    await Future<void>.delayed(const Duration(seconds: 1));

    emit(state.copyWith(status: Status.success, data: <ExampleItem>[]));
  }

  /// Simulate an error scenario.
  Future<void> fetchWithError() async {
    emit(state.copyWith(status: Status.loading, failure: null));

    await Future<void>.delayed(const Duration(seconds: 1));

    emit(
      state.copyWith(
        status: Status.error,
        failure: const ServerFailure(
          message: 'Failed to load items. Please try again.',
          statusCode: 500,
        ),
      ),
    );
  }

  /// Clear the current error.
  void clearError() {
    emit(state.copyWith(failure: null));
  }
}
