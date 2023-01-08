import 'package:shared_preferences/shared_preferences.dart';

class IP {
  static String current = "chargemeapp.net";
  static String analytics = "158.160.11.212:5001";
  // static String port = "8081";

  static void changeToDebugIPIfNeeded() async {
    final prefs = await SharedPreferences.getInstance();
    final debugServerIP = prefs.getString("debugServerIP");
    if (debugServerIP != null) {
      current = debugServerIP;
    }
  }
}
