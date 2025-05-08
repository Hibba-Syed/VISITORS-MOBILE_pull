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
      String formattedDateString =
      DateFormat("MMMM dd, yyyy hh:mm a").format(inputDateTime);
      return formattedDateString;
    }
    return '--';
  }

}
