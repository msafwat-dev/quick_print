import 'dart:typed_data';

import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart' as pos;
import 'package:image/image.dart' as img;
import 'package:pdfx/pdfx.dart';
import 'package:quick_print/src/enums/paper_size.dart';
import 'package:quick_print/src/exceptions/invalid_file_exception.dart';
import 'package:quick_print/src/printers/interfaces/i_printer.dart';

/// IConnectionPrinter abstract class
///
/// Provides methods for converting PDF files to images and handling paper sizes for printing.
abstract class IConnectionPrinter implements IPrinter {
  /// Returns the corresponding pos.PaperSize value based on the provided PaperSize enum value.
  ///
  /// This method is used to map the paper size enum values to the pos.PaperSize values used by the printer.
  ///
  /// @param paperSize The PaperSize enum value to convert.
  /// @return The corresponding pos.PaperSize value.
  pos.PaperSize _getPaperSize(PaperSize paperSize) {
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
      final generator = pos.Generator(_getPaperSize(paperSize), profile);
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
