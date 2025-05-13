import 'dart:io';
import 'dart:typed_data';

import 'package:pdf/pdf.dart' as pdf;
import 'package:printing/printing.dart' as package;
import 'package:quick_print/src/enums/paper_size.dart';
import 'package:quick_print/src/exceptions/printer_exception.dart';
import 'package:quick_print/src/models/printer_model/i_printer_model.dart';
import 'package:quick_print/src/printers/interfaces/i_printer.dart';

/// Desktop printer implementation
class DesktopPrinter with IPrinterMixin implements IPrinter {
  pdf.PdfPageFormat _getPageFormat(PaperSize paperSize) {
    switch (paperSize) {
      case PaperSize.mm58:
        return const pdf.PdfPageFormat(
          pdf.PdfPageFormat.mm * 58,
          double.infinity,
        );
      case PaperSize.mm80:
        return const pdf.PdfPageFormat(
          pdf.PdfPageFormat.mm * 80,
          double.infinity,
        );
      case PaperSize.a4:
        return pdf.PdfPageFormat.a4;
    }
  }

  @override
  Future<void> printPdf({
    required String path,
    PaperSize paperSize = PaperSize.mm80,
    IPrinterModel? model,
  }) async {
    final file = File(path);
    final bytes = await file.readAsBytes();
    if (!Platform.isWindows && !Platform.isLinux && !Platform.isMacOS) {
      throw throw const PrinterException(
        'Desktop is only supported on Windows, Linux and MacOS',
      );
    }

    await package.Printing.directPrintPdf(
      printer: model as package.Printer,
      format: _getPageFormat(paperSize),
      onLayout: (format) async => bytes,
    );
  }

  @override
  Future<void> printImage({
    required Uint8List bytes,
    PaperSize paperSize = PaperSize.mm80,
    IPrinterModel? model,
  }) async {
    final path = await convertImageToPdf(bytes);
    await printPdf(path: path, model: model, paperSize: paperSize);
  }
}
