extension StringToSet on String {
  Set<String> toSet() {
    return split('').toSet();
  }
}
