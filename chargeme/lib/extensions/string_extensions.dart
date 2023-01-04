extension CapExtension on String {
  String get capitalize {
    if (isEmpty) {
      return "";
    }
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String get allInCaps => toUpperCase();
  String get capitalizeEachWord => split(" ").map((str) => str.capitalize).join(" ");
}
