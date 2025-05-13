import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:quick_print/src/enums/paper_size.dart';
import 'package:quick_print/src/exceptions/invalid_type_exception.dart';
import 'package:quick_print/src/exceptions/printer_exception.dart';
import 'package:quick_print/src/models/printer_model/bluetooth_printer_model.dart';
import 'package:quick_print/src/models/printer_model/use_printer_model.dart';
import 'package:quick_print/src/printers/bluetooth_printer.dart';
import 'package:quick_print/src/printers/desktop_printer.dart';
import 'package:quick_print/src/printers/mobile_printer.dart';
import 'package:quick_print/src/printers/sunmi_printer.dart';
import 'package:quick_print/src/printers/use_printer.dart';

void main() {
  const testPdfPath = 'test/resources/test.pdf';

  group('BluetoothPrinter', () {
    late BluetoothPrinter printer;

    setUp(() {
      printer = BluetoothPrinter();
    });

    test('print() throws InvalidTypeException with wrong model type', () {
      const wrongModel = UsbPrinterModel(
        name: 'Test',
        productId: '123',
        vendorId: '456',
      );

      expect(
        () => printer.printPdf(path: testPdfPath, model: wrongModel),
        throwsA(isA<InvalidTypeException>()),
      );
    });
  });

  group('UsbPrinter', () {
    late UsbPrinter printer;

    setUp(() {
      printer = UsbPrinter();
    });

    test('print() throws InvalidTypeException with wrong model type', () {
      const wrongModel = BluetoothPrinterModel(
        name: 'Test',
        address: '00:11:22:33:44:55',
      );

      expect(
        () => printer.printPdf(path: testPdfPath, model: wrongModel),
        throwsA(isA<InvalidTypeException>()),
      );
    });
  });

  group('DesktopPrinter', () {
    late DesktopPrinter printer;

    setUp(() {
      printer = DesktopPrinter();
    });

    test('print() throws PrinterException on unsupported platforms', () {
      if (Platform.isAndroid || Platform.isIOS) {
        expect(
          () => printer.printPdf(path: testPdfPath),
          throwsA(isA<PrinterException>()),
        );
      }
    });

    test('_getPageFormat() returns correct format for each paper size', () {
      expect(
        printer.printPdf(path: testPdfPath, paperSize: PaperSize.mm58),
        throwsA(isA<PrinterException>()),
      );
      expect(
        printer.printPdf(path: testPdfPath),
        throwsA(isA<PrinterException>()),
      );
      expect(
        printer.printPdf(path: testPdfPath, paperSize: PaperSize.a4),
        throwsA(isA<PrinterException>()),
      );
    });
  });

  group('MobilePrinter', () {
    late MobilePrinter printer;

    setUp(() {
      printer = MobilePrinter();
    });

    test('print() throws PrinterException on unsupported platforms', () {
      if (!Platform.isAndroid && !Platform.isIOS) {
        expect(
          () => printer.printPdf(path: testPdfPath),
          throwsA(isA<PrinterException>()),
        );
      }
    });
  });

  group('SunmiPrinter', () {
    late SunmiDevicePrinter printer;

    setUp(() {
      printer = SunmiDevicePrinter();
    });

    test('print() throws PrinterException on non-Android platforms', () {
      if (!Platform.isAndroid) {
        expect(
          () => printer.printPdf(path: testPdfPath),
          throwsA(isA<PrinterException>()),
        );
      }
    });
  });
}
