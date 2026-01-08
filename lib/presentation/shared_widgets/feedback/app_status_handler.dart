import 'package:flutter/material.dart';
import 'package:flutter_mvvm_boilerplate/core/error/failures.dart';

/// Status for async operations.
enum Status {
  /// Initial state.
  initial,

  /// Loading state.
  loading,

  /// Success state with data.
  success,

  /// Error state with failure.
  error,
}

/// A widget that handles common BLoC/Cubit states.
///
/// Automatically shows loading, error, and success states based on the
/// current state of a BLoC or Cubit.
///
/// Usage:
/// ```dart
/// BlocBuilder<MyCubit, MyState>(
///   builder: (context, state) {
///     return AppStatusHandler<MyData>(
///       status: state.status,
///       data: state.data,
///       failure: state.failure,
///       onSuccess: (data) => MySuccessWidget(data: data),
///       onRetry: () => context.read<MyCubit>().fetch(),
///     );
///   },
/// )
/// ```
class AppStatusHandler<T> extends StatelessWidget {
  const AppStatusHandler({
    required this.status,
    required this.onSuccess,
    super.key,
    this.data,
    this.failure,
    this.onLoading,
    this.onError,
    this.onInitial,
    this.onRetry,
    this.loadingWidget,
    this.errorWidget,
    this.initialWidget,
    this.showRetry = true,
  });

  /// Current status.
  final Status status;

  /// Data for success state.
  final T? data;

  /// Failure for error state.
  final Failure? failure;

  /// Builder for success state.
  final Widget Function(T data) onSuccess;

  /// Optional custom loading builder.
  final Widget Function()? onLoading;

  /// Optional custom error builder.
  final Widget Function(Failure failure)? onError;

  /// Optional custom initial builder.
  final Widget Function()? onInitial;

  /// Callback for retry button.
  final VoidCallback? onRetry;

  /// Custom loading widget.
  final Widget? loadingWidget;

  /// Custom error widget.
  final Widget? errorWidget;

  /// Custom initial widget.
  final Widget? initialWidget;

  /// Whether to show retry button on error.
  final bool showRetry;

  @override
  Widget build(BuildContext context) {
    return switch (status) {
      Status.initial => _buildInitial(),
      Status.loading => _buildLoading(),
      Status.success => _buildSuccess(),
      Status.error => _buildError(context),
    };
  }

  Widget _buildInitial() {
    if (onInitial != null) return onInitial!();
    if (initialWidget != null) return initialWidget!;
    return const SizedBox.shrink();
  }

  Widget _buildLoading() {
    if (onLoading != null) return onLoading!();
    if (loadingWidget != null) return loadingWidget!;
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildSuccess() {
    if (data == null) {
      return const Center(child: Text('No data'));
    }
    return onSuccess(data as T);
  }

  Widget _buildError(BuildContext context) {
    if (onError != null && failure != null) return onError!(failure!);
    if (errorWidget != null) return errorWidget!;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            failure?.message ?? 'An error occurred',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          if (showRetry && onRetry != null) ...[
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ],
      ),
    );
  }
}

/// A mixin for states that have status, data, and failure.
///
/// Use with freezed to easily create states:
/// ```dart
/// @freezed
/// class MyState with _$MyState, StatusMixin<MyData> {
///   const MyState._();
///   const factory MyState({
///     @Default(Status.initial) Status status,
///     MyData? data,
///     Failure? failure,
///   }) = _MyState;
/// }
/// ```
mixin StatusMixin<T> {
  Status get status;
  T? get data;
  Failure? get failure;

  bool get isInitial => status == Status.initial;
  bool get isLoading => status == Status.loading;
  bool get isSuccess => status == Status.success;
  bool get isError => status == Status.error;
  bool get hasData => data != null;
}

/// Extension on list of data with pagination status.
class PaginatedData<T> {
  const PaginatedData({
    required this.items,
    this.hasMore = true,
    this.page = 1,
    this.isLoadingMore = false,
  });

  final List<T> items;
  final bool hasMore;
  final int page;
  final bool isLoadingMore;

  PaginatedData<T> copyWith({
    List<T>? items,
    bool? hasMore,
    int? page,
    bool? isLoadingMore,
  }) {
    return PaginatedData<T>(
      items: items ?? this.items,
      hasMore: hasMore ?? this.hasMore,
      page: page ?? this.page,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  String toString() =>
      'PaginatedData(items: ${items.length}, page: $page, hasMore: $hasMore)';
}
