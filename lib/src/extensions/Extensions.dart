extension StringExtensions on String? {
  String orEmpty() {
    if (this != null) {
      return this as String;
    } else {
      return "";
    }
  }
}