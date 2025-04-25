import 'package:flutter_test/flutter_test.dart';
import 'package:quick_print/src/exceptions/invalid_file_exception.dart';
import 'package:quick_print/src/exceptions/invalid_type_exception.dart';
import 'package:quick_print/src/exceptions/printer_exception.dart';
import 'package:quick_print/src/exceptions/unconnected_device_exception.dart';

void main() {
  group('PrinterException', () {
    test('creates instance with message only', () {
      const exception = PrinterException('Test error');
      expect(exception.message, 'Test error');
      expect(exception.cause, isNull);
      expect(exception.toString(), 'PrinterException: Test error');
    });

    test('creates instance with message and cause', () {
      final cause = Exception('Original error');
      final exception = PrinterException('Test error', cause);
      expect(exception.message, 'Test error');
      expect(exception.cause, cause);
      expect(
        exception.toString(),
        'PrinterException: Test error (Cause: Exception: Original error)',
      );
    });
  });

  group('InvalidFileException', () {
    test('creates instance with correct path', () {
      final exception = InvalidFileException(path: 'test.pdf');
      expect(exception.path, 'test.pdf');
      expect(exception.message, 'Invalid File test.pdf');
    });
  });

  group('InvalidTypeException', () {
    test('creates instance with correct message', () {
      final exception = InvalidTypeException('Invalid type');
      expect(exception.message, 'Invalid type');
    });
  });

  group('UnConnectedDeviceException', () {
    test('creates instance with correct device name', () {
      const exception = UnConnectedDeviceException('Test Printer');
      expect(exception.name, 'Test Printer');
      expect(exception.message, 'Test Printer is not connected');
    });
  });
}
