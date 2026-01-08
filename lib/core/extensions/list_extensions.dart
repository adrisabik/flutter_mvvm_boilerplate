/// Extensions on [List] for safe access and utilities.
extension ListExtensions<T> on List<T> {
  // ═══════════════════════════════════════════════════════════════════════════
  // SAFE ACCESS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Safely get element at index, returns null if out of bounds.
  ///
  /// Usage: `list.getOrNull(5)` → element or null
  T? getOrNull(int index) {
    if (index < 0 || index >= length) return null;
    return this[index];
  }

  /// Safely get element at index with default value.
  ///
  /// Usage: `list.getOrElse(5, defaultValue)`
  T getOrElse(int index, T defaultValue) {
    return getOrNull(index) ?? defaultValue;
  }

  /// Get first element or null if empty.
  T? get firstOrNull => isEmpty ? null : first;

  /// Get last element or null if empty.
  T? get lastOrNull => isEmpty ? null : last;

  // ═══════════════════════════════════════════════════════════════════════════
  // GROUPING
  // ═══════════════════════════════════════════════════════════════════════════

  /// Group elements by a key function.
  ///
  /// Usage:
  /// ```dart
  /// final users = [User('Alice', 25), User('Bob', 30), User('Carol', 25)];
  /// final byAge = users.groupBy((u) => u.age);
  /// // {25: [Alice, Carol], 30: [Bob]}
  /// ```
  Map<K, List<T>> groupBy<K>(K Function(T) keyFunction) {
    final result = <K, List<T>>{};
    for (final element in this) {
      final key = keyFunction(element);
      result.putIfAbsent(key, () => []).add(element);
    }
    return result;
  }

  /// Count elements matching a predicate.
  ///
  /// Usage: `list.countWhere((e) => e.isActive)`
  int countWhere(bool Function(T) test) {
    var count = 0;
    for (final element in this) {
      if (test(element)) count++;
    }
    return count;
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // TRANSFORMATIONS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Map with index.
  ///
  /// Usage: `list.mapIndexed((index, item) => '$index: $item')`
  Iterable<R> mapIndexed<R>(R Function(int index, T item) transform) sync* {
    for (var i = 0; i < length; i++) {
      yield transform(i, this[i]);
    }
  }

  /// Filter with index.
  ///
  /// Usage: `list.whereIndexed((index, item) => index.isEven)`
  Iterable<T> whereIndexed(bool Function(int index, T item) test) sync* {
    for (var i = 0; i < length; i++) {
      if (test(i, this[i])) yield this[i];
    }
  }

  /// ForEach with index.
  ///
  /// Usage: `list.forEachIndexed((index, item) => print('$index: $item'))`
  void forEachIndexed(void Function(int index, T item) action) {
    for (var i = 0; i < length; i++) {
      action(i, this[i]);
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // CHUNKING
  // ═══════════════════════════════════════════════════════════════════════════

  /// Split list into chunks of specified size.
  ///
  /// Usage: `[1, 2, 3, 4, 5].chunked(2)` → [[1, 2], [3, 4], [5]]
  List<List<T>> chunked(int size) {
    if (size <= 0) throw ArgumentError('Size must be positive');
    final result = <List<T>>[];
    for (var i = 0; i < length; i += size) {
      result.add(sublist(i, (i + size).clamp(0, length)));
    }
    return result;
  }

  /// Take every nth element.
  ///
  /// Usage: `[0, 1, 2, 3, 4, 5].takeEvery(2)` → [0, 2, 4]
  List<T> takeEvery(int n) {
    if (n <= 0) throw ArgumentError('n must be positive');
    final result = <T>[];
    for (var i = 0; i < length; i += n) {
      result.add(this[i]);
    }
    return result;
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // DISTINCT
  // ═══════════════════════════════════════════════════════════════════════════

  /// Get distinct elements by a key function.
  ///
  /// Usage: `users.distinctBy((u) => u.email)`
  List<T> distinctBy<K>(K Function(T) keyFunction) {
    final seen = <K>{};
    final result = <T>[];
    for (final element in this) {
      final key = keyFunction(element);
      if (seen.add(key)) {
        result.add(element);
      }
    }
    return result;
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SORTING
  // ═══════════════════════════════════════════════════════════════════════════

  /// Sort by a comparable property.
  ///
  /// Usage: `users.sortedBy((u) => u.name)`
  List<T> sortedBy<K extends Comparable<K>>(K Function(T) keyFunction) {
    final copy = List<T>.from(this);
    copy.sort((a, b) => keyFunction(a).compareTo(keyFunction(b)));
    return copy;
  }

  /// Sort by a comparable property in descending order.
  ///
  /// Usage: `users.sortedByDescending((u) => u.age)`
  List<T> sortedByDescending<K extends Comparable<K>>(
    K Function(T) keyFunction,
  ) {
    final copy = List<T>.from(this);
    copy.sort((a, b) => keyFunction(b).compareTo(keyFunction(a)));
    return copy;
  }
}

/// Extensions on nullable lists.
extension NullableListExtensions<T> on List<T>? {
  /// Check if list is null or empty.
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// Check if list is not null and not empty.
  bool get isNotNullOrEmpty => !isNullOrEmpty;

  /// Returns empty list if null.
  List<T> orEmpty() => this ?? [];
}
