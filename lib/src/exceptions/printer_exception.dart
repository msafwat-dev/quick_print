/// Exception thrown when a printer operation fails
class PrinterException implements Exception {
  /// Creates a new printer exception
  ///
  /// [message] describes what went wrong
  /// [cause] is the original error that caused this exception (optional)
  const PrinterException(this.message, [this.cause]);

  /// The error message
  final String message;

  /// The original error that caused this exception
  final Object? cause;

  @override
  String toString() {
    if (cause != null) {
      return 'PrinterException: $message (Cause: $cause)';
    }
    return 'PrinterException: $message';
  }
}
