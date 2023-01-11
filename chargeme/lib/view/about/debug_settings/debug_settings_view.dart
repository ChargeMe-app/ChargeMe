import 'package:chargeme/components/analytics_manager/analytics_manager.dart';
import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/gen/assets.dart';
import 'package:chargeme/view/about/debug_settings/analytics_logs_view.dart';
import 'package:chargeme/view/about/debug_settings/change_debug_server_ip.dart';
import 'package:chargeme/view/helper_views/designed_switch.dart';
import 'package:chargeme/view_model/debug_settings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DebugSettingsView extends StatelessWidget {
  final AnalyticsManager analyticsManager;

  const DebugSettingsView({required this.analyticsManager});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Debug settings"), backgroundColor: ColorPallete.violetBlue),
        body: Consumer<DebugSettingsViewModel>(
            builder: (context, debugSettingsVM, child) => Column(
                    children: List.generate(debugSettingsVM.model.length, (i) {
                  final row = debugSettingsVM.model[i];
                  switch (row.type) {
                    case DebugSettingsRowType.switch_:
                      return ListTile(
                          title: Text(row.title),
                          trailing: DesignedSwitch(
                              value: debugSettingsVM.getBoolValueForKey(row.settingsKey),
                              onChanged: (_) {
                                debugSettingsVM.toggleSwitchForKey(row.settingsKey);
                              }));
                    case DebugSettingsRowType.chevron:
                      return ListTile(
                        title: Text(row.title),
                        trailing: row.trailingText == ""
                            ? SvgPicture.asset(Asset.chevronRight.path)
                            : Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
                                Text(row.trailingText, style: const TextStyle(color: Colors.grey, fontSize: 16)),
                                const SizedBox(width: 8),
                                SvgPicture.asset(Asset.chevronRight.path)
                              ]),
                        onTap: () {
                          if (row.settingsKey == "debugServerIP") {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ChangeDebugServerIPView()));
                          }
                          if (row.settingsKey == "analytics") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AnalyticsLogsView(analyticsManager: analyticsManager)));
                          }
                        },
                      );
                    case DebugSettingsRowType.none:
                      return Container();
                  }
                }))));
  }
}
