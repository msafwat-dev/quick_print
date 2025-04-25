/// A custom exception class that represents an error when a device is not connected.
class UnConnectedDeviceException implements Exception {
  /// Initializes the exception with a device name.
  ///
  /// [name] The name of the device that is not connected.
  const UnConnectedDeviceException(this.name);

  /// The name of the device that is not connected.
  final String name;

  /// Returns a message describing the exception, including the name of the device that is not connected.
  String get message => '$name is not connected';
}
