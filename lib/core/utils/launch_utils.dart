import 'package:flutter_mvvm_boilerplate/core/utils/logger.dart';
import 'package:url_launcher/url_launcher.dart';

/// URL launcher utility for opening external links.
///
/// Usage:
/// ```dart
/// await LaunchUtils.openUrl('https://example.com');
/// await LaunchUtils.openEmail('support@example.com');
/// await LaunchUtils.openPhone('+1234567890');
/// await LaunchUtils.openMaps(latitude: 37.7749, longitude: -122.4194);
/// ```
abstract final class LaunchUtils {
  /// Open a URL in the default browser.
  ///
  /// [url] - The URL to open.
  /// [mode] - Launch mode (default: external application).
  static Future<bool> openUrl(
    String url, {
    LaunchMode mode = LaunchMode.externalApplication,
  }) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        return launchUrl(uri, mode: mode);
      }
      Log.w('Cannot launch URL: $url', tag: 'LaunchUtils');
      return false;
    } catch (e, stack) {
      Log.e('Failed to launch URL: $url', error: e, stackTrace: stack);
      return false;
    }
  }

  /// Open a URL in an in-app browser.
  static Future<bool> openInAppBrowser(String url) async {
    return openUrl(url, mode: LaunchMode.inAppBrowserView);
  }

  /// Open email client with pre-filled email.
  ///
  /// [to] - Recipient email address.
  /// [subject] - Email subject.
  /// [body] - Email body.
  /// [cc] - CC recipients.
  /// [bcc] - BCC recipients.
  static Future<bool> openEmail({
    required String to,
    String? subject,
    String? body,
    List<String>? cc,
    List<String>? bcc,
  }) async {
    try {
      final uri = Uri(
        scheme: 'mailto',
        path: to,
        queryParameters: {
          if (subject != null) 'subject': subject,
          if (body != null) 'body': body,
          if (cc != null && cc.isNotEmpty) 'cc': cc.join(','),
          if (bcc != null && bcc.isNotEmpty) 'bcc': bcc.join(','),
        },
      );
      return launchUrl(uri);
    } catch (e, stack) {
      Log.e('Failed to launch email', error: e, stackTrace: stack);
      return false;
    }
  }

  /// Open phone dialer with number.
  static Future<bool> openPhone(String phoneNumber) async {
    try {
      final uri = Uri(scheme: 'tel', path: phoneNumber);
      return launchUrl(uri);
    } catch (e, stack) {
      Log.e('Failed to launch phone dialer', error: e, stackTrace: stack);
      return false;
    }
  }

  /// Open SMS app with pre-filled message.
  static Future<bool> openSms(String phoneNumber, {String? message}) async {
    try {
      final uri = Uri(
        scheme: 'sms',
        path: phoneNumber,
        queryParameters: message != null ? {'body': message} : null,
      );
      return launchUrl(uri);
    } catch (e, stack) {
      Log.e('Failed to launch SMS', error: e, stackTrace: stack);
      return false;
    }
  }

  /// Open maps at specific coordinates.
  static Future<bool> openMaps({
    required double latitude,
    required double longitude,
    String? label,
  }) async {
    try {
      // Google Maps URL format
      final query = label != null
          ? '$latitude,$longitude($label)'
          : '$latitude,$longitude';
      final uri = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$query',
      );
      return launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e, stack) {
      Log.e('Failed to launch maps', error: e, stackTrace: stack);
      return false;
    }
  }

  /// Open maps with a search query.
  static Future<bool> openMapsSearch(String query) async {
    try {
      final encoded = Uri.encodeComponent(query);
      final uri = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$encoded',
      );
      return launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e, stack) {
      Log.e('Failed to launch maps search', error: e, stackTrace: stack);
      return false;
    }
  }

  /// Check if a URL can be launched.
  static Future<bool> canLaunch(String url) async {
    try {
      final uri = Uri.parse(url);
      return canLaunchUrl(uri);
    } catch (_) {
      return false;
    }
  }
}
