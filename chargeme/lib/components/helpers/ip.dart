import 'package:shared_preferences/shared_preferences.dart';

class IP {
  static String current = "158.160.15.192";
  static String port = "8081";

  static void changeToDebugIPIfNeeded() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("useDebugServer") ?? false) {
      current = "176.119.158.240";
    }
  }
}
