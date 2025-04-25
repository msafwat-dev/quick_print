import 'package:flutter_test/flutter_test.dart';
import 'package:quick_print/quick_print.dart';
import 'package:quick_print/src/printers/bluetooth_printer.dart';
import 'package:quick_print/src/printers/desktop_printer.dart';
import 'package:quick_print/src/printers/mobile_printer.dart';
import 'package:quick_print/src/printers/sunmi_printer.dart';
import 'package:quick_print/src/printers/use_printer.dart';

void main() {
  group('QuickPrint', () {
    test('creates correct printer instance based on type', () {
      expect(
        QuickPrint(PrinterDeviceType.bluetooth).instance,
        isA<BluetoothPrinter>(),
      );
      expect(QuickPrint(PrinterDeviceType.usb).instance, isA<UsbPrinter>());
      expect(
        QuickPrint(PrinterDeviceType.desktop).instance,
        isA<DesktopPrinter>(),
      );
      expect(
        QuickPrint(PrinterDeviceType.mobile).instance,
        isA<MobilePrinter>(),
      );
      expect(
        QuickPrint(PrinterDeviceType.sunmi).instance,
        isA<SunmiDevicePrinter>(),
      );
    });

    test('equals operator works correctly', () {
      final printer1 = QuickPrint(PrinterDeviceType.bluetooth);
      final printer2 = QuickPrint(PrinterDeviceType.bluetooth);
      final printer3 = QuickPrint(PrinterDeviceType.usb);

      expect(printer1 == printer2, isTrue);
      expect(printer1 == printer3, isFalse);
    });

    test('toString returns correct string representation', () {
      final printer = QuickPrint(PrinterDeviceType.bluetooth);
      expect(printer.toString(), 'Printer(type: PrinterDeviceType.bluetooth)');
    });
  });
}
