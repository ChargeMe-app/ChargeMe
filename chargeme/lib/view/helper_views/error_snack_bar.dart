import 'package:chargeme/gen/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

void showErrorSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    backgroundColor: Colors.redAccent,
    content:
        Row(children: [SvgPicture.asset(Asset.xmarkRounded.path), const SizedBox(width: 8), Text("Error: $message")]),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
