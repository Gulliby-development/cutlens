import 'rows.dart';

final rows = [
  row(['check'], '', 1, '', ''),
  row(['share'], '', 1, '', ''),
  row(['share', '--unit', 'ppm'], '', 1, '', ''),
  row(['share', '--format', 'bar', '--unit', 'percent'], '', 1, '', ''),
  row(['topk', '--k', '3'], '', 1, '', ''),
  row(['topp', '--p', '900'], '', 1, '', ''),
  row(['minp', '--ratio', '0'], '', 1, '', ''),
  row(['chain', '--steps', 'topk:2,minp:100'], '', 1, '', ''),
  row(['draw', '--at', '7'], '', 1, '', ''),
  row(['share', '--format', 'csv'], '', 1, '', ''),
  row([], '', 0, '', ''),
  row(['help'], '', 0, '', ''),
  row(['-h'], '', 0, '', ''),
  row(['--help'], '', 0, '', ''),
  row(['--version'], '', 0, '', ''),
  row(['frob'], '', 0, '', ''),
  row(['check', '--format', 'plain'], '', 0, '', ''),
  row(['share', '--unit', 'x'], '', 0, '', ''),
  row(['topk'], '', 0, '', ''),
  row(['topk', '--k', '0'], '', 0, '', ''),
  row(['draw', '--at', 'x'], '', 0, '', ''),
  row(['chain', '--steps', 'topk:2,'], '', 0, '', ''),
  row(['Check'], '', 0, '', ''),
];

void main() => runReads(rows);
