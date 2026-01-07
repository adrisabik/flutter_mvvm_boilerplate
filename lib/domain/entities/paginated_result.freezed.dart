// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paginated_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PaginatedResult<T> {
  List<T> get items => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  int? get totalItems => throw _privateConstructorUsedError;
  int? get totalPages => throw _privateConstructorUsedError;

  /// Create a copy of PaginatedResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaginatedResultCopyWith<T, PaginatedResult<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginatedResultCopyWith<T, $Res> {
  factory $PaginatedResultCopyWith(
    PaginatedResult<T> value,
    $Res Function(PaginatedResult<T>) then,
  ) = _$PaginatedResultCopyWithImpl<T, $Res, PaginatedResult<T>>;
  @useResult
  $Res call({
    List<T> items,
    bool hasMore,
    int currentPage,
    int? totalItems,
    int? totalPages,
  });
}

/// @nodoc
class _$PaginatedResultCopyWithImpl<T, $Res, $Val extends PaginatedResult<T>>
    implements $PaginatedResultCopyWith<T, $Res> {
  _$PaginatedResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaginatedResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? hasMore = null,
    Object? currentPage = null,
    Object? totalItems = freezed,
    Object? totalPages = freezed,
  }) {
    return _then(
      _value.copyWith(
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<T>,
            hasMore: null == hasMore
                ? _value.hasMore
                : hasMore // ignore: cast_nullable_to_non_nullable
                      as bool,
            currentPage: null == currentPage
                ? _value.currentPage
                : currentPage // ignore: cast_nullable_to_non_nullable
                      as int,
            totalItems: freezed == totalItems
                ? _value.totalItems
                : totalItems // ignore: cast_nullable_to_non_nullable
                      as int?,
            totalPages: freezed == totalPages
                ? _value.totalPages
                : totalPages // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaginatedResultImplCopyWith<T, $Res>
    implements $PaginatedResultCopyWith<T, $Res> {
  factory _$$PaginatedResultImplCopyWith(
    _$PaginatedResultImpl<T> value,
    $Res Function(_$PaginatedResultImpl<T>) then,
  ) = __$$PaginatedResultImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({
    List<T> items,
    bool hasMore,
    int currentPage,
    int? totalItems,
    int? totalPages,
  });
}

/// @nodoc
class __$$PaginatedResultImplCopyWithImpl<T, $Res>
    extends _$PaginatedResultCopyWithImpl<T, $Res, _$PaginatedResultImpl<T>>
    implements _$$PaginatedResultImplCopyWith<T, $Res> {
  __$$PaginatedResultImplCopyWithImpl(
    _$PaginatedResultImpl<T> _value,
    $Res Function(_$PaginatedResultImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of PaginatedResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? hasMore = null,
    Object? currentPage = null,
    Object? totalItems = freezed,
    Object? totalPages = freezed,
  }) {
    return _then(
      _$PaginatedResultImpl<T>(
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<T>,
        hasMore: null == hasMore
            ? _value.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        currentPage: null == currentPage
            ? _value.currentPage
            : currentPage // ignore: cast_nullable_to_non_nullable
                  as int,
        totalItems: freezed == totalItems
            ? _value.totalItems
            : totalItems // ignore: cast_nullable_to_non_nullable
                  as int?,
        totalPages: freezed == totalPages
            ? _value.totalPages
            : totalPages // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

class _$PaginatedResultImpl<T> implements _PaginatedResult<T> {
  const _$PaginatedResultImpl({
    required final List<T> items,
    required this.hasMore,
    required this.currentPage,
    this.totalItems,
    this.totalPages,
  }) : _items = items;

  final List<T> _items;
  @override
  List<T> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final bool hasMore;
  @override
  final int currentPage;
  @override
  final int? totalItems;
  @override
  final int? totalPages;

  @override
  String toString() {
    return 'PaginatedResult<$T>(items: $items, hasMore: $hasMore, currentPage: $currentPage, totalItems: $totalItems, totalPages: $totalPages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginatedResultImpl<T> &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.totalItems, totalItems) ||
                other.totalItems == totalItems) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_items),
    hasMore,
    currentPage,
    totalItems,
    totalPages,
  );

  /// Create a copy of PaginatedResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginatedResultImplCopyWith<T, _$PaginatedResultImpl<T>> get copyWith =>
      __$$PaginatedResultImplCopyWithImpl<T, _$PaginatedResultImpl<T>>(
        this,
        _$identity,
      );
}

abstract class _PaginatedResult<T> implements PaginatedResult<T> {
  const factory _PaginatedResult({
    required final List<T> items,
    required final bool hasMore,
    required final int currentPage,
    final int? totalItems,
    final int? totalPages,
  }) = _$PaginatedResultImpl<T>;

  @override
  List<T> get items;
  @override
  bool get hasMore;
  @override
  int get currentPage;
  @override
  int? get totalItems;
  @override
  int? get totalPages;

  /// Create a copy of PaginatedResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaginatedResultImplCopyWith<T, _$PaginatedResultImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
