extension IntExtentions on int? {
  int orZero() {
    return this ?? 0;
  }

  bool isInRange({required int start, required int end}) {
    int? value = this;
    if (value == null) {
      return false;
    }
    return start <= value && value <= end;
  }
}
