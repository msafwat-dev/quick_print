// Model for Bluetooth printers

import 'package:quick_print/quick_print.dart';
import 'package:quick_print/src/models/printer_model/i_printer_model.dart';

/// Model representing a Bluetooth printer device
class BluetoothPrinterModel extends IPrinterModel {
  /// Creates a new Bluetooth printer model
  ///
  /// [name] is the display name of the printer
  /// [address] is the MAC address of the Bluetooth device
  /// [isBle] indicates if the printer uses Bluetooth Low Energy
  const BluetoothPrinterModel({
    required this.name,
    required this.address,
    this.isBle = false,
  });
  @override
  final String name;

  /// The MAC address of the Bluetooth device
  final String address;

  /// Whether the printer uses Bluetooth Low Energy (BLE)
  final bool isBle;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BluetoothPrinterModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          address == other.address &&
          isBle == other.isBle;

  @override
  int get hashCode => name.hashCode ^ address.hashCode ^ isBle.hashCode;

  @override
  String toString() =>
      'BluetoothPrinterModel(name: $name, address: $address, isBle: $isBle)';
  @override
  PrinterDeviceType get type => PrinterDeviceType.bluetooth;
}
