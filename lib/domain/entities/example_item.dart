import 'package:freezed_annotation/freezed_annotation.dart';

part 'example_item.freezed.dart';
part 'example_item.g.dart';

/// Example item entity for demonstration.
///
/// This entity shows the standard pattern for domain entities:
/// - Immutable with freezed
/// - JSON serialization for API responses
@freezed
class ExampleItem with _$ExampleItem {
  const factory ExampleItem({
    required int id,
    required String title,
    String? description,
    @Default(false) bool isCompleted,
  }) = _ExampleItem;

  factory ExampleItem.fromJson(Map<String, dynamic> json) =>
      _$ExampleItemFromJson(json);
}
