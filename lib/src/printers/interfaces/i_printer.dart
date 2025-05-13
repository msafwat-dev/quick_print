import 'dart:typed_data';

import 'package:quick_print/src/enums/paper_size.dart';
import 'package:quick_print/src/models/printer_model/i_printer_model.dart';

/// Abstract class representing a printer interface.
///
/// This class defines a contract for printer implementations to follow.
abstract interface class IPrinter {
  /// Prints a document to the printer.
  ///
  /// [path] is the file path of the document to print.
  /// [paperSize] is the size of the paper to use for printing (default is 80mm).
  /// [model] is the printer model to use (optional).
  ///
  /// Returns a Future that completes when the printing is done.
  Future<void> printPdf({
    required String path,
    PaperSize paperSize = PaperSize.mm80,
    IPrinterModel? model,
  });

  /// Prints an image to the printer.
  ///
  /// [bytes] is the image data to print as a Uint8List.
  /// [paperSize] is the size of the paper to use for printing (default is 80mm).
  /// [model] is the printer model to use (optional).
  ///
  /// Returns a Future that completes when the printing is done.
  Future<void> printImage({
    required Uint8List bytes,
    PaperSize paperSize = PaperSize.mm80,
    IPrinterModel? model,
  });
}
