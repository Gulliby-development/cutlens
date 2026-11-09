import 'rows.dart';

final rows = [
  row(['check'], 'a 999999\nb 999999\n', 0, 'ok, 2 candidates, total 1999998\n', ''),
  row(['share'], 'a 999999\nb 0\n', 0, 'a 1000\nb 0\n', ''),
  row(['share', '--unit', 'ppm'], 'a 1\nb 999999\n', 0, 'a 1\nb 999999\n', ''),
  row(['topk', '--k', '1'], 'a 999999\nb 999999\n', 0, 'a 999999\n', ''),
  row(['minp', '--ratio', '1000'], 'a 5\nb 5\nc 4\n', 0, 'a 5\nb 5\n', ''),
  row(['share'], 'a 1\nb 0\nc 0\n', 0, 'a 1000\nb 0\nc 0\n', ''),
  row(['check'], 'a 0\n# b 1\nc 1\n', 0, 'ok, 2 candidates, total 1\n', ''),
  row(['draw', '--at', '999998'], 'a 999999\n', 0, 'a\n', ''),
  row(['chain', '--steps', 'topp:1'], 'a 0\nb 1\n', 0, 'b 1\n', ''),
];

void main() => runRows(rows);
