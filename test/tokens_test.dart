import 'rows.dart';

final rows = [
  row(['check'], 'a 1\n', 0, 'ok, 1 candidate, total 1\n', ''),
  row(['check'], 'abcdefghijkl 1\n', 0, 'ok, 1 candidate, total 1\n', ''),
  row(['check'], 'abcdefghijklm 1\n', 1, '', 'cutlens: line 1: bad token abcdefghijklm\n'),
  row(['check'], 'A.b_c-D9 1\n', 0, 'ok, 1 candidate, total 1\n', ''),
  row(['check'], 'a:b 1\n', 1, '', 'cutlens: line 1: bad token a:b\n'),
  row(['check'], 'a/b 1\n', 1, '', 'cutlens: line 1: bad token a/b\n'),
  row(['check'], 'caf? 1\n', 1, '', 'cutlens: line 1: bad token caf?\n'),
  row(['check'], 'a 0\n', 1, '', 'cutlens: total weight is zero\n'),
  row(['check'], 'a 999999\n', 0, 'ok, 1 candidate, total 999999\n', ''),
  row(['check'], 'a 1000000\n', 1, '', 'cutlens: line 1: bad weight 1000000\n'),
  row(['check'], 'a 01\n', 1, '', 'cutlens: line 1: bad weight 01\n'),
  row(['check'], 'a -1\n', 1, '', 'cutlens: line 1: bad weight -1\n'),
  row(['check'], 'a +1\n', 1, '', 'cutlens: line 1: bad weight +1\n'),
  row(['check'], 'a 1.5\n', 1, '', 'cutlens: line 1: bad weight 1.5\n'),
  row(['check'], 'a 1e3\n', 1, '', 'cutlens: line 1: bad weight 1e3\n'),
  row(['check'], 'a 1\na 2\n', 1, '', 'cutlens: line 2: duplicate token a\n'),
  row(['check'], 'a 1\nA 2\n', 0, 'ok, 2 candidates, total 3\n', ''),
  row(['check'], 'a 1\nb 2\na 3\n', 1, '', 'cutlens: line 3: duplicate token a\n'),
  row(['check'], 'a x\n', 1, '', 'cutlens: line 1: bad weight x\n'),
  row(['check'], 'a 0x10\n', 1, '', 'cutlens: line 1: bad weight 0x10\n'),
];

void main() => runRows(rows);
