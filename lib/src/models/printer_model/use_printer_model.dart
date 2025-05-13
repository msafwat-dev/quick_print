import 'package:quick_print/src/enums/printer_device_type.dart';
import 'package:quick_print/src/models/printer_model/i_printer_model.dart';

/// Model representing a USB printer device.
///
/// This class implements the [IPrinterModel] interface for USB printers, providing
/// properties for the printer's name, product ID, and vendor ID. It is used to identify
/// and manage USB printers within the application.
class UsbPrinterModel extends IPrinterModel {
  /// Creates a new USB printer model
  ///
  /// [name] is the display name of the printer
  /// [productId] is the USB product ID (e.g., '0x0483')
  /// [vendorId] is the USB vendor ID (e.g., '0x5740')
  const UsbPrinterModel({
    required this.name,
    required this.productId,
    required this.vendorId,
  });
  @override
  final String name;

  /// The product ID of the USB device
  final String productId;

  /// The vendor ID of the USB device
  final String vendorId;


  @override
  String toString() =>
      'UsbPrinterModel(name: $name, productId: $productId, vendorId: $vendorId)';

  /// Gets the type of printer device.
  ///
  /// Returns [PrinterDeviceType.usb] for this class.
  @override
  PrinterDeviceType get type => PrinterDeviceType.usb;
}
