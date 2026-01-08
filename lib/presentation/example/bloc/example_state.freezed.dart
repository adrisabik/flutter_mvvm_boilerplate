// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'example_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ExampleState {
  Status get status => throw _privateConstructorUsedError;
  List<ExampleItem> get data => throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;
  bool get isRefreshing => throw _privateConstructorUsedError;

  /// Create a copy of ExampleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExampleStateCopyWith<ExampleState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExampleStateCopyWith<$Res> {
  factory $ExampleStateCopyWith(
    ExampleState value,
    $Res Function(ExampleState) then,
  ) = _$ExampleStateCopyWithImpl<$Res, ExampleState>;
  @useResult
  $Res call({
    Status status,
    List<ExampleItem> data,
    Failure? failure,
    bool isRefreshing,
  });
}

/// @nodoc
class _$ExampleStateCopyWithImpl<$Res, $Val extends ExampleState>
    implements $ExampleStateCopyWith<$Res> {
  _$ExampleStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExampleState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? data = null,
    Object? failure = freezed,
    Object? isRefreshing = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as Status,
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as List<ExampleItem>,
            failure: freezed == failure
                ? _value.failure
                : failure // ignore: cast_nullable_to_non_nullable
                      as Failure?,
            isRefreshing: null == isRefreshing
                ? _value.isRefreshing
                : isRefreshing // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ExampleStateImplCopyWith<$Res>
    implements $ExampleStateCopyWith<$Res> {
  factory _$$ExampleStateImplCopyWith(
    _$ExampleStateImpl value,
    $Res Function(_$ExampleStateImpl) then,
  ) = __$$ExampleStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Status status,
    List<ExampleItem> data,
    Failure? failure,
    bool isRefreshing,
  });
}

/// @nodoc
class __$$ExampleStateImplCopyWithImpl<$Res>
    extends _$ExampleStateCopyWithImpl<$Res, _$ExampleStateImpl>
    implements _$$ExampleStateImplCopyWith<$Res> {
  __$$ExampleStateImplCopyWithImpl(
    _$ExampleStateImpl _value,
    $Res Function(_$ExampleStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExampleState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? data = null,
    Object? failure = freezed,
    Object? isRefreshing = null,
  }) {
    return _then(
      _$ExampleStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as Status,
        data: null == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as List<ExampleItem>,
        failure: freezed == failure
            ? _value.failure
            : failure // ignore: cast_nullable_to_non_nullable
                  as Failure?,
        isRefreshing: null == isRefreshing
            ? _value.isRefreshing
            : isRefreshing // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$ExampleStateImpl extends _ExampleState {
  const _$ExampleStateImpl({
    this.status = Status.initial,
    final List<ExampleItem> data = const <ExampleItem>[],
    this.failure,
    this.isRefreshing = false,
  }) : _data = data,
       super._();

  @override
  @JsonKey()
  final Status status;
  final List<ExampleItem> _data;
  @override
  @JsonKey()
  List<ExampleItem> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final Failure? failure;
  @override
  @JsonKey()
  final bool isRefreshing;

  @override
  String toString() {
    return 'ExampleState(status: $status, data: $data, failure: $failure, isRefreshing: $isRefreshing)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExampleStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.failure, failure) || other.failure == failure) &&
            (identical(other.isRefreshing, isRefreshing) ||
                other.isRefreshing == isRefreshing));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    const DeepCollectionEquality().hash(_data),
    failure,
    isRefreshing,
  );

  /// Create a copy of ExampleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExampleStateImplCopyWith<_$ExampleStateImpl> get copyWith =>
      __$$ExampleStateImplCopyWithImpl<_$ExampleStateImpl>(this, _$identity);
}

abstract class _ExampleState extends ExampleState {
  const factory _ExampleState({
    final Status status,
    final List<ExampleItem> data,
    final Failure? failure,
    final bool isRefreshing,
  }) = _$ExampleStateImpl;
  const _ExampleState._() : super._();

  @override
  Status get status;
  @override
  List<ExampleItem> get data;
  @override
  Failure? get failure;
  @override
  bool get isRefreshing;

  /// Create a copy of ExampleState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExampleStateImplCopyWith<_$ExampleStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
