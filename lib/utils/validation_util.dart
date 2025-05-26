class ValidationUtil {
  static bool isValid(Object? value) {
    return !(value == null || value == false || value.toString().isEmpty);
  }

  static bool isEmailValid(String? value) {
    if (value?.isEmpty ?? true) {
      return false;
    }
    RegExp emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    );
    return emailRegex.hasMatch(value!);
  }

  String? validatePassword(String? value) {
    if (value?.isEmpty ?? true) {
      return 'required';
    }
    if (!_hasMinimumLength(value!)) {
      return 'Password must be at least 8 characters long';
    }
    if (!_hasDigit(value)) {
      return 'Password should contain at least one digit';
    }
    if (!_hasSpecialCharacter(value)) {
      return 'Password should contain at least one special character';
    }
    if (!_hasUpperCase(value)) {
      return 'Password should contain at least one upper case alphabet';
    }
    return null;
  }

  bool _hasMinimumLength(String value) {
    return value.length >= 8;
  }

  bool _hasDigit(String value) {
    return RegExp(r'\d').hasMatch(value);
  }

  bool _hasSpecialCharacter(String value) {
    return RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);
  }

  bool _hasUpperCase(String value) {
    return RegExp(r'[A-Z]').hasMatch(value);
  }
}
