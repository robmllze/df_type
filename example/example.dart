//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// Dart/Flutter (DF) Packages by DevCetra.com & contributors. Use of this
// source code is governed by an MIT-style license that can be found in the
// LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

// ignore_for_file: omit_local_variable_types

import 'package:equatable/equatable.dart';
import 'package:df_type/df_type.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

void main() {
  // Convert a String to an enum.
  print('--- 1 ---');
  print(Alphabet.values.valueOf('A') == Alphabet.A); // true
  print(Alphabet.values.valueOf('a') == Alphabet.A); // true
  print(Alphabet.values.valueOf('b')); // Alphabet.B
  print(Alphabet.values.valueOf('qwerty') == null); // true

  // Check if a type is nullable or not.
  print('--- 2 ---');
  print(isNullable<String>()); // false
  print(isNullable<String?>()); // true
  print(isNullable<Null>()); // true

  // Check if a type can be compared by value.
  print('--- 3 ---');
  print(isEquatable<double>()); // true
  print(isEquatable<Null>()); // true
  print(isEquatable<Map>()); // false
  print(isEquatable<Equatable>()); // true

  // Only let a value be of a certain type, or return null.
  print('--- 4 ---');
  print(letAsOrNull<String>(DateTime.now())); // null
  print(letAsOrNull<DateTime>(DateTime.now())); // returns the value
  print(letAsOrNull<DateTime?>(DateTime.now())); // returns the value
  print(letAsOrNull<DateTime?>(null)); // null

  // Lazy-convert any standard dart type (num, double, bool, String, Duration,
  // DateTime, etc.) to an int if sensible or return null:
  print('--- 5 ---');
  final int? i = letIntOrNull('55');
  print(i); // 55

  // Lazy-convert any map from one type to another if sensible, otherwise
  // return null.
  final Map<String, int>? m = letMapOrNull<String, int>({55: '56'});
  print('--- 6 ---');
  print(m); // {55, 56}

  // Lazy-convert comma separated strings, a value, or an iterable to a list if
  // sensible, otherwise return null.
  print('--- 7 ---');
  print(letListOrNull('1, 2, 3, 4')); // [1, 2, 3, 4]
  print(letListOrNull('[1, 2, 3, 4]')); // [1, 2, 3, 4]
  print(letListOrNull([1, 2, 3, 4])); // [1, 2, 3, 4]
  print(letListOrNull(1)); // [1]

  // Lazy-convert any value to a double if sensible, otherwise return null.
  print('--- 8 ---');
  print(letOrNull<double>('123')); // 123.0

  // Convert a String to a Duration.
  final Duration duration =
      const ConvertStringToDuration('11:11:00.00').toDuration();
  print('--- 9 ---');
  print(duration); // 11:11:00.000000
}

enum Alphabet { A, B, C }
