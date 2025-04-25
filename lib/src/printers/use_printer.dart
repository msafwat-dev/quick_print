import 'package:flutter_pos_printer_platform_image_3_sdt/flutter_pos_printer_platform_image_3_sdt.dart'
    as printer;
import 'package:quick_print/src/enums/paper_size.dart';
import 'package:quick_print/src/exceptions/invalid_type_exception.dart';
import 'package:quick_print/src/exceptions/unconnected_device_exception.dart';
import 'package:quick_print/src/models/printer_model/i_printer_model.dart';
import 'package:quick_print/src/models/printer_model/use_printer_model.dart';
import 'package:quick_print/src/printers/interfaces/i_connection_printer.dart';

class UsbPrinter extends IConnectionPrinter {
  @override
  Future<void> print({
    required String path,
    PaperSize paperSize = PaperSize.mm80,
    IPrinterModel? model,
  }) async {
    if (model is! UsbPrinterModel) {
      throw InvalidTypeException('model must be UsbPrinterModel');
    }
    final device = model;
    final printerManager = printer.PrinterManager.instance;
    final isConnected = await printerManager.connect(
      type: printer.PrinterType.usb,
      model: printer.UsbPrinterInput(
        name: device.name,
        productId: device.productId,
        vendorId: device.vendorId,
      ),
    );
    if (!isConnected) {
      throw UnConnectedDeviceException(device.name);
    }
    final bytes = await convertPdfToImage(path: path, paperSize: paperSize);
    await printerManager.send(type: printer.PrinterType.usb, bytes: bytes);
  }
}
