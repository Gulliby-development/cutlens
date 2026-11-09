/// The ranking of candidates: heaviest first, input order kept among equal weights.
library;

import 'registry.dart';

/// Returns a new list sorted by weight descending; ties keep the input order.
List<Item> ranking(List<Item> items) {
  final order = List<int>.generate(items.length, (i) => i);
  order.sort((a, b) {
    final byWeight = items[b].weight.compareTo(items[a].weight);
    return byWeight != 0 ? byWeight : a.compareTo(b);
  });
  return [for (final i in order) items[i]];
}
