class AppException implements Exception {
  final String? _message;
  final String? _prefix;

  AppException( [this._message, this._prefix]);

  @override
  String toString() {
    return "${_prefix??''}$_message";
  }
}

// This exception is for API timeout
class FetchDataException extends AppException{
  FetchDataException([super.message]);
}

// This exception is for invalid API url
class BadRequestException extends AppException {
  BadRequestException([super.message]);
}

// This exception is for unauthorised tokens
class UnauthorisedException extends AppException {
  UnauthorisedException([super.message]);
}

class InvalidInputException extends AppException {
  InvalidInputException([super.message]);
}

class NotFoundException extends AppException {
  NotFoundException([super.message, super.prefix]);
}

class QuantityNotFoundException extends AppException{
  QuantityNotFoundException([super.message, super.prefix]);
}
