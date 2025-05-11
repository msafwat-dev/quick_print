/// Custom exception thrown when an invalid type is encountered.
library;

/// Initializes the exception with a custom error message.
///
class InvalidTypeException implements Exception {
  /// [message] The error message to be stored with the exception.
  InvalidTypeException(this.message);

  /// The custom error message associated with the exception.
  final String message;
}
