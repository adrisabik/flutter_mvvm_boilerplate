import 'package:flutter_mvvm_boilerplate/core/extensions/list_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ListExtensions', () {
    group('getOrNull', () {
      test('returns element at valid index', () {
        final list = [1, 2, 3];
        expect(list.getOrNull(0), 1);
        expect(list.getOrNull(2), 3);
      });

      test('returns null for out of bounds index', () {
        final list = [1, 2, 3];
        expect(list.getOrNull(-1), isNull);
        expect(list.getOrNull(3), isNull);
        expect(list.getOrNull(100), isNull);
      });
    });

    group('getOrElse', () {
      test('returns element at valid index', () {
        final list = ['a', 'b', 'c'];
        expect(list.getOrElse(1, 'default'), 'b');
      });

      test('returns default for out of bounds index', () {
        final list = ['a', 'b', 'c'];
        expect(list.getOrElse(5, 'default'), 'default');
      });
    });

    group('firstOrNull / lastOrNull', () {
      test('returns first/last element when list is not empty', () {
        final list = [1, 2, 3];
        expect(list.firstOrNull, 1);
        expect(list.lastOrNull, 3);
      });

      test('returns null when list is empty', () {
        final list = <int>[];
        expect(list.firstOrNull, isNull);
        expect(list.lastOrNull, isNull);
      });
    });

    group('groupBy', () {
      test('groups elements by key function', () {
        final words = ['one', 'two', 'three', 'four', 'five'];
        final byLength = words.groupBy((w) => w.length);

        expect(byLength[3], ['one', 'two']);
        expect(byLength[4], ['four', 'five']);
        expect(byLength[5], ['three']);
      });

      test('returns empty map for empty list', () {
        final list = <String>[];
        expect(list.groupBy((s) => s.length), isEmpty);
      });
    });

    group('countWhere', () {
      test('counts matching elements', () {
        final numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
        expect(numbers.countWhere((n) => n > 5), 5);
        expect(numbers.countWhere((n) => n.isEven), 5);
        expect(numbers.countWhere((n) => n > 100), 0);
      });
    });

    group('mapIndexed', () {
      test('maps with index', () {
        final list = ['a', 'b', 'c'];
        final result = list.mapIndexed((i, item) => '$i:$item').toList();
        expect(result, ['0:a', '1:b', '2:c']);
      });
    });

    group('chunked', () {
      test('splits list into chunks', () {
        final list = [1, 2, 3, 4, 5, 6, 7];
        expect(list.chunked(2), [
          [1, 2],
          [3, 4],
          [5, 6],
          [7],
        ]);
        expect(list.chunked(3), [
          [1, 2, 3],
          [4, 5, 6],
          [7],
        ]);
      });

      test('throws for non-positive size', () {
        final list = [1, 2, 3];
        expect(() => list.chunked(0), throwsArgumentError);
        expect(() => list.chunked(-1), throwsArgumentError);
      });
    });

    group('distinctBy', () {
      test('removes duplicates by key', () {
        final list = [
          {'id': 1, 'name': 'Alice'},
          {'id': 2, 'name': 'Bob'},
          {'id': 1, 'name': 'Alice Duplicate'},
        ];
        final distinct = list.distinctBy((e) => e['id']);
        expect(distinct.length, 2);
        expect(distinct[0]['name'], 'Alice');
        expect(distinct[1]['name'], 'Bob');
      });
    });

    group('sortedBy', () {
      test('sorts by key function', () {
        final list = ['banana', 'apple', 'cherry'];
        expect(list.sortedBy((s) => s), ['apple', 'banana', 'cherry']);
      });

      test('does not modify original list', () {
        final list = [3, 1, 2];
        final sorted = list.sortedBy((n) => n);
        expect(list, [3, 1, 2]);
        expect(sorted, [1, 2, 3]);
      });
    });

    group('sortedByDescending', () {
      test('sorts by key function in descending order', () {
        final list = [1, 3, 2];
        expect(list.sortedByDescending((n) => n), [3, 2, 1]);
      });
    });
  });

  group('NullableListExtensions', () {
    test('isNullOrEmpty returns true for null', () {
      const List<int>? nullList = null;
      expect(nullList.isNullOrEmpty, isTrue);
    });

    test('isNullOrEmpty returns true for empty list', () {
      final List<int>? emptyList = [];
      expect(emptyList.isNullOrEmpty, isTrue);
    });

    test('isNullOrEmpty returns false for non-empty list', () {
      final List<int>? list = [1, 2, 3];
      expect(list.isNullOrEmpty, isFalse);
    });

    test('orEmpty returns empty list for null', () {
      const List<int>? nullList = null;
      expect(nullList.orEmpty(), <int>[]);
    });

    test('orEmpty returns original list for non-null', () {
      final List<int>? list = [1, 2, 3];
      expect(list.orEmpty(), [1, 2, 3]);
    });
  });
}
