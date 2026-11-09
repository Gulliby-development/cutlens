/// The hash marks of a value against a full bar.
library;

/// value * 20 / full rounded down, at least one mark for a value above 0 and at most 20; no mark for 0.
String bar(int value, int full) {
  if (value <= 0 || full <= 0) {
    return '';
  }
  final marks = value * 20 ~/ full;
  return '#' * (marks < 1 ? 1 : (marks > 20 ? 20 : marks));
}
