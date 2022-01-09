class AppException implements Exception {
  final String? message;
  final String? prefix;

  AppException(this.message, this.prefix);

  String toString() {
    return '$message';
  }
}

class FetchDataException extends AppException {
  FetchDataException(message) : super(message, 'Error During Communication: ');
}


class ApiException extends AppException {
  ApiException(message) : super(message, '');
}
