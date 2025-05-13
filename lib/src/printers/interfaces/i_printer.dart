import 'dart:io';
import 'dart:typed_data';

import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart' as pos;
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdfx/pdfx.dart';
import 'package:quick_print/src/enums/paper_size.dart';
import 'package:quick_print/src/exceptions/invalid_file_exception.dart';
import 'package:quick_print/src/models/printer_model/i_printer_model.dart';

/// Abstract class representing a printer interface.
///
/// This class defines a contract for printer implementations to follow.
abstract class IPrinter {
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

/// A mixin class that provides a blueprint for printer-related functionality.
///
/// This mixin can be used to define shared behavior or properties for
/// classes that implement printing capabilities.
mixin class IPrinterMixin {
  /// Converts a image file to an PDF,
  ///
  /// @param bytes The bytes of the image file to convert.
  /// @return The converted PDF as a String.
  Future<String> convertImageToPdf(Uint8List bytes) async {
    try {
      final pdf = pw.Document();
      final image = pw.MemoryImage(bytes);
      pdf.addPage(
        pw.Page(
          build: (context) => pw.Center(
            child: pw.Image(image),
          ),
        ),
      );
      final outputDir = await getTemporaryDirectory();
      final file = File('${outputDir.path}/output.pdf');
      await file.writeAsBytes(await pdf.save());
      return file.path;
    } catch (e) {
      throw InvalidFileException(path: e.toString());
    }
  }

  /// Returns the corresponding pos.PaperSize value based on the provided PaperSize enum value.
  ///
  /// This method is used to map the paper size enum values to the pos.PaperSize values used by the printer.
  ///
  /// @param paperSize The PaperSize enum value to convert.
  /// @return The corresponding pos.PaperSize value.
  pos.PaperSize getPaperSize(PaperSize paperSize) {
    switch (paperSize) {
      case PaperSize.mm58:
        return pos.PaperSize.mm58;
      case PaperSize.mm80:
        return pos.PaperSize.mm80;
      case PaperSize.a4:
        return pos.PaperSize.mm80;
    }
  }

  /// Converts a PDF file to an image, scaled to the specified width and height factors.
  ///
  /// @param path The file path of the PDF file to convert.
  /// @param paperSize The paper size to use for printing.
  /// @param widthScale The width scale factor to apply to the image. Defaults to 2.5.
  /// @param heightScale The height scale factor to apply to the image. Defaults to 1.7.
  /// @return The converted image as a Uint8List.
  /// @throws InvalidFileException If the PDF file cannot be opened or rendered.
  Future<Uint8List> convertPdfToImage({
    required String path,
    required PaperSize paperSize,
    double widthScale = 2.5,
    double heightScale = 1.7,
  }) async {
    try {
      final document = await PdfDocument.openFile(path);
      final page = await document.getPage(1);
      final image = await page.render(
        width: page.width * widthScale,
        height: page.height * heightScale,
      );
      if (image == null) {
        throw InvalidFileException(path: path);
      }
      final profile = await pos.CapabilityProfile.load();
      final generator = pos.Generator(getPaperSize(paperSize), profile);
      final decodedImage = img.decodeJpg(image.bytes);
      if (decodedImage == null) {
        throw InvalidFileException(path: path);
      }
      return Uint8List.fromList(generator.image(decodedImage));
    } on Exception catch (_) {
      throw InvalidFileException(path: path);
    }
  }
}
