extension IntExtentions on int {
  int orZero() {
    return this ?? 0;
  }

  bool isInRange({int start, int end}) {
    return start <= this && this <= end;
  }
}
