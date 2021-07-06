extension BooleanExtentions on bool? {
  bool orFalse() {
    return this ?? false;
  }
}
