import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeUtil {
  // static String getFormattedDateTime(String? inputDateTimeString) {
  //   if (inputDateTimeString?.isNotEmpty ?? false) {
  //     DateTime dateTime = DateTime.parse(inputDateTimeString!);
  //
  //     String formattedDateString =
  //     DateFormat("MMMM dd, yyyy hh:mm a").format(dateTime);
  //     return formattedDateString;
  //   }
  //   return '--';
  // }

  static String getFormattedDateTime(dynamic inputDateTime) {
    DateTime? dateTime;

    if (inputDateTime == null) {
      return '--';
    }

    if (inputDateTime is DateTime) {
      dateTime = inputDateTime;
    } else if (inputDateTime is String) {
      try {
        dateTime = DateTime.parse(inputDateTime);
      } catch (e) {
        return '--';
      }
    } else {
      return '--';
    }

    final localDateTime = dateTime.toLocal();
    String formattedDateString =
        DateFormat("MMMM dd, yyyy hh:mm a").format(localDateTime);
    return formattedDateString;
  }

  static String getFormattedTime(dynamic inputDateTime) {
    DateTime? dateTime;

    if (inputDateTime == null) {
      return '--';
    }

    if (inputDateTime is DateTime) {
      dateTime = inputDateTime;
    } else if (inputDateTime is String) {
      try {
        dateTime = DateTime.parse(inputDateTime);
      } catch (e) {
        return '--';
      }
    } else {
      return '--';
    }

    final localDateTime = dateTime.toLocal();
    String formattedDateString = DateFormat("hh:mm a").format(localDateTime);
    return formattedDateString;
  }

  static String getFormattedDate(dynamic inputDateTime) {
    DateTime? dateTime;

    if (inputDateTime == null) {
      return '--';
    }

    if (inputDateTime is DateTime) {
      dateTime = inputDateTime;
    } else if (inputDateTime is String) {
      try {
        dateTime = DateTime.parse(inputDateTime);
      } catch (e) {
        return '--';
      }
    } else {
      return '--';
    }

    final localDateTime = dateTime.toLocal();
    String formattedDateString =
        DateFormat("MMMM dd, yyyy").format(localDateTime);
    return formattedDateString;
  }

  static String getFormatDateRange(DateTimeRange? range) {
    if (range == null) return "";
    final format = DateFormat('yyyy-MM-dd');
    return '${format.format(range.start)} - ${format.format(range.end)}';
  }

  static DateTime? tryParseDate(String raw) {
    final formats = [
      'dd/MM/yyyy',
      'dd-MM-yyyy',
      'dd.MM.yyyy',
      'dd MMM yyyy',
      'dd-MMM-yyyy',
      'yyyy/MM/dd',
      'yyyy-MM-dd',
      'yyyy.MM.dd',
      'dd MMMM yyyy',
    ];

    for (final format in formats) {
      try {
        final date = DateFormat(format).tryParse(raw);
        return date;
      } catch (_) {
        return null;
      }
    }
    return null;
  }
}
