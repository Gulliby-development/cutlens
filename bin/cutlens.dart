import 'dart:convert';
import 'dart:io';

import 'package:cutlens/cutlens.dart';

/// Standard input and output are bytes; every byte is one character (ISO 8859-1), as the rows of the tests read them.
Future<void> main(List<String> args) async {
  var input = '';
  if (readsStdin(args)) {
    final bytes = <int>[];
    await for (final chunk in stdin) {
      bytes.addAll(chunk);
    }
    input = latin1.decode(bytes);
  }
  final reply = run(args, input);
  stdout.add(latin1.encode(reply.out));
  stderr.add(latin1.encode(reply.err));
  await stdout.flush();
  await stderr.flush();
  exit(reply.status);
}
