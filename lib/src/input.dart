/// The reading of the list of candidates.
library;

import 'registry.dart';

final RegExp _separators = RegExp(r'[ \t]+');
final RegExp _tokenPattern = RegExp(r'^[A-Za-z0-9_.-]{1,12}$');
final RegExp _weightPattern = RegExp(r'^(0|[1-9][0-9]{0,5})$');

/// Reads the candidates of the input text, failing with exit status 1 on the first problem.
List<Item> readCandidates(String text) {
  final lines = text.split('\n');
  if (text.isEmpty || text.endsWith('\n')) {
    lines.removeLast();
  }
  if (lines.length > maxLines) {
    fail(1, 'input is too long (max $maxLines lines)');
  }
  final items = <Item>[];
  final seen = <String>{};
  var total = 0;
  for (var i = 0; i < lines.length; i++) {
    var line = lines[i];
    if (line.endsWith('\r')) {
      line = line.substring(0, line.length - 1);
    }
    final words = line.split(_separators).where((word) => word.isNotEmpty).toList();
    if (words.isEmpty || words[0].startsWith('#')) {
      continue;
    }
    final number = i + 1;
    if (words.length != 2) {
      fail(1, 'line $number: expected TOKEN WEIGHT');
    }
    if (!_tokenPattern.hasMatch(words[0])) {
      fail(1, 'line $number: bad token ${words[0]}');
    }
    if (!_weightPattern.hasMatch(words[1])) {
      fail(1, 'line $number: bad weight ${words[1]}');
    }
    if (!seen.add(words[0])) {
      fail(1, 'line $number: duplicate token ${words[0]}');
    }
    final weight = int.parse(words[1]);
    total += weight;
    items.add(Item(words[0], weight));
  }
  if (items.isEmpty) {
    fail(1, 'no candidates');
  }
  if (total == 0) {
    fail(1, 'total weight is zero');
  }
  return items;
}
