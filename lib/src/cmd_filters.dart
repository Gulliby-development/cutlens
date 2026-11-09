/// The topk, topp and minp commands.
library;

import 'rank.dart';
import 'registry.dart';
import 'report.dart';

Reply _reply(Options options, List<Item> kept) {
  final rows = <TableRow>[for (final item in kept) TableRow(item.token, item.weight)];
  return Reply(0, renderRows(rows, options.format, kept.first.weight), '');
}

Reply topkCommand(Options options, List<Item> items) {
  final ranked = ranking(items);
  final k = options.k!;
  return _reply(options, ranked.sublist(0, k < ranked.length ? k : ranked.length));
}

Reply toppCommand(Options options, List<Item> items) {
  final ranked = ranking(items);
  var total = 0;
  for (final item in ranked) {
    total += item.weight;
  }
  final target = options.p! * total;
  final kept = <Item>[];
  var sum = 0;
  for (final item in ranked) {
    kept.add(item);
    sum += item.weight;
    if (sum * 1000 >= target) {
      break;
    }
  }
  return _reply(options, kept);
}

Reply minpCommand(Options options, List<Item> items) {
  final ranked = ranking(items);
  final limit = options.ratio! * ranked.first.weight;
  final kept = <Item>[
    for (final item in ranked)
      if (item.weight * 1000 >= limit) item,
  ];
  return _reply(options, kept);
}
