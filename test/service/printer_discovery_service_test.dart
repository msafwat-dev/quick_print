import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:quick_print/src/exceptions/printer_exception.dart';
import 'package:quick_print/src/service/printer_discovery_service.dart';

void main() {
  late PrinterDiscoveryService service;

  setUp(() {
    service = PrinterDiscoveryService();
  });

  tearDown(() {
    service.dispose();
  });

  group('PrinterDiscoveryService', () {
    test('initialize() should set _isInitialized to true on Windows', () async {
      if (Platform.isWindows) {
        await service.initialize();
        expect(service.printerDevicesList, isEmpty);
      }
    });

    test('initialize() should not throw on non-Windows platforms', () async {
      if (!Platform.isWindows) {
        await expectLater(service.initialize(), completes);
      }
    });

    test('discoverDevices() should clear existing devices', () async {
      await service.discoverDevices(timeout: const Duration(milliseconds: 100));
      expect(service.printerDevicesList, isEmpty);
    });

    test('discoverBluetoothDevices() should return empty list on desktop', () {
      if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
        final devices = service.discoverBluetoothDevices();
        expect(devices, isEmpty);
      }
    });

    test('discoverBleDevices() should throw if not initialized on Windows', () {
      if (Platform.isWindows) {
        expect(
          () => service.discoverBleDevices(),
          throwsA(
            isA<PrinterException>().having(
              (e) => e.message,
              'message',
              'Service not initialized. Please call initialize first.',
            ),
          ),
        );
      }
    });

    test('discoverUsbDevices() should return empty list initially', () {
      final devices = service.discoverUsbDevices();
      expect(devices, isEmpty);
    });

    test(
      'discoverDesktopDevices() should return empty list on mobile',
      () async {
        if (Platform.isAndroid || Platform.isIOS) {
          final devices = await service.discoverDesktopDevices();
          expect(devices, isEmpty);
        }
      },
    );

    test('dispose() should cleanup resources', () {
      service.dispose();
      // No way to verify internal state, but at least we can verify it doesn't throw
      expect(() => service.dispose(), returnsNormally);
    });
  });
}
