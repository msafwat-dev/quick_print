import 'package:flutter/foundation.dart';
import 'package:quick_print/src/enums/printer_device_type.dart';
import 'package:quick_print/src/printers/interfaces/i_printer.dart';
import 'package:quick_print/src/service/printer_device_factory.dart';

/// Main printer class that provides access to different printer implementations
class QuickPrint {
  /// Creates a new printer instance for the specified device type
  ///
  /// [type] determines which printer implementation to use
  QuickPrint(this.type) : instance = PrinterDeviceFactory().createDevice(type);

  /// Creates a new printer instance with a specific implementation
  ///
  /// This constructor is mainly used for testing purposes
  @visibleForTesting
  const QuickPrint.fromInstance(this.type, this.instance);

  /// The type of printer device
  final PrinterDeviceType type;

  /// The printer implementation instance
  final IPrinter instance;

  @override
  String toString() => 'Printer(type: $type)';
}
