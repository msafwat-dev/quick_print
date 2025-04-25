import 'package:printing/printing.dart' as printer;
import 'package:quick_print/quick_print.dart';
import 'package:quick_print/src/models/printer_model/i_printer_model.dart';

/// A class representing a desktop printer model.
///
/// This class extends the `printer.Printer` class and implements the `IPrinterModel` interface.
/// It provides a concrete implementation of a desktop printer model.
class DesktopPrinterModel extends printer.Printer implements IPrinterModel {
  /// Constructs a new instance of the `DesktopPrinterModel` class.
  ///
  /// [url] The URL of the printer.
  /// [name] The name of the printer.
  /// [isAvailable] Whether the printer is available.
  /// [isDefault] Whether the printer is the default printer.
  /// [location] The location of the printer.
  /// [comment] A comment about the printer.
  /// [model] The model of the printer.
  const DesktopPrinterModel({
    required super.url,
    required super.name,
    required super.isAvailable,
    required super.isDefault,
    super.location,
    super.comment,
    super.model,
  });

  /// Gets the type of printer device.
  ///
  /// Returns `PrinterDeviceType.desktop` for this class.
  @override
  PrinterDeviceType get type => PrinterDeviceType.desktop;
}
