/// The command line: help, version, the option rules, the reading of the list and the call of the command.
library;

import 'input.dart';
import 'registry.dart';

final RegExp _wholePattern = RegExp(r'^(0|[1-9][0-9]*)$');

/// The outcome of the command line: a reply (help, version, usage) or a command with its options.
class _Parsed {
  const _Parsed.reply(this.reply) : command = null, options = null;
  const _Parsed.command(this.command, this.options) : reply = null;

  final Reply? reply;
  final Command? command;
  final Options? options;
}

bool _inRange(String word, int min, int max) {
  if (!_wholePattern.hasMatch(word) || word.length > max.toString().length) {
    return false;
  }
  final value = int.parse(word);
  return value >= min && value <= max;
}

bool _validSteps(String value) {
  final parts = value.split(',');
  if (parts.length > 4) {
    return false;
  }
  for (final part in parts) {
    final colon = part.indexOf(':');
    if (colon < 0) {
      return false;
    }
    final number = part.substring(colon + 1);
    final valid = switch (part.substring(0, colon)) {
      'topk' => _inRange(number, 1, 32),
      'topp' => _inRange(number, 1, 1000),
      'minp' => _inRange(number, 0, 1000),
      _ => false,
    };
    if (!valid) {
      return false;
    }
  }
  return true;
}

bool _validValue(String option, String value) {
  switch (option) {
    case '--format':
      return formats.contains(value);
    case '--unit':
      return units.containsKey(value);
    case '--k':
      return _inRange(value, 1, 32);
    case '--p':
      return _inRange(value, 1, 1000);
    case '--ratio':
      return _inRange(value, 0, 1000);
    case '--at':
      return _inRange(value, 0, 999999999);
    default:
      return _validSteps(value);
  }
}

_Parsed _parse(List<String> args) {
  if (args.isEmpty) {
    return const _Parsed.reply(Reply(2, '', usageText));
  }
  final first = args[0];
  if (first == 'help' || first == '-h' || first == '--help') {
    return const _Parsed.reply(Reply(0, usageText, ''));
  }
  if (first == '--version') {
    return const _Parsed.reply(Reply(0, '$programVersion\n', ''));
  }
  final matches = commandTable.where((command) => command.name == first);
  if (matches.isEmpty) {
    fail(2, 'unknown command $first');
  }
  final command = matches.first;
  final given = <String, String>{};
  var i = 1;
  while (i < args.length) {
    final word = args[i];
    if (!word.startsWith('-') || word == '-') {
      fail(2, 'unexpected argument $word');
    }
    if (!optionNames.contains(word)) {
      fail(2, 'unknown option $word');
    }
    if (!command.options.contains(word)) {
      fail(2, 'option $word is not valid for ${command.name}');
    }
    if (given.containsKey(word)) {
      fail(2, 'given twice: $word');
    }
    if (i + 1 >= args.length) {
      fail(2, 'missing value for $word');
    }
    final value = args[i + 1];
    if (!_validValue(word, value)) {
      fail(2, 'bad value for $word');
    }
    given[word] = value;
    i += 2;
  }
  if (command.required.isNotEmpty && !given.containsKey(command.required)) {
    fail(2, 'missing ${command.required}');
  }
  int? number(String name) => given.containsKey(name) ? int.parse(given[name]!) : null;
  return _Parsed.command(
    command,
    Options(
      format: given['--format'] ?? 'plain',
      unit: given['--unit'] ?? 'permille',
      k: number('--k'),
      p: number('--p'),
      ratio: number('--ratio'),
      steps: given['--steps'],
      at: number('--at'),
    ),
  );
}

/// True exactly when the command line is a valid use of a command.
bool readsStdin(List<String> args) {
  try {
    return _parse(args).command != null;
  } on Failure {
    return false;
  }
}

/// Runs a command line on the input text.
Reply run(List<String> args, String stdin) {
  try {
    final parsed = _parse(args);
    final reply = parsed.reply;
    if (reply != null) {
      return reply;
    }
    final items = readCandidates(stdin);
    return parsed.command!.handler(parsed.options!, items);
  } on Failure catch (failure) {
    return Reply(failure.status, '', 'cutlens: ${failure.message}\n');
  }
}
