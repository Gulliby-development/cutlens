import 'package:cutlens/cutlens.dart';
import 'package:test/test.dart';

/// One row of a row file: the words after the program name, the standard input text, the expected exit status, standard output text and standard error text.
class Row {
  const Row(this.args, this.stdin, this.status, this.out, this.err);

  final List<String> args;
  final String stdin;
  final int status;
  final String out;
  final String err;
}

/// row ARGS STDIN STATUS OUT ERR. In a reads file the STATUS stands for the answer of readsStdin: 1 for true and 0 for false.
Row row(List<String> args, String stdin, int status, String out, String err) => Row(args, stdin, status, out, err);

/// Runs the command line of every row with its standard input text and compares the exit status, the standard output and the standard error.
/// The label names the list of the file: 'rows' or 'totals'.
void runRows(List<Row> rows, [String label = 'rows']) {
  group(label, () {
    for (var i = 0; i < rows.length; i++) {
      final row = rows[i];
      test('row ${i + 1}', () {
        final reply = run(row.args, row.stdin);
        expect(reply.status, row.status);
        expect(reply.out, row.out);
        expect(reply.err, row.err);
      });
    }
  });
}

/// Compares readsStdin of the words of every row with the number in the place of the status (1 for true, 0 for false).
void runReads(List<Row> rows) {
  group('readsStdin', () {
    for (var i = 0; i < rows.length; i++) {
      final row = rows[i];
      test('row ${i + 1}', () {
        expect(readsStdin(row.args), row.status == 1);
      });
    }
  });
}
