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
  static String getFormattedDatesTime(DateTime? inputDateTime) {
    if (inputDateTime != null) {
      final localDateTime = inputDateTime.toLocal(); // Convert from UTC to local
      String formattedDateString =
      DateFormat("MMMM dd, yyyy hh:mm a").format(localDateTime);
      return formattedDateString;
    }
    return '--';
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
