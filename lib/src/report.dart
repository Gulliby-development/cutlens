/// The writing of a table in a format, and the plural of a count.
library;

import 'bars.dart';

/// One line of a table: a token and a number.
class TableRow {
  const TableRow(this.token, this.number);

  final String token;
  final int number;
}

/// Writes the rows in the format; `full` is the number that stands for a full bar.
String renderRows(List<TableRow> rows, String format, int full) {
  final buffer = StringBuffer();
  for (final r in rows) {
    if (format == 'csv') {
      buffer.write('${r.token},${r.number}\n');
    } else if (format == 'bar') {
      buffer.write('${r.token} ${r.number} ${bar(r.number, full)}\n');
    } else {
      buffer.write('${r.token} ${r.number}\n');
    }
  }
  return buffer.toString();
}

/// `1 candidate`, `3 candidates`.
String plural(int count, String noun) => count == 1 ? '$count $noun' : '$count ${noun}s';
