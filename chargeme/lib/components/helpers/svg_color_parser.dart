import 'package:chargeme/extensions/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class SvgColorParser {
  static Future<String> svgColored(String assetPath, Color color) async {
    String contents = await rootBundle.loadString(assetPath);
    final hex = color.toHex();
    contents = contents.replaceAll('fill="#8038D9"', 'fill="$hex"');
    return contents;
  }
}
