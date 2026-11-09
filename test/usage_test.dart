import 'rows.dart';

final rows = [
  row(['help'], '', 0, 'usage: cutlens check\n       cutlens share [--unit UNIT] [--format FORMAT]\n       cutlens topk --k N [--format FORMAT]\n       cutlens topp --p PERMILLE [--format FORMAT]\n       cutlens minp --ratio PERMILLE [--format FORMAT]\n       cutlens chain --steps STEPS [--format FORMAT]\n       cutlens draw --at N\n', ''),
  row(['-h'], '', 0, 'usage: cutlens check\n       cutlens share [--unit UNIT] [--format FORMAT]\n       cutlens topk --k N [--format FORMAT]\n       cutlens topp --p PERMILLE [--format FORMAT]\n       cutlens minp --ratio PERMILLE [--format FORMAT]\n       cutlens chain --steps STEPS [--format FORMAT]\n       cutlens draw --at N\n', ''),
  row(['--help', '--bogus'], '', 0, 'usage: cutlens check\n       cutlens share [--unit UNIT] [--format FORMAT]\n       cutlens topk --k N [--format FORMAT]\n       cutlens topp --p PERMILLE [--format FORMAT]\n       cutlens minp --ratio PERMILLE [--format FORMAT]\n       cutlens chain --steps STEPS [--format FORMAT]\n       cutlens draw --at N\n', ''),
  row([], '', 2, '', 'usage: cutlens check\n       cutlens share [--unit UNIT] [--format FORMAT]\n       cutlens topk --k N [--format FORMAT]\n       cutlens topp --p PERMILLE [--format FORMAT]\n       cutlens minp --ratio PERMILLE [--format FORMAT]\n       cutlens chain --steps STEPS [--format FORMAT]\n       cutlens draw --at N\n'),
  row(['--version'], '', 0, 'cutlens 0.1.0\n', ''),
  row(['--version', 'x'], '', 0, 'cutlens 0.1.0\n', ''),
  row(['frob'], '', 2, '', 'cutlens: unknown command frob\n'),
  row([''], '', 2, '', 'cutlens: unknown command \n'),
  row(['Check'], '', 2, '', 'cutlens: unknown command Check\n'),
  row(['-H'], '', 2, '', 'cutlens: unknown command -H\n'),
];

void main() => runRows(rows);
