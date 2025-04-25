import 'dart:io';

import 'package:printing/printing.dart';
import 'package:quick_print/src/enums/paper_size.dart';
import 'package:quick_print/src/exceptions/printer_exception.dart';
import 'package:quick_print/src/models/printer_model/i_printer_model.dart';
import 'package:quick_print/src/printers/interfaces/i_printer.dart';

/// Mobile printer implementation
class MobilePrinter implements IPrinter {
  @override
  Future<void> print({
    required String path,
    PaperSize paperSize = PaperSize.mm80,
    IPrinterModel? model,
  }) async {
    if (!Platform.isAndroid && !Platform.isIOS) {
      throw const PrinterException(
        'Mobile Printer is only supported on Android, IOS',
      );
    }
    final file = File(path);
    final bytes = await file.readAsBytes();
    await Printing.layoutPdf(onLayout: (format) => bytes);
  }
}
