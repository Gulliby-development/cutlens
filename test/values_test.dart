import 'rows.dart';

final rows = [
  row(['share', '--unit', 'Permille'], '', 2, '', 'cutlens: bad value for --unit\n'),
  row(['share', '--unit', ''], '', 2, '', 'cutlens: bad value for --unit\n'),
  row(['share', '--format', 'table'], '', 2, '', 'cutlens: bad value for --format\n'),
  row(['topk', '--k', '0'], '', 2, '', 'cutlens: bad value for --k\n'),
  row(['topk', '--k', '33'], '', 2, '', 'cutlens: bad value for --k\n'),
  row(['topk', '--k', '05'], '', 2, '', 'cutlens: bad value for --k\n'),
  row(['topk', '--k', '-1'], '', 2, '', 'cutlens: bad value for --k\n'),
  row(['topk', '--k', '2.5'], '', 2, '', 'cutlens: bad value for --k\n'),
  row(['topp', '--p', '0'], '', 2, '', 'cutlens: bad value for --p\n'),
  row(['topp', '--p', '1001'], '', 2, '', 'cutlens: bad value for --p\n'),
  row(['topp', '--p', '01'], '', 2, '', 'cutlens: bad value for --p\n'),
  row(['minp', '--ratio', '1001'], '', 2, '', 'cutlens: bad value for --ratio\n'),
  row(['minp', '--ratio', '-5'], '', 2, '', 'cutlens: bad value for --ratio\n'),
  row(['draw', '--at', '1000000000'], '', 2, '', 'cutlens: bad value for --at\n'),
  row(['draw', '--at', '007'], '', 2, '', 'cutlens: bad value for --at\n'),
  row(['draw', '--at', ''], '', 2, '', 'cutlens: bad value for --at\n'),
  row(['chain', '--steps', 'topk'], '', 2, '', 'cutlens: bad value for --steps\n'),
  row(['chain', '--steps', 'topk:0'], '', 2, '', 'cutlens: bad value for --steps\n'),
  row(['chain', '--steps', 'topk:3,'], '', 2, '', 'cutlens: bad value for --steps\n'),
  row(['chain', '--steps', 'topk:1,topk:1,topk:1,topk:1,topk:1'], '', 2, '', 'cutlens: bad value for --steps\n'),
  row(['share', '--unit', 'percent'], 'a 1\nb 2\n', 0, 'a 33\nb 67\n', ''),
  row(['share', '--unit', 'ppm'], 'a 1\nb 2\n', 0, 'a 333333\nb 666667\n', ''),
  row(['topp', '--p', '1000'], 'the 500\ncat 300\ndog 150\nsat 40\nmat 10\n', 0, 'the 500\ncat 300\ndog 150\nsat 40\nmat 10\n', ''),
  row(['minp', '--ratio', '0'], 'the 500\ncat 300\ndog 150\nsat 40\nmat 10\n', 0, 'the 500\ncat 300\ndog 150\nsat 40\nmat 10\n', ''),
  row(['topk', '--k', '32'], 'a 1\nb 2\n', 0, 'b 2\na 1\n', ''),
  row(['chain', '--steps', 'topk:4,topp:900,minp:100,topk:1'], 'the 500\ncat 300\ndog 150\nsat 40\nmat 10\n', 0, 'the 500\n', ''),
];

void main() => runRows(rows);
