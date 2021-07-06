extension StringExtentions on String? {
  String orEmpty() {
    return this ?? "";
  }
}
