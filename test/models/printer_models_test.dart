import 'package:flutter_test/flutter_test.dart';
import 'package:quick_print/src/enums/printer_device_type.dart';
import 'package:quick_print/src/models/printer_model/bluetooth_printer_model.dart';
import 'package:quick_print/src/models/printer_model/decktop_printer_model.dart';
import 'package:quick_print/src/models/printer_model/use_printer_model.dart';

void main() {
  group('BluetoothPrinterModel', () {
    test('creates instance with correct values', () {
      const model = BluetoothPrinterModel(
        name: 'Test Printer',
        address: '00:11:22:33:44:55',
        isBle: true,
      );

      expect(model.name, 'Test Printer');
      expect(model.address, '00:11:22:33:44:55');
      expect(model.isBle, true);
      expect(model.type, PrinterDeviceType.bluetooth);
    });

    test('equals operator works correctly', () {
      const model1 = BluetoothPrinterModel(
        name: 'Test Printer',
        address: '00:11:22:33:44:55',
        isBle: true,
      );
      const model2 = BluetoothPrinterModel(
        name: 'Test Printer',
        address: '00:11:22:33:44:55',
        isBle: true,
      );
      const model3 = BluetoothPrinterModel(
        name: 'Other Printer',
        address: '00:11:22:33:44:55',
        isBle: true,
      );

      expect(model1 == model2, isTrue);
      expect(model1 == model3, isFalse);
    });

    test('toString returns correct string representation', () {
      const model = BluetoothPrinterModel(
        name: 'Test Printer',
        address: '00:11:22:33:44:55',
        isBle: true,
      );

      expect(
        model.toString(),
        'BluetoothPrinterModel(name: Test Printer, address: 00:11:22:33:44:55, isBle: true)',
      );
    });
  });

  group('UsbPrinterModel', () {
    test('creates instance with correct values', () {
      const model = UsbPrinterModel(
        name: 'Test USB Printer',
        productId: '0x0483',
        vendorId: '0x5740',
      );

      expect(model.name, 'Test USB Printer');
      expect(model.productId, '0x0483');
      expect(model.vendorId, '0x5740');
      expect(model.type, PrinterDeviceType.usb);
    });

    test('equals operator works correctly', () {
      const model1 = UsbPrinterModel(
        name: 'Test USB Printer',
        productId: '0x0483',
        vendorId: '0x5740',
      );
      const model2 = UsbPrinterModel(
        name: 'Test USB Printer',
        productId: '0x0483',
        vendorId: '0x5740',
      );
      const model3 = UsbPrinterModel(
        name: 'Other USB Printer',
        productId: '0x0483',
        vendorId: '0x5740',
      );

      expect(model1 == model2, isTrue);
      expect(model1 == model3, isFalse);
    });

    test('toString returns correct string representation', () {
      const model = UsbPrinterModel(
        name: 'Test USB Printer',
        productId: '0x0483',
        vendorId: '0x5740',
      );

      expect(
        model.toString(),
        'UsbPrinterModel(name: Test USB Printer, productId: 0x0483, vendorId: 0x5740)',
      );
    });
  });

  group('DesktopPrinterModel', () {
    test('creates instance with correct values', () {
      const model = DesktopPrinterModel(
        name: 'Test Desktop Printer',
        url: 'printer://test',
        isAvailable: true,
        isDefault: false,
        location: 'Office',
        comment: 'Test printer',
        model: 'HP LaserJet',
      );

      expect(model.name, 'Test Desktop Printer');
      expect(model.url, 'printer://test');
      expect(model.isAvailable, true);
      expect(model.isDefault, false);
      expect(model.location, 'Office');
      expect(model.comment, 'Test printer');
      expect(model.model, 'HP LaserJet');
      expect(model.type, PrinterDeviceType.desktop);
    });
  });
}
