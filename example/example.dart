//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// Dart/Flutter (DF) Packages by DevCetra.com & contributors. See MIT LICENSE
// file in the root directory.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import 'package:df_type/df_type.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

void main() {
  // Lazy-convert any standard dart type (num, double, bool, String, Duration,
  // DateTime, etc.) to an int if sensible or return null:
  final int? i = letIntOrNull('55');
  print(i); // 55

  // Lazy-convert any map from one type to another if sensible, otherwise
  // return null.
  final Map<String, int>? m = letMapOrNull<String, int>({55: '56'});
  print(m); // {55, 56}

  // Lazy-convert comma separated strings, a value, or an iterable to a list if
  // sensible, otherwise return null.
  print(letListOrNull('1, 2, 3, 4')); // [1, 2, 3, 4]
  print(letListOrNull('[1, 2, 3, 4]')); // [1, 2, 3, 4]
  print(letListOrNull([1, 2, 3, 4])); // [1, 2, 3, 4]
  print(letListOrNull(1)); // [1]

  // Lazy-convert any value to a double if sensible, otherwise return null.
  print(letOrNull<double>('123')); // 123.0

  // Check if a type is nullable or not:
  print(isNullable<int>()); // false
  print(isNullable<int?>()); // true

  // Convert a String to a Duration.

  final Duration duration =
      const ConvertStringToDuration('11:11:00.00').toDuration();
  print(duration); // 11:11:00.000000
}
