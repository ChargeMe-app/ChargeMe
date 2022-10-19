import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum DebugSettingsRowType {
  switch_,
  none;
}

class DebugSettingsRow {
  final String title;
  final String settingsKey;
  final DebugSettingsRowType type;
  final Function? onTap;

  DebugSettingsRow({required this.title, required this.settingsKey, required this.type, this.onTap});
}

class DebugSettingsViewModel extends ChangeNotifier {
  final List<DebugSettingsRow> model = [
    DebugSettingsRow(title: "Debug сервер", settingsKey: "useDebugServer", type: DebugSettingsRowType.switch_)
  ];

  late SharedPreferences? _prefs;

  DebugSettingsViewModel() {
    initialSetup();
  }

  void initialSetup() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool getValueForKey(String key) {
    return _prefs?.getBool(key) ?? false;
  }

  void toggleSwitchForKey(String key) {
    final currentValue = getValueForKey(key);
    _prefs?.setBool(key, !currentValue);
    notifyListeners();
  }
}
