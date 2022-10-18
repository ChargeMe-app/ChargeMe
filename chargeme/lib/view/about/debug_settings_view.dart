import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/view_model/debug_settings_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DebugSettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Debug settings"), backgroundColor: ColorPallete.violetBlue),
        body: Consumer<DebugSettingsViewModel>(
            builder: (context, debugSettingsVM, child) => Column(
                    children: List.generate(debugSettingsVM.model.length, (i) {
                  final row = debugSettingsVM.model[i];
                  return ListTile(
                    title: Text(row.title),
                    trailing: row.type == DebugSettingsRowType.switch_
                        ? CupertinoSwitch(
                            value: debugSettingsVM.getValueForKey(row.settingsKey),
                            onChanged: (_) {
                              debugSettingsVM.toggleSwitchForKey(row.settingsKey);
                            })
                        : Container(),
                  );
                }))));
  }
}
