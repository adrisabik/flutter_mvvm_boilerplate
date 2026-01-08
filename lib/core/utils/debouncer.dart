import 'dart:async';

/// A utility class for debouncing function calls.
///
/// Debouncing delays the execution of a function until after a specified
/// duration has passed since the last call. Useful for:
/// - Search input fields (wait for user to stop typing)
/// - Button spam prevention
/// - Scroll event handling
///
/// Usage:
/// ```dart
/// final debouncer = Debouncer(milliseconds: 500);
///
/// // In a text field onChange:
/// onChanged: (value) {
///   debouncer.run(() => performSearch(value));
/// }
///
/// // Don't forget to dispose when done:
/// @override
/// void dispose() {
///   debouncer.dispose();
///   super.dispose();
/// }
/// ```
class Debouncer {
  /// Creates a debouncer with the specified delay.
  Debouncer({this.milliseconds = 300});

  /// The delay duration in milliseconds.
  final int milliseconds;

  /// Internal timer reference.
  Timer? _timer;

  /// Whether the debouncer has been disposed.
  bool _isDisposed = false;

  /// Run the callback after the debounce delay.
  ///
  /// If called again before the delay expires, the previous
  /// callback is cancelled and the timer resets.
  void run(void Function() action) {
    if (_isDisposed) return;

    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  /// Cancel any pending debounced action.
  void cancel() {
    _timer?.cancel();
    _timer = null;
  }

  /// Dispose the debouncer and cancel any pending action.
  ///
  /// After disposal, calls to [run] will be ignored.
  void dispose() {
    _isDisposed = true;
    cancel();
  }
}

/// A utility class for throttling function calls.
///
/// Throttling ensures a function is called at most once within a specified
/// duration. Unlike debouncing, the first call executes immediately.
/// Useful for:
/// - Rate-limiting API calls
/// - Scroll position updates
/// - Window resize handling
///
/// Usage:
/// ```dart
/// final throttler = Throttler(milliseconds: 1000);
///
/// // Rate-limit scroll updates:
/// onScroll: () {
///   throttler.run(() => updateScrollPosition());
/// }
///
/// // Don't forget to dispose when done:
/// @override
/// void dispose() {
///   throttler.dispose();
///   super.dispose();
/// }
/// ```
class Throttler {
  /// Creates a throttler with the specified interval.
  Throttler({this.milliseconds = 300});

  /// The throttle interval in milliseconds.
  final int milliseconds;

  /// Timestamp of the last execution.
  DateTime? _lastExecutionTime;

  /// Timer for trailing execution.
  Timer? _timer;

  /// Whether the throttler has been disposed.
  bool _isDisposed = false;

  /// Run the callback if the throttle interval has passed.
  ///
  /// The first call executes immediately, then subsequent calls
  /// are ignored until the interval has passed.
  void run(void Function() action) {
    if (_isDisposed) return;

    final now = DateTime.now();

    if (_lastExecutionTime == null ||
        now.difference(_lastExecutionTime!).inMilliseconds >= milliseconds) {
      _lastExecutionTime = now;
      action();
    }
  }

  /// Run with trailing execution.
  ///
  /// Ensures the last call within the interval is always executed
  /// after the interval expires.
  void runWithTrailing(void Function() action) {
    if (_isDisposed) return;

    final now = DateTime.now();

    if (_lastExecutionTime == null ||
        now.difference(_lastExecutionTime!).inMilliseconds >= milliseconds) {
      _lastExecutionTime = now;
      _timer?.cancel();
      action();
    } else {
      // Schedule trailing execution
      _timer?.cancel();
      _timer = Timer(
        Duration(
          milliseconds:
              milliseconds - now.difference(_lastExecutionTime!).inMilliseconds,
        ),
        () {
          _lastExecutionTime = DateTime.now();
          action();
        },
      );
    }
  }

  /// Reset the throttler state.
  void reset() {
    _lastExecutionTime = null;
    _timer?.cancel();
    _timer = null;
  }

  /// Dispose the throttler.
  void dispose() {
    _isDisposed = true;
    reset();
  }
}
