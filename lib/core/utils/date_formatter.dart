/// Date and time formatting utilities.
///
/// Provides consistent date/time string formatting across the app
/// without external package dependencies.
///
/// Usage:
/// ```dart
/// final date = DateTime.now();
/// DateFormatter.format(date, DateFormat.fullDate);  // "January 8, 2026"
/// DateFormatter.format(date, DateFormat.shortDate); // "08/01/2026"
/// DateFormatter.format(date, DateFormat.time);      // "13:30"
/// date.format(DateFormat.fullDateTime);             // Extension method
/// ```
library;

/// Common date format patterns.
enum DateFormat {
  /// Full date: "January 8, 2026"
  fullDate,

  /// Short date: "08/01/2026"
  shortDate,

  /// ISO date: "2026-01-08"
  isoDate,

  /// Month and day: "Jan 8"
  monthDay,

  /// Month and year: "January 2026"
  monthYear,

  /// Day and month: "8 Jan"
  dayMonth,

  /// Time only (24h): "13:30"
  time24h,

  /// Time only (12h): "1:30 PM"
  time12h,

  /// Time with seconds: "13:30:45"
  timeWithSeconds,

  /// Full date and time: "January 8, 2026 at 13:30"
  fullDateTime,

  /// Short date and time: "08/01/2026 13:30"
  shortDateTime,

  /// ISO datetime: "2026-01-08T13:30:00"
  isoDateTime,

  /// Relative: "Today", "Yesterday", "2 days ago"
  relative,

  /// Weekday: "Wednesday"
  weekday,

  /// Short weekday: "Wed"
  weekdayShort,

  /// Weekday with date: "Wednesday, January 8"
  weekdayDate,
}

/// Static date/time formatter utility.
abstract final class DateFormatter {
  static const _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  static const _monthsShort = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  static const _weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  static const _weekdaysShort = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  /// Format a DateTime using the specified format.
  static String format(DateTime date, DateFormat format) {
    return switch (format) {
      DateFormat.fullDate => _formatFullDate(date),
      DateFormat.shortDate => _formatShortDate(date),
      DateFormat.isoDate => _formatIsoDate(date),
      DateFormat.monthDay => _formatMonthDay(date),
      DateFormat.monthYear => _formatMonthYear(date),
      DateFormat.dayMonth => _formatDayMonth(date),
      DateFormat.time24h => _formatTime24h(date),
      DateFormat.time12h => _formatTime12h(date),
      DateFormat.timeWithSeconds => _formatTimeWithSeconds(date),
      DateFormat.fullDateTime => _formatFullDateTime(date),
      DateFormat.shortDateTime => _formatShortDateTime(date),
      DateFormat.isoDateTime => _formatIsoDateTime(date),
      DateFormat.relative => _formatRelative(date),
      DateFormat.weekday => _weekdays[date.weekday - 1],
      DateFormat.weekdayShort => _weekdaysShort[date.weekday - 1],
      DateFormat.weekdayDate => _formatWeekdayDate(date),
    };
  }

