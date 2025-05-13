import 'dart:typed_data';

import 'package:flutter_pos_printer_platform_image_3_sdt/flutter_pos_printer_platform_image_3_sdt.dart'
    as pos;
import 'package:quick_print/src/enums/paper_size.dart';
import 'package:quick_print/src/exceptions/invalid_type_exception.dart';
import 'package:quick_print/src/exceptions/unconnected_device_exception.dart';
import 'package:quick_print/src/models/printer_model/bluetooth_printer_model.dart';
import 'package:quick_print/src/models/printer_model/i_printer_model.dart';
import 'package:quick_print/src/printers/interfaces/i_connection_printer.dart';

/// Bluetooth printer implementation
class BluetoothPrinter extends IConnectionPrinter {
  @override
  Future<void> printPdf({
    required String path,
    PaperSize paperSize = PaperSize.mm80,
    IPrinterModel? model,
  }) async {
    final bytes = await convertPdfToImage(path: path, paperSize: paperSize);
    await _print(model, bytes);
  }

  @override
  Future<void> printImage({
    required Uint8List bytes,
    PaperSize paperSize = PaperSize.mm80,
    IPrinterModel? model,
  }) async {
    await _print(model, bytes);
  }

  Future<void> _print(IPrinterModel? model, Uint8List bytes) async {
    if (model is! BluetoothPrinterModel) {
      throw InvalidTypeException('model must be BluetoothPrinterModel');
    }
    final printerManager = pos.PrinterManager.instance;
    final isConnected = await printerManager.connect(
      type: pos.PrinterType.bluetooth,
      model: pos.BluetoothPrinterInput(
        name: model.name,
        address: model.address,
        isBle: model.isBle,
      ),
    );
    if (!isConnected) throw UnConnectedDeviceException(model.name);
    await printerManager.send(type: pos.PrinterType.bluetooth, bytes: bytes);
  }
}
