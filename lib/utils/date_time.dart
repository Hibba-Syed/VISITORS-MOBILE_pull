import 'package:intl/intl.dart';
class DateTimeUtil {

  static String getFormattedDateTime(String? inputDateTimeString) {
    if (inputDateTimeString?.isNotEmpty ?? false) {
      DateTime dateTime = DateTime.parse(inputDateTimeString!);

      String formattedDateString =
      DateFormat("MMMM dd, yyyy hh:mm a").format(dateTime);
      return formattedDateString;
    }
    return '--';
  }
  // static String getFormattedDatesTime(DateTime? inputDateTime) {
  //   if (inputDateTime != null) {
  //     final localDateTime = inputDateTime.toLocal();
  //     String formattedDateString =
  //     DateFormat("MMMM dd, yyyy hh:mm a").format(localDateTime);
  //     return formattedDateString;
  //   }
  //   return '--';
  // }


  static String getFormattedDatesTime(dynamic inputDateTime) {
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
    String formattedDateString = DateFormat("MMMM dd, yyyy hh:mm a").format(localDateTime);
    return formattedDateString;
  }


  static String getFormattedDate(DateTime? inputDateTime) {
    if (inputDateTime != null) {
      String formattedDateString =
      DateFormat("MMMM dd, yyyy").format(inputDateTime);
      return formattedDateString;
    }
    return '--';
  }

}