  /// Format with custom pattern.
  ///
  /// Supported tokens:
  /// - `yyyy` - 4-digit year
  /// - `yy` - 2-digit year
  /// - `MMMM` - Full month name
  /// - `MMM` - Abbreviated month name
  /// - `MM` - 2-digit month
  /// - `M` - Month number
  /// - `dd` - 2-digit day
  /// - `d` - Day number
  /// - `EEEE` - Full weekday name
  /// - `EEE` - Abbreviated weekday name
  /// - `HH` - 2-digit hour (24h)
  /// - `H` - Hour (24h)
  /// - `hh` - 2-digit hour (12h)
  /// - `h` - Hour (12h)
  /// - `mm` - 2-digit minute
  /// - `ss` - 2-digit second
  /// - `a` - AM/PM
  ///
  /// Example:
  /// ```dart
  /// DateFormatter.custom(date, 'dd MMM yyyy'); // "08 Jan 2026"
  /// DateFormatter.custom(date, 'EEEE, MMMM d'); // "Wednesday, January 8"
  /// ```
  static String custom(DateTime date, String pattern) {
    var result = pattern;

    // Year
    result = result.replaceAll('yyyy', date.year.toString());
    result = result.replaceAll(
      'yy',
      (date.year % 100).toString().padLeft(2, '0'),
    );

    // Month
    result = result.replaceAll('MMMM', _months[date.month - 1]);
    result = result.replaceAll('MMM', _monthsShort[date.month - 1]);
    result = result.replaceAll('MM', date.month.toString().padLeft(2, '0'));
    result = result.replaceAll(RegExp(r'\bM\b'), date.month.toString());

    // Day
    result = result.replaceAll('dd', date.day.toString().padLeft(2, '0'));
    result = result.replaceAll(RegExp(r'\bd\b'), date.day.toString());

    // Weekday
    result = result.replaceAll('EEEE', _weekdays[date.weekday - 1]);
    result = result.replaceAll('EEE', _weekdaysShort[date.weekday - 1]);

    // Hour (24h)
    result = result.replaceAll('HH', date.hour.toString().padLeft(2, '0'));
    result = result.replaceAll(RegExp(r'\bH\b'), date.hour.toString());

    // Hour (12h)
    final hour12 = date.hour == 0
        ? 12
        : (date.hour > 12 ? date.hour - 12 : date.hour);
    result = result.replaceAll('hh', hour12.toString().padLeft(2, '0'));
    result = result.replaceAll(RegExp(r'\bh\b'), hour12.toString());

    // Minute
    result = result.replaceAll('mm', date.minute.toString().padLeft(2, '0'));

    // Second
    result = result.replaceAll('ss', date.second.toString().padLeft(2, '0'));

    // AM/PM
    result = result.replaceAll('a', date.hour < 12 ? 'AM' : 'PM');

    return result;
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // PRIVATE FORMATTERS
  // ═══════════════════════════════════════════════════════════════════════════

  static String _formatFullDate(DateTime d) =>
      '${_months[d.month - 1]} ${d.day}, ${d.year}';

  static String _formatShortDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

  static String _formatIsoDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  static String _formatMonthDay(DateTime d) =>
      '${_monthsShort[d.month - 1]} ${d.day}';

  static String _formatMonthYear(DateTime d) =>
      '${_months[d.month - 1]} ${d.year}';

  static String _formatDayMonth(DateTime d) =>
      '${d.day} ${_monthsShort[d.month - 1]}';

  static String _formatTime24h(DateTime d) =>
      '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';

  static String _formatTime12h(DateTime d) {
    final hour = d.hour == 0 ? 12 : (d.hour > 12 ? d.hour - 12 : d.hour);
    final period = d.hour < 12 ? 'AM' : 'PM';
    return '$hour:${d.minute.toString().padLeft(2, '0')} $period';
  }

  static String _formatTimeWithSeconds(DateTime d) =>
      '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}:${d.second.toString().padLeft(2, '0')}';

  static String _formatFullDateTime(DateTime d) =>
      '${_formatFullDate(d)} at ${_formatTime24h(d)}';

  static String _formatShortDateTime(DateTime d) =>
      '${_formatShortDate(d)} ${_formatTime24h(d)}';

  static String _formatIsoDateTime(DateTime d) =>
      '${_formatIsoDate(d)}T${_formatTimeWithSeconds(d)}';

  static String _formatWeekdayDate(DateTime d) =>
      '${_weekdays[d.weekday - 1]}, ${_months[d.month - 1]} ${d.day}';

  static String _formatRelative(DateTime d) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateOnly = DateTime(d.year, d.month, d.day);
    final diff = today.difference(dateOnly).inDays;

    if (diff == 0) return 'Today';
    if (diff == 1) return 'Yesterday';
    if (diff == -1) return 'Tomorrow';
    if (diff > 1 && diff < 7) return '$diff days ago';
    if (diff < -1 && diff > -7) return 'In ${-diff} days';

    return _formatMonthDay(d);
  }
}

/// Extension methods for DateTime formatting.
extension DateTimeFormatX on DateTime {
  /// Format using a predefined format.
  String format(DateFormat format) => DateFormatter.format(this, format);

  /// Format using a custom pattern.
  String formatCustom(String pattern) => DateFormatter.custom(this, pattern);

  // ═══════════════════════════════════════════════════════════════════════════
  // CONVENIENCE GETTERS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Full date: "January 8, 2026"
  String get toFullDate => DateFormatter.format(this, DateFormat.fullDate);

  /// Short date: "08/01/2026"
  String get toShortDate => DateFormatter.format(this, DateFormat.shortDate);

  /// ISO date: "2026-01-08"
  String get toIsoDate => DateFormatter.format(this, DateFormat.isoDate);

  /// Time (24h): "13:30"
  String get toTime => DateFormatter.format(this, DateFormat.time24h);

  /// Time (12h): "1:30 PM"
  String get toTime12h => DateFormatter.format(this, DateFormat.time12h);

  /// Full datetime: "January 8, 2026 at 13:30"
  String get toFullDateTime =>
      DateFormatter.format(this, DateFormat.fullDateTime);

  /// Relative: "Today", "Yesterday", "2 days ago"
  String get toRelative => DateFormatter.format(this, DateFormat.relative);

  /// Weekday: "Wednesday"
  String get toWeekday => DateFormatter.format(this, DateFormat.weekday);
}
