/// The check command.
library;

import 'registry.dart';
import 'report.dart';

Reply checkCommand(Options options, List<Item> items) {
  var total = 0;
  for (final item in items) {
    total += item.weight;
  }
  return Reply(0, 'ok, ${plural(items.length, 'candidate')}, total $total\n', '');
}
