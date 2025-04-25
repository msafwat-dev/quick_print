/// Custom exception thrown when an invalid type is encountered.
library;

class InvalidTypeException implements Exception {
  /// Initializes the exception with a custom error message.
  ///
  /// [message] The error message to be stored with the exception.
  InvalidTypeException(this.message);

  /// The custom error message associated with the exception.
  final String message;
}
