import 'dart:io';
import 'dart:typed_data';

import 'package:printing/printing.dart';
import 'package:quick_print/src/enums/paper_size.dart';
import 'package:quick_print/src/exceptions/printer_exception.dart';
import 'package:quick_print/src/models/printer_model/i_printer_model.dart';
import 'package:quick_print/src/printers/interfaces/i_printer.dart';

/// Mobile printer implementation
class MobilePrinter implements IPrinter {
  @override
  Future<void> printPdf({
    required String path,
    PaperSize paperSize = PaperSize.mm80,
    IPrinterModel? model,
  }) async {
    final file = File(path);
    final bytes = await file.readAsBytes();
    await _print(bytes);
  }

  Future<void> _print(Uint8List bytes) async {
    if (!Platform.isAndroid && !Platform.isIOS) {
      throw const PrinterException(
        'Mobile Printer is only supported on Android, IOS',
      );
    }
    await Printing.layoutPdf(onLayout: (format) => bytes);
  }

  @override
  Future<void> printImage({
    required Uint8List bytes,
    PaperSize paperSize = PaperSize.mm80,
    IPrinterModel? model,
  }) async {
    await _print(bytes);
  }
}
