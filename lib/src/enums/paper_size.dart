/// Defines the paper size for printing.
///
/// This enum represents different paper sizes that can be used for printing.
/// It includes both standard paper sizes (like A4) and common receipt printer
/// paper widths (like 80mm and 58mm).
///
/// Example:
/// ```dart
/// await printer.print(
///   path: 'document.pdf',
///   paperSize: PaperSize.a4,
/// );
/// ```
enum PaperSize {
  /// 80mm paper width, commonly used in POS printers.
  /// Typical for retail receipts and larger thermal printers.
  /// Width: 80mm (3.15 inches)
  mm80,

  /// 58mm paper width, commonly used in thermal printers.
  /// Popular for compact receipt printers and mobile printers.
  /// Width: 58mm (2.28 inches)
  mm58,

  /// Standard A4 paper size (210 × 297 mm).
  /// The most common paper size for documents worldwide.
  /// Width: 210mm (8.27 inches)
  /// Height: 297mm (11.69 inches)
  a4,
}
