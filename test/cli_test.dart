import 'rows.dart';

final rows = [
  row(['check'], 'the 500\ncat 300\ndog 150\nsat 40\nmat 10\n', 0, 'ok, 5 candidates, total 1000\n', ''),
  row(['share'], 'a 1\nb 3\n', 0, 'a 250\nb 750\n', ''),
  row(['share', '--unit', 'percent', '--format', 'csv'], 'a 1\nb 1\n', 0, 'a,50\nb,50\n', ''),
  row(['topk', '--k', '2'], 'the 500\ncat 300\ndog 150\nsat 40\nmat 10\n', 0, 'the 500\ncat 300\n', ''),
  row(['minp', '--ratio', '100'], 'the 500\ncat 300\ndog 150\nsat 40\nmat 10\n', 0, 'the 500\ncat 300\ndog 150\n', ''),
  row(['share', '--format', 'bar'], 'a 1\nb 3\n', 0, 'a 250 #####\nb 750 ###############\n', ''),
  row(['chain', '--steps', 'topk:3,minp:200'], 'the 500\ncat 300\ndog 150\nsat 40\nmat 10\n', 0, 'the 500\ncat 300\ndog 150\n', ''),
  row(['draw', '--at', '520'], 'the 500\ncat 300\ndog 150\nsat 40\nmat 10\n', 0, 'cat\n', ''),
];

void main() => runRows(rows);
