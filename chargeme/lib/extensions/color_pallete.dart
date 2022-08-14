import 'package:flutter/material.dart';

extension ColorPallete on Color {
  static Color violetBlue = ColorPallete.fromHex("#8038d9");
  static Color electricBlue = ColorPallete.fromHex("#53F4FF");
  static Color redCinnabar = ColorPallete.fromHex("#EF3E36");
  static Color darkerBlue = ColorPallete.fromHex("#0F7173");
  static Color darkDefaultBg = ColorPallete.fromHex("#20242f");
  static Color greenEmerald = ColorPallete.fromHex("#45CB85");
  static Color yellow = ColorPallete.fromHex("#F3CA40");

  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
