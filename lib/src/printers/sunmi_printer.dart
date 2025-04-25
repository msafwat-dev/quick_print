import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:quick_print/src/enums/paper_size.dart';
import 'package:quick_print/src/exceptions/printer_exception.dart';
import 'package:quick_print/src/models/printer_model/i_printer_model.dart';
import 'package:quick_print/src/printers/interfaces/i_connection_printer.dart';
import 'package:sunmi_printer_plus/core/enums/enums.dart';
import 'package:sunmi_printer_plus/core/sunmi/sunmi_printer.dart';

class SunmiDevicePrinter extends IConnectionPrinter {
  @override
  Future<void> print({
    required String path,
    PaperSize paperSize = PaperSize.mm80,
    IPrinterModel? model,
  }) async {
    if (!Platform.isAndroid) {
      throw const PrinterException(
        'Sunmi printer is only supported on Android',
      );
    }
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    if (!androidInfo.brand.contains('SUNMI')) {
      throw const PrinterException(
        'Sunmi printer is only supported on Sunmi devices',
      );
    }
    final bytes = await convertPdfToImage(
      path: path,
      paperSize: paperSize,
      widthScale: 2.7,
      heightScale: 1.8,
    );
    await SunmiPrinter.printImage(bytes, align: SunmiPrintAlign.CENTER);
  }
}
