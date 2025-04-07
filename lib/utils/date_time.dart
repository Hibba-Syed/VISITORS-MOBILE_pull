import 'package:intl/intl.dart';
class DateTimeUtil {
  static String getFormattedDate(String? inputDateString) {
    if (inputDateString?.isNotEmpty ?? false) {
      DateTime dateTime = DateTime.parse(inputDateString!).toLocal();
      String formattedDateString = DateFormat.yMMMMd().format(dateTime);
      return formattedDateString;
    }
    return '--';
  }

  static String getFormattedDateTime(String? inputDateTimeString) {
    if (inputDateTimeString?.isNotEmpty ?? false) {
      DateTime dateTime = DateTime.parse(inputDateTimeString!);

      String formattedDateString =
      DateFormat("MMMM dd, yyyy hh:mm a").format(dateTime);
      return formattedDateString;
    }
    return '--';
  }
}
