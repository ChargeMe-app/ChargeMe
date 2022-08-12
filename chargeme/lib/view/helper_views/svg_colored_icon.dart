import 'package:chargeme/components/helpers/svg_color_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgColoredIcon extends StatefulWidget {
  const SvgColoredIcon({Key? key, required this.assetPath, required this.color, this.height}) : super(key: key);

  final String assetPath;
  final Color color;
  final double? height;

  @override
  _SvgColoredIcon createState() => _SvgColoredIcon();
}

class _SvgColoredIcon extends State<SvgColoredIcon> {
  var svgString = "";

  @override
  void initState() {
    super.initState();
    setupIcon();
  }

  void setupIcon() async {
    svgString = await SvgColorParser.svgColored(widget.assetPath, widget.color);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return svgString == "" ? Container() : SvgPicture.string(svgString, height: widget.height);
  }
}
