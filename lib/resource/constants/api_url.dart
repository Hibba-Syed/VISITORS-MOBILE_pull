class ApiUrl {
  static const String baseUrl = 'https://staging.iskaanapi.com';

  ///
  static const String dashboard = '$baseUrl/';
  static const String login = '$baseUrl/auth/login/visitor';
  static const String logout = '$baseUrl/visitor/logout';
  static const String profile = '$baseUrl/visitor/profile';
  static const String checkIns = '$baseUrl/visitor/check-ins';
  static const String checkInLogs = '$baseUrl/visitor/get-logs';
  static const String checkOutAll = '$baseUrl/visitor/check-out-all';
  static const String units = '$baseUrl/visitor/units';
  static const String vendors = '$baseUrl/visitor/vendors';
  static const String counts = '$baseUrl/visitor/counts';
  static const String service = '$baseUrl/visitor/e-services';
  static const String workOrder = '$baseUrl/visitor/work-orders';
  static const String checkOuts = '$baseUrl/visitor/check-outs';
  static const String messages = '$baseUrl/visitor/messages';
  static const String sendMessage = '$messages/send';
  static const String serviceDetails = '$baseUrl/visitor/all-applications/one';
  static const String workOrderDetails = '$baseUrl/visitor/job';
  static const String addWorkOrderLog = '$baseUrl/visitor/log-job';
  static const String visitorPasses = '$baseUrl/visitor/visitor-passes';
}
