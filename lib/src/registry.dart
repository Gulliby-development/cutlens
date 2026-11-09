/// The version, the limit, the usage text, the formats, the units, the options, the command table, the reply, the failure and the shared types.
library;

import 'cmd_chain.dart';
import 'cmd_check.dart';
import 'cmd_draw.dart';
import 'cmd_filters.dart';
import 'cmd_share.dart';

const String programVersion = 'cutlens 0.1.0';
const int maxLines = 32;

const String usageText =
    'usage: cutlens check\n'
    '       cutlens share [--unit UNIT] [--format FORMAT]\n'
    '       cutlens topk --k N [--format FORMAT]\n'
    '       cutlens topp --p PERMILLE [--format FORMAT]\n'
    '       cutlens minp --ratio PERMILLE [--format FORMAT]\n'
    '       cutlens chain --steps STEPS [--format FORMAT]\n'
    '       cutlens draw --at N\n';

const List<String> formats = ['plain', 'csv', 'bar'];
const Map<String, int> units = {'permille': 1000, 'percent': 100, 'ppm': 1000000};
const List<String> optionNames = ['--format', '--unit', '--k', '--p', '--ratio', '--steps', '--at'];

/// The reply of a command line: the exit status, the standard output text and the standard error text.
class Reply {
  const Reply(this.status, this.out, this.err);

  final int status;
  final String out;
  final String err;
}

/// A failure that ends the command: `run` turns it into `cutlens: MESSAGE` on standard error.
class Failure implements Exception {
  const Failure(this.status, this.message);

  final int status;
  final String message;
}

Never fail(int status, String message) => throw Failure(status, message);

/// One candidate of the list: its token and its weight.
class Item {
  const Item(this.token, this.weight);

  final String token;
  final int weight;
}

/// The options of a command line with the defaults filled in; `k`, `p`, `ratio`, `steps` and `at` are null when not given.
class Options {
  const Options({this.format = 'plain', this.unit = 'permille', this.k, this.p, this.ratio, this.steps, this.at});

  final String format;
  final String unit;
  final int? k;
  final int? p;
  final int? ratio;
  final String? steps;
  final int? at;
}

/// A command function: it returns the reply or fails through `fail`; `items` is the list that `readCandidates` returns, in input order.
typedef Handler = Reply Function(Options options, List<Item> items);

/// A command: its name, the options it accepts, the option that must be given (or '') and its handler.
class Command {
  const Command(this.name, this.options, this.required, this.handler);

  final String name;
  final List<String> options;
  final String required;
  final Handler handler;
}

/// The command table in the order of the usage text.
const List<Command> commandTable = [
  Command('check', <String>[], '', checkCommand),
  Command('share', <String>['--unit', '--format'], '', shareCommand),
  Command('topk', <String>['--k', '--format'], '--k', topkCommand),
  Command('topp', <String>['--p', '--format'], '--p', toppCommand),
  Command('minp', <String>['--ratio', '--format'], '--ratio', minpCommand),
  Command('chain', <String>['--steps', '--format'], '--steps', chainCommand),
  Command('draw', <String>['--at'], '--at', drawCommand),
];
