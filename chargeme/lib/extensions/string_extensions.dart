extension CapExtension on String {
  String get capitalize {
    if (isEmpty) {
      return "";
    }
    return '${this[0].toUpperCase()}${this.substring(1)}';
  }

  String get allInCaps => this.toUpperCase();
  String get capitalizeEachWord => this.split(" ").map((str) => str.capitalize).join(" ");
}
