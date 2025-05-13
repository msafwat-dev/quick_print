import 'dart:typed_data';

import 'package:flutter_pos_printer_platform_image_3_sdt/flutter_pos_printer_platform_image_3_sdt.dart'
    as printer;
import 'package:quick_print/src/enums/paper_size.dart';
import 'package:quick_print/src/exceptions/invalid_type_exception.dart';
import 'package:quick_print/src/exceptions/unconnected_device_exception.dart';
import 'package:quick_print/src/models/printer_model/i_printer_model.dart';
import 'package:quick_print/src/models/printer_model/use_printer_model.dart';
import 'package:quick_print/src/printers/interfaces/i_printer.dart';

/// Printer implementation for USB-connected printers.
class UsbPrinter with IPrinterMixin implements IPrinter {
  @override
  Future<void> printPdf({
    required String path,
    PaperSize paperSize = PaperSize.mm80,
    IPrinterModel? model,
  }) async {
    final bytes = await convertPdfToImage(path: path, paperSize: paperSize);
    await _print(model, bytes, paperSize);
  }

  Future<void> _print(
    IPrinterModel? model,
    Uint8List bytes,
    PaperSize paperSize,
  ) async {
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

    await printerManager.send(type: printer.PrinterType.usb, bytes: bytes);
  }

  @override
  Future<void> printImage({
    required Uint8List bytes,
    PaperSize paperSize = PaperSize.mm80,
    IPrinterModel? model,
  }) async {
    await _print(model, bytes, paperSize);
  }
}
