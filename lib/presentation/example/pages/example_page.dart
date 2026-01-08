import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mvvm_boilerplate/core/theme/app_spacing.dart';
import 'package:flutter_mvvm_boilerplate/domain/entities/example_item.dart';
import 'package:flutter_mvvm_boilerplate/presentation/example/bloc/example_cubit.dart';
import 'package:flutter_mvvm_boilerplate/presentation/example/bloc/example_state.dart';
import 'package:flutter_mvvm_boilerplate/presentation/shared_widgets/feedback/app_refreshable.dart';
import 'package:flutter_mvvm_boilerplate/presentation/shared_widgets/feedback/app_status_handler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

/// Example page demonstrating AppStatusHandler usage.
///
/// This page shows how to use [AppStatusHandler] to handle
/// loading, error, and success states in a clean way.
///
/// Features demonstrated:
/// - Loading state with spinner
/// - Error state with retry button
/// - Success state with data list
/// - Empty state handling
/// - Pull-to-refresh with loading overlay
/// - BlocListener for side effects (snackbar on error)
class ExamplePage extends StatelessWidget {
  const ExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ExampleCubit()..fetch(),
      child: const _ExamplePageContent(),
    );
  }
}

class _ExamplePageContent extends StatelessWidget {
  const _ExamplePageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppStatusHandler Example'),
        actions: [
          // Button to simulate empty state
          IconButton(
            icon: const Icon(Icons.inbox_outlined),
            tooltip: 'Load Empty',
            onPressed: () => context.read<ExampleCubit>().fetchEmpty(),
          ),
          // Button to simulate error
          IconButton(
            icon: const Icon(Icons.error_outline),
            tooltip: 'Simulate Error',
            onPressed: () => context.read<ExampleCubit>().fetchWithError(),
          ),
          // Button to reload
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Reload',
            onPressed: () => context.read<ExampleCubit>().fetch(),
          ),
        ],
      ),
      // BlocListener for side effects (show snackbar on error during refresh)
      body: BlocListener<ExampleCubit, ExampleState>(
        listenWhen: (previous, current) =>
            previous.failure != current.failure && current.failure != null,
        listener: (context, state) {
          // Show snackbar when error occurs during refresh
          if (state.failure != null && !state.isLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.failure!.message),
                backgroundColor: Theme.of(context).colorScheme.error,
                action: SnackBarAction(
                  label: 'Retry',
                  textColor: Colors.white,
                  onPressed: () => context.read<ExampleCubit>().fetch(),
                ),
              ),
            );
          }
        },
        child: Column(
          children: [
            // Main content
            Expanded(
              child: BlocBuilder<ExampleCubit, ExampleState>(
                builder: (context, state) {
                  return Stack(
                    children: [
                      // Main status handler
                      AppStatusHandler<List<ExampleItem>>(
                        status: state.status,
                        data: state.data,
                        failure: state.failure,
                        onRetry: () => context.read<ExampleCubit>().fetch(),
                        // Success builder with empty state handling
                        onSuccess: (items) {
                          // Empty state
                          if (items.isEmpty) {
                            return _EmptyState(
                              onRefresh: () =>
                                  context.read<ExampleCubit>().fetch(),
                            );
                          }

                          // List with pull-to-refresh
                          return AppRefreshable(
                            onRefresh: () =>
                                context.read<ExampleCubit>().refresh(),
                            child: ListView.builder(
                              padding: EdgeInsets.all(AppSpacing.md),
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                final item = items[index];
                                return _ItemCard(item: item);
                              },
                            ),
                          );
                        },
                      ),

                      // Loading overlay during refresh
                      if (state.isRefreshing) const _LoadingOverlay(),
                    ],
                  );
                },
              ),
            ),

            // Info card at bottom (proper placement, not in bottomNavigationBar)
            const _InfoCard(),
          ],
        ),
      ),
    );
  }
}

/// Card displaying a single item.
class _ItemCard extends StatelessWidget {
  const _ItemCard({required this.item});
  final ExampleItem item;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.only(bottom: AppSpacing.sm),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: colorScheme.primaryContainer,
          child: Text(
            '${item.id + 1}',
            style: TextStyle(color: colorScheme.onPrimaryContainer),
          ),
        ),
        title: Text(item.title),
        subtitle: item.description != null ? Text(item.description!) : null,
        trailing: Icon(
          item.isCompleted ? Icons.check_circle : Icons.chevron_right,
          color: item.isCompleted ? Colors.green : null,
        ),
      ),
    );
  }
}

/// Empty state widget.
class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onRefresh});
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 64.w,
            color: colorScheme.onSurfaceVariant,
          ),
          Gap(AppSpacing.md),
          Text(
            'No items found',
            style: textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          Gap(AppSpacing.xs),
          Text(
            'Pull to refresh or tap the button below',
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          Gap(AppSpacing.lg),
          FilledButton.icon(
            onPressed: onRefresh,
            icon: const Icon(Icons.refresh),
            label: const Text('Load Items'),
          ),
        ],
      ),
    );
  }
}

/// Loading overlay shown during refresh.
class _LoadingOverlay extends StatelessWidget {
  const _LoadingOverlay();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ColoredBox(
        color: Colors.black.withValues(alpha: 0.3),
        child: const Center(
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Refreshing...'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Info card explaining how the component works.
class _InfoCard extends StatelessWidget {
  const _InfoCard();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Card(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.md),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '💡 Features Demonstrated',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                Gap(AppSpacing.xs),
                const Text(
                  '• Loading → Success/Error states\n'
                  '• Empty state with refresh button\n'
                  '• Pull-to-refresh with loading overlay\n'
                  '• BlocListener for snackbar on error',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
