import 'package:shared_preferences/shared_preferences.dart';

class IP {
  static String current = "chargemeapp.net";
  // static String port = "8081";

  static void changeToDebugIPIfNeeded() async {
    final prefs = await SharedPreferences.getInstance();
    final debugServerIP = prefs.getString("debugServerIP");
    if (debugServerIP != null) {
      current = debugServerIP;
    }
  }
}
