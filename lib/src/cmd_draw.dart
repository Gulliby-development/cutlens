/// The draw command.
library;

import 'registry.dart';

Reply drawCommand(Options options, List<Item> items) {
  final at = options.at!;
  var total = 0;
  for (final item in items) {
    total += item.weight;
  }
  if (at >= total) {
    fail(1, 'draw position $at is outside the total $total');
  }
  var sum = 0;
  for (final item in items) {
    sum += item.weight;
    if (sum > at) {
      return Reply(0, '${item.token}\n', '');
    }
  }
  return fail(1, 'draw position $at is outside the total $total');
}
