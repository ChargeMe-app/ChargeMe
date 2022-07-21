import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/view/map/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangeStationLocationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.editLocation),
        backgroundColor: ColorPallete.violetBlue,
      ),
      body: GMap(),
    );
  }
}
