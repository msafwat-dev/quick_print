<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages). 
-->

# Quick Print

A comprehensive Flutter package for handling PDF printing across different platforms and devices. This package provides a unified interface for printing PDFs using various printer types, including ESC/POS, Sunmi, Bluetooth, USB, and system printers.

[![pub package](https://img.shields.io/pub/v/quick_print.svg)](https://pub.dev/packages/quick_print)
[![likes](https://img.shields.io/pub/likes/quick_print)](https://pub.dev/packages/quick_print/score)
[![popularity](https://img.shields.io/pub/popularity/quick_print)](https://pub.dev/packages/quick_print/score)

## Features

- 🖨️ **Multi-printer Support**
  - Sunmi printer support for Android devices
  - Bluetooth printer integration (including BLE)
  - USB printer compatibility
  - Desktop system printer support
  - Mobile device printing
- 📄 **Paper Size Options**
  - 80mm paper width (POS printers)
  - 58mm paper width (Thermal printers)
  - A4 paper size
  - A5 paper size
  - Letter size
- 🎯 **Platform Support**
  - Android
  - iOS
  - Windows
  - Linux
  - macOS
- 🔍 **Printer Discovery**
  - Discover Bluetooth, BLE, USB, and desktop printers
  - Unified API for managing discovered printers
- 🛠️ **Error Handling**
  - Custom exceptions for invalid files, unconnected devices, and unsupported operations

## Getting Started

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  quick_print: ^1.0.0
```

Then run:
```bash
flutter pub get
```

## Usage

### Basic Usage

```dart
import 'package:quick_print/quick_print.dart';

// Create a printer instance
final printer = QuickPrint(PrinterDeviceType.mobile);

// Print a PDF file
await printer.instance.print(
  path: 'assets/document.pdf',
  paperSize: PaperSize.a4,
);
```

### Printer Discovery

The `PrinterDiscoveryService` class allows you to discover printers on various platforms.

```dart
import 'package:quick_print/quick_print.dart';

final discoveryService = PrinterDiscoveryService();

// Initialize the service (required for BLE on Windows)
await discoveryService.initialize();

// Discover printers
await discoveryService.discoverDevices();

// List discovered printers
final printers = discoveryService.printerDevicesList;
printers.forEach((printer) {
  print('Discovered printer: ${printer.name}');
});

// Dispose of the service when done
discoveryService.dispose();
```

### Bluetooth Printer

```dart
import 'package:quick_print/quick_print.dart';

// Create a Bluetooth printer model
final bluetoothModel = BluetoothPrinterModel(
  name: 'Thermal Printer',
  address: '00:11:22:33:44:55',
  isBle: false,
);

// Create a printer instance
final printer = QuickPrint(PrinterDeviceType.bluetooth);

// Print with the Bluetooth printer
await printer.instance.print(
  path: 'assets/receipt.pdf',
  paperSize: PaperSize.mm80,
  model: bluetoothModel,
);
```

### USB Printer

```dart
import 'package:quick_print/quick_print.dart';

// Create a USB printer model
final usbModel = UsbPrinterModel(
  name: 'POS-58',
  productId: '0x0483',
  vendorId: '0x5740',
);

// Create a printer instance
final printer = QuickPrint(PrinterDeviceType.usb);

// Print with the USB printer
await printer.instance.print(
  path: 'assets/receipt.pdf',
  paperSize: PaperSize.mm58,
  model: usbModel,
);
```

## Platform-specific Setup

### Android

Add the following permissions to your `AndroidManifest.xml`:

```xml
<!-- For Bluetooth printers -->
<uses-permission android:name="android.permission.BLUETOOTH"/>
<uses-permission android:name="android.permission.BLUETOOTH_ADMIN"/>
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT"/>
<uses-permission android:name="android.permission.BLUETOOTH_SCAN"/>

<!-- For USB printers -->
<uses-feature android:name="android.hardware.usb.host"/>
```

### iOS

Add the following to your `Info.plist`:

```xml
<key>UISupportedExternalAccessoryProtocols</key>
<array>
    <string>com.printer.protocol</string>
</array>

<!-- For Bluetooth printers -->
<key>NSBluetoothAlwaysUsageDescription</key>
<string>Need BT access for printing</string>
<key>NSBluetoothPeripheralUsageDescription</key>
<string>Need BT access for printing</string>
```

### macOS

Add the following entitlements to your app:

```xml
com.apple.security.print
com.apple.security.device.usb
com.apple.security.device.bluetooth
```

## Error Handling

The package uses custom exceptions for error handling:

- `PrinterException`: General printer errors
- `InvalidFileException`: Errors related to invalid files
- `InvalidTypeException`: Errors for invalid printer models
- `UnConnectedDeviceException`: Errors for unconnected devices

Example:

```dart
try {
  await printer.instance.print(
    path: 'assets/document.pdf',
    paperSize: PaperSize.a4,
  );
} on PrinterException catch (e) {
  print('Printing failed: ${e.message}');
  if (e.cause != null) {
    print('Cause: ${e.cause}');
  }
}
```

## Additional Information

- **Documentation**: Full API documentation is available [here](https://pub.dev/documentation/quick_print/latest/).
- **Examples**: Check the [example](example) directory for more detailed examples.
- **Issues**: File issues, bugs, or feature requests [here](https://github.com/YousefMohamed6/quick_print/issues).
- **Contributing**: See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For support and questions, please:
1. Check the [FAQ](https://github.com/YousefMohamed6/quick_print/wiki/FAQ) section
2. Search for existing [issues](https://github.com/YousefMohamed6/quick_print/issues)
3. Create a new issue if needed

## Acknowledgments

- Thanks to all contributors who have helped make this package better
- Special thanks to the Flutter and Dart teams for their amazing work