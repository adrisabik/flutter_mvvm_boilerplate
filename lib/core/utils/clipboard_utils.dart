import 'package:flutter/services.dart';

/// Clipboard utility for copy/paste operations.
///
/// Usage:
/// ```dart
/// await ClipboardUtils.copy('Text to copy');
/// final text = await ClipboardUtils.paste();
/// ```
abstract final class ClipboardUtils {
  /// Copy text to clipboard.
  ///
  /// Returns `true` if successful.
  static Future<bool> copy(String text) async {
    try {
      await Clipboard.setData(ClipboardData(text: text));
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Paste text from clipboard.
  ///
  /// Returns `null` if clipboard is empty or unavailable.
  static Future<String?> paste() async {
    try {
      final data = await Clipboard.getData(Clipboard.kTextPlain);
      return data?.text;
    } catch (_) {
      return null;
    }
  }

  /// Check if clipboard has text content.
  static Future<bool> hasText() async {
    final text = await paste();
    return text != null && text.isNotEmpty;
  }

  /// Copy text and return a callback for showing feedback.
  ///
  /// Usage:
  /// ```dart
  /// final (success, showSnackbar) = await ClipboardUtils.copyWithFeedback('text');
  /// if (success) showSnackbar('Copied!');
  /// ```
  static Future<(bool success, void Function(String) onSuccess)>
  copyWithFeedback(
    String text, {
    void Function(String message)? onSuccess,
  }) async {
    final success = await copy(text);
    return (success, onSuccess ?? (_) {});
  }
}
