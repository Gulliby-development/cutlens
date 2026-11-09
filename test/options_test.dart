import 'rows.dart';

final rows = [
  row(['share', 'extra'], '', 2, '', 'cutlens: unexpected argument extra\n'),
  row(['share', '-'], '', 2, '', 'cutlens: unexpected argument -\n'),
  row(['share', ''], '', 2, '', 'cutlens: unexpected argument \n'),
  row(['share', '--bogus'], '', 2, '', 'cutlens: unknown option --bogus\n'),
  row(['check', '--format', 'plain'], '', 2, '', 'cutlens: option --format is not valid for check\n'),
  row(['share', '--k', '3'], '', 2, '', 'cutlens: option --k is not valid for share\n'),
  row(['share', '--unit', 'ppm', '--unit', 'ppm'], '', 2, '', 'cutlens: given twice: --unit\n'),
  row(['share', '--unit'], '', 2, '', 'cutlens: missing value for --unit\n'),
  row(['share', '-x', '--unit'], '', 2, '', 'cutlens: unknown option -x\n'),
  row(['check', '--unit'], '', 2, '', 'cutlens: option --unit is not valid for check\n'),
  row(['share', '--unit', 'x', '--bogus'], '', 2, '', 'cutlens: bad value for --unit\n'),
  row(['topk'], '', 2, '', 'cutlens: missing --k\n'),
  row(['topp'], '', 2, '', 'cutlens: missing --p\n'),
  row(['minp'], '', 2, '', 'cutlens: missing --ratio\n'),
  row(['chain'], '', 2, '', 'cutlens: missing --steps\n'),
  row(['draw'], '', 2, '', 'cutlens: missing --at\n'),
  row(['draw', '--format', 'csv'], '', 2, '', 'cutlens: option --format is not valid for draw\n'),
  row(['topk', '--unit', 'ppm', '--k', '2'], '', 2, '', 'cutlens: option --unit is not valid for topk\n'),
  row(['share', '--format', 'csv', '--unit', 'ppm'], 'a 1\n', 0, 'a,1000000\n', ''),
  row(['share', '--unit', 'percent', '--format', 'plain'], 'a 1\nb 1\n', 0, 'a 50\nb 50\n', ''),
  row(['topk', '--format', 'csv', '--k', '1'], 'the 500\ncat 300\ndog 150\nsat 40\nmat 10\n', 0, 'the,500\n', ''),
  row(['minp', '--format', 'bar', '--ratio', '500'], 'the 500\ncat 300\ndog 150\nsat 40\nmat 10\n', 0, 'the 500 ####################\ncat 300 ############\n', ''),
  row(['draw', '--at', '0'], 'a 1\n', 0, 'a\n', ''),
  row(['chain', '--format', 'csv', '--steps', 'topk:1'], 'the 500\ncat 300\ndog 150\nsat 40\nmat 10\n', 0, 'the,500\n', ''),
];

void main() => runRows(rows);
