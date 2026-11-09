/// The chain command.
library;

import 'rank.dart';
import 'registry.dart';
import 'report.dart';

List<Item> _topk(List<Item> list, int n) => list.sublist(0, n < list.length ? n : list.length);

List<Item> _topp(List<Item> list, int p) {
  var total = 0;
  for (final item in list) {
    total += item.weight;
  }
  final kept = <Item>[];
  var sum = 0;
  for (final item in list) {
    kept.add(item);
    sum += item.weight;
    if (sum * 1000 >= p * total) {
      break;
    }
  }
  return kept;
}

List<Item> _minp(List<Item> list, int r) {
  final limit = r * list.first.weight;
  return <Item>[
    for (final item in list)
      if (item.weight * 1000 >= limit) item,
  ];
}

Reply chainCommand(Options options, List<Item> items) {
  var kept = ranking(items);
  for (final step in options.steps!.split(',')) {
    final parts = step.split(':');
    final value = int.parse(parts[1]);
    if (parts[0] == 'topk') {
      kept = _topk(kept, value);
    } else if (parts[0] == 'topp') {
      kept = _topp(kept, value);
    } else {
      kept = _minp(kept, value);
    }
  }
  final rows = <TableRow>[for (final item in kept) TableRow(item.token, item.weight)];
  return Reply(0, renderRows(rows, options.format, kept.first.weight), '');
}
