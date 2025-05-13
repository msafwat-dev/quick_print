import 'package:quick_print/quick_print.dart';
import 'package:quick_print/src/models/printer_model/bluetooth_printer_model.dart';
import 'package:quick_print/src/models/printer_model/use_printer_model.dart';

/// Base interface for all printer models.
///
/// This interface defines the common properties that all printer models must implement.
/// It is used to provide a consistent way to identify and configure different types
/// of printers across the application.
///
/// Implementations:
/// * [BluetoothPrinterModel] - For Bluetooth printers
/// * [UsbPrinterModel] - For USB printers
///
/// Example:
/// ```dart
/// class CustomPrinterModel extends IPrinterDataModel {
///   @override
///   final String name;
///
///   @override
///   final PrinterDeviceType type;
///
///   CustomPrinterModel({
///     required this.name,
///     required this.type,
///   });
/// }
/// ```
abstract class IPrinterModel {
  /// Creates a new printer model instance.
  ///
  /// This constructor is const to allow for compile-time constant printer models.
  const IPrinterModel();

  /// The name of the printer device.
  ///
  /// This should be a human-readable name that identifies the printer,
  /// such as "Office Printer" or "Receipt Printer".
  String get name;

  /// The type of the printer device.
  ///
  /// This property determines which printer implementation will be used
  /// to communicate with the device.
  ///
  /// See [PrinterDeviceType] for available options.
  PrinterDeviceType get type;
}
