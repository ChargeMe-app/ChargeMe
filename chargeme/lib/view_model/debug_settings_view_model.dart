import 'package:chargeme/components/helpers/ip.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum DebugSettingsRowType {
  switch_,
  chevron,
  none;
}

class DebugSettingsRow {
  final String title;
  final String trailingText;
  final String settingsKey;
  final DebugSettingsRowType type;
  final Function? onTap;

  DebugSettingsRow(
      {required this.title, required this.settingsKey, required this.type, this.trailingText = "", this.onTap});
}

class DebugSettingsViewModel extends ChangeNotifier {
  List<DebugSettingsRow> get model {
    return [
      DebugSettingsRow(
          title: "Debug сервер",
          trailingText: IP.current,
          settingsKey: "debugServerIP",
          type: DebugSettingsRowType.chevron),
      DebugSettingsRow(title: "Analytics logs", settingsKey: "analytics", type: DebugSettingsRowType.chevron),
      DebugSettingsRow(title: "Фильтры", settingsKey: "filters", type: DebugSettingsRowType.switch_)
    ];
  }

  SharedPreferences? _prefs;

  DebugSettingsViewModel() {
    initialSetup();
  }

  void initialSetup() async {
    _prefs = await SharedPreferences.getInstance();
    notifyListeners();
  }

  bool getBoolValueForKey(String key) {
    return _prefs?.getBool(key) ?? false;
  }

  void toggleSwitchForKey(String key) {
    final currentValue = getBoolValueForKey(key);
    _prefs?.setBool(key, !currentValue);
    notifyListeners();
  }

  String? getStringValueForKey(String key) {
    return _prefs?.getString(key);
  }

  void setStringValueForKey(String key, String value) {
    _prefs?.setString(key, value);
    notifyListeners();
  }

  void removeValueForKey(String key) {
    _prefs?.remove(key);
    notifyListeners();
  }
}
