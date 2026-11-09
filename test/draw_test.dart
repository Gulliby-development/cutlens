import 'rows.dart';

final rows = [
  row(['draw', '--at', '0'], 'the 500\ncat 300\ndog 150\nsat 40\nmat 10\n', 0, 'the\n', ''),
  row(['draw', '--at', '499'], 'the 500\ncat 300\ndog 150\nsat 40\nmat 10\n', 0, 'the\n', ''),
  row(['draw', '--at', '500'], 'the 500\ncat 300\ndog 150\nsat 40\nmat 10\n', 0, 'cat\n', ''),
  row(['draw', '--at', '799'], 'the 500\ncat 300\ndog 150\nsat 40\nmat 10\n', 0, 'cat\n', ''),
  row(['draw', '--at', '800'], 'the 500\ncat 300\ndog 150\nsat 40\nmat 10\n', 0, 'dog\n', ''),
  row(['draw', '--at', '949'], 'the 500\ncat 300\ndog 150\nsat 40\nmat 10\n', 0, 'dog\n', ''),
  row(['draw', '--at', '999'], 'the 500\ncat 300\ndog 150\nsat 40\nmat 10\n', 0, 'mat\n', ''),
  row(['draw', '--at', '1000'], 'the 500\ncat 300\ndog 150\nsat 40\nmat 10\n', 1, '', 'cutlens: draw position 1000 is outside the total 1000\n'),
  row(['draw', '--at', '1001'], 'the 500\ncat 300\ndog 150\nsat 40\nmat 10\n', 1, '', 'cutlens: draw position 1001 is outside the total 1000\n'),
  row(['draw', '--at', '0'], 'a 0\nb 1\n', 0, 'b\n', ''),
  row(['draw', '--at', '1'], 'a 0\nb 1\n', 1, '', 'cutlens: draw position 1 is outside the total 1\n'),
  row(['draw', '--at', '5'], 'a 3\nb 0\nc 3\n', 0, 'c\n', ''),
  row(['draw', '--at', '999999999'], 'a 1\n', 1, '', 'cutlens: draw position 999999999 is outside the total 1\n'),
];

void main() => runRows(rows);
