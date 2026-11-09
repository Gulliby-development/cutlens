/// The share command.
library;

import 'registry.dart';
import 'report.dart';

Reply shareCommand(Options options, List<Item> items) {
  final scale = units[options.unit]!;
  var total = 0;
  for (final item in items) {
    total += item.weight;
  }
  final rows = <TableRow>[];
  for (final item in items) {
    rows.add(TableRow(item.token, (item.weight * scale + total ~/ 2) ~/ total));
  }
  return Reply(0, renderRows(rows, options.format, scale), '');
}
