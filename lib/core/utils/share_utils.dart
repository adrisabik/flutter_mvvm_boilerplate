import 'package:share_plus/share_plus.dart';

/// Share utility for sharing content.
///
/// Usage:
/// ```dart
/// await ShareUtils.shareText('Check out this app!');
/// await ShareUtils.shareUri(Uri.parse('https://example.com'));
/// await ShareUtils.shareFiles(['/path/to/file.pdf']);
/// ```
abstract final class ShareUtils {
  /// Share plain text.
  static Future<ShareResult> shareText(String text, {String? subject}) async {
    return Share.share(text, subject: subject);
  }

  /// Share a URI.
  static Future<ShareResult> shareUri(Uri uri) async {
    return Share.shareUri(uri);
  }

  /// Share files.
  ///
  /// [paths] - List of file paths to share.
  /// [mimeTypes] - Optional MIME types for the files.
  static Future<ShareResult> shareFiles(
    List<String> paths, {
    String? text,
    String? subject,
    List<String>? mimeTypes,
  }) async {
    final files = paths.map(XFile.new).toList();
    return Share.shareXFiles(files, text: text, subject: subject);
  }

  /// Share a single file with optional text.
  static Future<ShareResult> shareFile(
    String path, {
    String? text,
    String? subject,
  }) async {
    return Share.shareXFiles([XFile(path)], text: text, subject: subject);
  }
}
