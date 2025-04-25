/// A custom exception class that represents an error related to an invalid file.
///
/// This exception is thrown when a file is invalid or cannot be processed.
class InvalidFileException implements Exception {
  /// Creates a new instance of [InvalidFileException] with the given [path].
  ///
  /// The [path] parameter is required and represents the file path associated with the error.
  InvalidFileException({required this.path});

  /// The file path associated with the error.
  final String path;

  /// Returns a string message that describes the error, including the file path that caused the exception.
  String get message => 'Invalid File $path';
}
