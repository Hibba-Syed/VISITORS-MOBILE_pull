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
}
