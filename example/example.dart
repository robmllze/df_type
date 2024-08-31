//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// Dart/Flutter (DF) Packages by DevCetra.com & contributors. The use of this
// source code is governed by an MIT-style license described in the LICENSE
// file located in this project's root directory.
//
// See: https://opensource.org/license/mit
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

// ignore_for_file: omit_local_variable_types

import 'package:equatable/equatable.dart';
import 'package:df_type/df_type.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

void main() async {
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
  print(isEquatable<Map<dynamic, dynamic>>()); // false
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
  print(letListOrNull<int>('1, 2, 3, 4')); // [1, 2, 3, 4]
  print(letListOrNull<int>('[1, 2, 3, 4]')); // [1, 2, 3, 4]
  print(letListOrNull<int>([1, 2, 3, 4])); // [1, 2, 3, 4]
  print(letListOrNull<int>(1)); // [1]

  // Lazy-convert any value to a double if sensible, otherwise return null.
  print('--- 8 ---');
  print(letOrNull<double>('123')); // 123.0

  // Convert a String to a Duration.
  final Duration duration =
      const ConvertStringToDuration('11:11:00.00').toDuration();
  print('--- 9 ---');
  print(duration); // 11:11:00.000000

  // Manage Futures or values via FutureOrController.
  print('--- 10 ---');
  final a1 = Future.value(1);
  final a2 = 2;
  final a3 = Future.value(3);
  final foc1 = FutureOrController<dynamic>([() => a1, () => a2, () => a3]);
  final f1 = foc1.complete();
  print(f1 is Future); // true
  final b1 = 1;
  final b2 = 2;
  final b3 = 2;
  final foc2 = FutureOrController<dynamic>([() => b1, () => b2, () => b3]);
  final f2 = foc2.complete();
  print(f2 is Future); // false

  // CompleterOr works with async or sync values.
  print('--- 11 ---');
  final completerOr1 = CompleterOr<int>();
  completerOr1.complete(1);
  final c1 = completerOr1.futureOr;
  print(c1 is Future); // false
  final completerOr2 = CompleterOr<int>();
  completerOr2.complete(Future.value(1));
  final c2 = completerOr2.futureOr;
  print(c2 is Future); // true

  // The FunctionQueue can ensure that async functions will execute in the same
  // order as they are added. This can be used for database writes, for example.
  print('--- 12 ---');
  final functionQueue = FunctionQueue();
  functionQueue.add(() async {
    print('Function 1 running');
    await Future<void>.delayed(const Duration(seconds: 3));
    print('Function 1 completed');
  });
  functionQueue.add(() async {
    print('Function 2 running');
    await Future<void>.delayed(const Duration(seconds: 2));
    print('Function 2 completed');
  });
  functionQueue.add(() async {
    print('Function 3 running');
    await Future<void>.delayed(const Duration(seconds: 1));
    print('Function 3 completed');
  });
  await functionQueue.wait();
  // Prints:
  // Function 1 running
  // Function 1 completed
  // Function 2 running
  // Function 2 completed
  // Function 3 running
  // Function 3 completed
}

enum Alphabet { A, B, C }
