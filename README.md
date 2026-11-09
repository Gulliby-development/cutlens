<p align="center"><img src="docs/logo.svg" width="96" alt="" /></p>

# cutlens

[![CI](https://github.com/Gulliby-development/cutlens/actions/workflows/ci.yml/badge.svg)](https://github.com/Gulliby-development/cutlens/actions/workflows/ci.yml) [![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

cutlens replays top-k, top-p and min-p sampling filters on a short list of weighted candidates. It reads the list from standard input, makes no model call, uses no random numbers and no clock, and does all its arithmetic on integers, so the same input always gives the same output.

It is for people who tune or debug samplers and want to see a cut on a list they can read, in a terminal, in a script or in CI.

It is written in Dart 3 (3.8 or newer) with core libraries only, and runs on Windows, macOS and Linux. From the repository directory run:

```text
dart run bin/cutlens.dart COMMAND
```

## Usage

```text
usage: cutlens check
       cutlens share [--unit UNIT] [--format FORMAT]
       cutlens topk --k N [--format FORMAT]
       cutlens topp --p PERMILLE [--format FORMAT]
       cutlens minp --ratio PERMILLE [--format FORMAT]
       cutlens chain --steps STEPS [--format FORMAT]
       cutlens draw --at N
```

- `check`: validates the list and prints the number of candidates and the total weight.
- `share`: shows each weight as a share of the total, in input order.
- `topk`: keeps the N heaviest candidates.
- `topp`: keeps the smallest group of heaviest candidates whose weights reach a share of the total.
- `minp`: keeps the candidates that weigh at least a ratio of the heaviest one.
- `chain`: applies up to four filter steps one after the other.
- `draw`: names the candidate that a position in the cumulative weights falls on.

Option values:

- `--format`: `plain`, `csv` or `bar`. The default is `plain`.
- `--unit`: `permille`, `percent` or `ppm`. The default is `permille`.
- `--k`: a whole number from 1 to 32.
- `--p`: a whole number from 1 to 1000.
- `--ratio`: a whole number from 0 to 1000.
- `--at`: a whole number from 0 to 999999999.
- `--steps`: one to four steps separated by commas, each `topk:N`, `topp:P` or `minp:R` with a value in the range of the option of the same name, for example `topk:3,minp:100`.

Numbers are written with no sign, no leading zero and no more digits than the largest value has. Every option takes the next word as its value; the `--option=value` form does not exist. `share` accepts `--unit` and `--format`, `topk`, `topp`, `minp` and `chain` accept their own option and `--format`, `draw` accepts `--at`, and `check` accepts no option. `topk`, `topp`, `minp`, `chain` and `draw` need their own option.

`help`, `-h` or `--help` as the first word prints the usage on standard output and exits 0, whatever follows. `--version` prints `cutlens 0.1.0` and exits 0. With no word the usage goes to standard error and the exit status is 2.

## List format

The list is read from standard input, one candidate per line: a token and an integer weight, separated by spaces or tabs.

- A token is 1 to 12 characters from `A-Z`, `a-z`, `0-9`, `_`, `.` and `-`. Upper and lower case are different tokens.
- A weight is `0` or 1 to 6 decimal digits without a leading zero and without a sign, so 0 to 999999.
- A token may appear only once.
- Spaces and tabs at the ends of a line are ignored. A CR before the line feed is dropped. A last line without a line feed counts as a line.
- A line that holds only spaces and tabs, or whose first word starts with `#`, is skipped. Skipped lines still count in line numbers.
- At most 32 lines are accepted, skipped lines included.
- The list needs at least one candidate and a total weight above zero.

## Formats

A table is a list of lines, each with a token and a number.

- `plain`: `TOKEN NUMBER`
- `csv`: `TOKEN,NUMBER`
- `bar`: `TOKEN NUMBER MARKS`, where MARKS is a run of `#` characters.

The marks are NUMBER * 20 / FULL rounded down, at least one mark for a number above 0 and at most 20. A number of 0 has no marks, so its line ends with a space. FULL is the scale of the unit for `share` (1000, 100 or 1000000) and the heaviest weight of the table for the other commands.

## Filters

The ranking orders candidates by weight, heaviest first. Candidates with the same weight keep their input order.

- `topk --k N` keeps the N heaviest candidates, or all of them when the list is shorter.
- `topp --p PERMILLE` walks down the ranking and keeps every candidate up to and including the first one at which the weight kept so far times 1000 is at least P times the total weight.
- `minp --ratio PERMILLE` keeps the candidates whose weight times 1000 is at least RATIO times the heaviest weight. The heaviest one always stays.
- `chain --steps STEPS` applies the steps in turn, each on the candidates the step before it kept (the first one on the whole list). A `topp` step uses the total weight of the candidates that are left, and a `minp` step uses the heaviest weight of the candidates that are left. Weights never change. The output is what is left, in ranking order.
- `draw --at N` works on the cumulative weights in input order, not in ranking order. It prints the token of the first candidate whose running total after its own weight is above N. A position equal to or above the total is an error.
- `share` prints for each candidate, in input order, `(WEIGHT * SCALE + TOTAL ~/ 2) ~/ TOTAL`, so a half rounds up and the shares need not add up to the scale.

## Examples

In the examples `cutlens` stands for a shell function that runs `dart run bin/cutlens.dart "$@"`. They use a POSIX shell in the repository directory, and `2>&1` shows the error line.

```text
$ printf 'the 500\ncat 300\ndog 150\nsat 40\nmat 10\n' | cutlens topp --p 900
the 500
cat 300
dog 150
$ printf 'the 500\ncat 300\ndog 150\n' | cutlens share --unit percent --format bar; printf 'a 1\nb 3\n' | cutlens share --format csv
the 53 ##########
cat 32 ######
dog 16 ###
a,250
b,750
$ printf 'the 500\ncat 300\ndog 150\nsat 40\nmat 10\n' | cutlens chain --steps topk:4,minp:100; printf 'the 500\ncat 300\ndog 150\n' | cutlens draw --at 520
the 500
cat 300
dog 150
cat
$ printf 'a 1\nb\n' | cutlens check 2>&1; printf 'a 1\n' | cutlens topk 2>&1
cutlens: line 2: expected TOKEN WEIGHT
cutlens: missing --k
```

## Errors

Every error is one line `cutlens: MESSAGE` on standard error, and nothing on standard output.

Exit statuses:

- 0: success, including `help`, `-h`, `--help` and `--version`.
- 1: an error in the list or in a command.
- 2: an error in the command line, or no argument at all.

The command line is checked first and nothing is read when it is wrong. Then the list is read, and every list error comes before any error or output of the command. The words are read left to right and the first problem is the error.

Command line (exit 2):

- `cutlens: unknown command WORD`
- `cutlens: unexpected argument WORD`
- `cutlens: unknown option WORD`
- `cutlens: option OPTION is not valid for COMMAND`
- `cutlens: given twice: OPTION`
- `cutlens: missing value for OPTION`
- `cutlens: bad value for OPTION`
- `cutlens: missing --k`, `cutlens: missing --p`, `cutlens: missing --ratio`, `cutlens: missing --steps` or `cutlens: missing --at`

List (exit 1):

- `cutlens: input is too long (max 32 lines)`
- `cutlens: line N: expected TOKEN WEIGHT`
- `cutlens: line N: bad token WORD`
- `cutlens: line N: bad weight WORD`
- `cutlens: line N: duplicate token WORD`
- `cutlens: no candidates`
- `cutlens: total weight is zero`

Command (exit 1):

- `cutlens: draw position N is outside the total T`

## Development

Run these from the repository directory; all three must pass without any finding:

```text
dart format --output=none --set-exit-if-changed .
dart analyze --fatal-infos
dart test
```

---

Built with [BAKED](https://github.com/Gulliby-development/baked), an open-source coding agent (bench round R104).
