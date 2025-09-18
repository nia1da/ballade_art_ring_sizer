import 'package:flutter/services.dart';

class DpiHelper {
  static const _channel = MethodChannel('dpi_channel');

  /// Android'den xdpi/ydpi alır
  static Future<double> getPxPerMm() async {
    try {
      final result = await _channel.invokeMethod<Map<dynamic, dynamic>>('getDpi');
      if (result == null) return 0;

      final xdpi = (result["xdpi"] as num).toDouble();
      // 1 inch = 25.4 mm
      return xdpi / 25.4;
    } catch (e) {
      return 0;
    }
  }
}
