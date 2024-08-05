//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// Dart/Flutter (DF) Packages by DevCetra.com & contributors. See LICENSE file
// in root directory.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import 'dart:convert' show JsonDecoder;

import '_index.g.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Alias for [letAsOrNull].
final letAs = letAsOrNull;

/// Alias for [letOrNull].
final let = letOrNull;

/// Alias for [letNumOrNull].
final letNum = letNumOrNull;

/// Alias for [letIntOrNull].
final letInt = letIntOrNull;

/// Alias for [letDoubleOrNull].
final letDouble = letDoubleOrNull;

/// Alias for [letBoolOrNull].
final letBool = letBoolOrNull;

/// Alias for [letUriOrNull].
final letUri = letUriOrNull;

/// Alias for [letDateTimeOrNull].
final letDateTime = letDateTimeOrNull;

/// Alias for [letDurationOrNull].
final letDuration = letDurationOrNull;

/// Alias for [letMapOrNull].
final letMap = letMapOrNull;

/// Alias for [letIterableOrNull].
final letIterable = letIterableOrNull;

/// Alias for [letListOrNull].
final letList = letListOrNull;

/// Alias for [letSetOrNull].
final letSet = letSetOrNull;

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Let's you cast [input] to a [T] type if possible, or returns null if the
/// cast cannot be performed.
T? letAsOrNull<T>(dynamic input) => input is T ? input : null;

/// Similar to [letAsOrNull], but uses a try-catch block internally.
T? castAsOrNull<T>(dynamic input) {
  try {
    return input as T;
  } catch (_) {
    return null;
  }
}

/// Let's you convert [input] to a [T] type if possible, or returns null if the
/// conversion cannot be performed.
///
/// Supported types:
///
/// - bool
/// - double
/// - int
/// - num
/// - String
/// - DateTime
/// - Duration
/// - Uri
T? letOrNull<T>(dynamic input) {
  try {
    if (T == dynamic) return input;
    if (input == null && T != Null) return null;
    if (T == input.runtimeType) return input as T;
    if (typeEquality<T, double>() || typeEquality<T, double?>()) {
      return letDoubleOrNull(input) as T;
    } else if (typeEquality<T, int>() || typeEquality<T, int?>()) {
      return letInt(input) as T;
    } else if (typeEquality<T, num>() || typeEquality<T, num?>()) {
      return letNumOrNull(input) as T;
    } else if (typeEquality<T, bool>() || typeEquality<T, bool?>()) {
      return letBoolOrNull(input) as T;
    } else if (typeEquality<T, DateTime>() || typeEquality<T, DateTime?>()) {
      return letDateTimeOrNull(input) as T;
    } else if (typeEquality<T, Duration>() || typeEquality<T, Duration?>()) {
      return letDurationOrNull(input) as T;
    } else if (typeEquality<T, Uri>() || typeEquality<T, Uri?>()) {
      return letUriOrNull(input) as T;
    } else if (typeEquality<T, String>() || typeEquality<T, String?>()) {
      return input?.toString() as T;
    }
    return input as T;
  } catch (_) {}
  return null;
}

/// Let's you convert [input] to a [num] type if possible, or returns null if the
/// conversion cannot be performed.
num? letNumOrNull(dynamic input) {
  if (input is num) return input;
  if (input is String) {
    final trimmed = input.trim();
    return num.tryParse(trimmed) ??
        ConvertStringToDuration(trimmed).toDurationOrNull()?.inMilliseconds;
  }
  if (input is Duration) return input.inMilliseconds;
  if (input is DateTime) return input.millisecondsSinceEpoch;
  if (input is bool) return input ? 1 : 0;
  try {
    // Assume input is a Timestamp (from Firestore package).
    return input.millisecondsSinceEpoch;
  } catch (_) {}
  return null;
}

/// Let's you convert [input] to an [int] type if possible, or returns null if
/// the conversion cannot be performed.
int? letIntOrNull(dynamic input) {
  return letNumOrNull(input)?.toInt();
}

/// Let's you convert [input] to a [double] type if possible, or returns null if
/// the conversion cannot be performed.
double? letDoubleOrNull(dynamic input) {
  return letNumOrNull(input)?.toDouble();
}

/// Let's you convert [input] to a [bool] type if possible, or returns null if
/// the conversion cannot be performed.
bool? letBoolOrNull(dynamic input) {
  if (input is bool) return input;
  if (input is num) return input == 1;
  if (input is String) return input.trim().toLowerCase() == 'true';
  return null;
}

/// Let's you convert [input] to a [Uri] type if possible, or returns null if
/// the conversion cannot be performed.
Uri? letUriOrNull(dynamic input) {
  if (input is Uri) return input;
  if (input is String) return Uri.tryParse(input.trim());
  return null;
}

/// Let's you convert [input] to a [DateTime] type if possible, or returns null
/// if the conversion cannot be performed.
DateTime? letDateTimeOrNull(dynamic input) {
  if (input is DateTime) {
    return input;
  }
  if (input is String) {
    return DateTime.tryParse(input);
  }
  if (input is Duration) {
    return DateTime.fromMillisecondsSinceEpoch(input.inMilliseconds);
  }
  if (input is int) {
    return DateTime.fromMillisecondsSinceEpoch(input);
  }
  if (input is num) {
    return DateTime.fromMillisecondsSinceEpoch(input.round());
  }
  return null;
}

/// Let's you convert [input] to a [Duration] type if possible, or returns null
/// if the conversion cannot be performed.
Duration? letDurationOrNull(dynamic input) {
  if (input is Duration) {
    return input;
  }
  if (input is int) {
    return Duration(milliseconds: input);
  }
  if (input is DateTime) {
    return Duration(milliseconds: input.millisecondsSinceEpoch);
  }
  if (input is String) {
    return ConvertStringToDuration(input).toDurationOrNull();
  }
  if (input is num) {
    return Duration(milliseconds: input.round());
  }
  try {
    // Assume input is a Timestamp (from Firestore package).
    return Duration(milliseconds: input.millisecondsSinceEpoch);
  } catch (_) {}
  return null;
}

/// Let's you convert [input] to a [Map] type if possible, or returns null if
/// the conversion cannot be performed.
///
/// If [filterNulls] is true, the returned map will not contain any null keys or
/// values. If [nullFallback] is provided, it will be used as a fallback value
/// for null keys and values.
Map<K, V>? letMapOrNull<K, V>(
  dynamic input, {
  bool filterNulls = false,
  dynamic nullFallback,
}) {
  dynamic decoded;
  try {
    if (input is String) {
      final trimmed = input.trim();
      if (trimmed.isEmpty) return const {};
      decoded = const JsonDecoder().convert(trimmed);
    } else {
      decoded = input;
    }
    if (decoded is Map) {
      final temp = decoded.entries
          .map((entry) {
            final convertedKey = letOrNull<K>(entry.key);
            final convertedValue = letOrNull<V>(entry.value) ?? letOrNull<V?>(nullFallback);
            if (filterNulls) {
              if (!isNullable<K>() && convertedKey == null) {
                return const _Empty();
              }
              if (!isNullable<V>() && convertedValue == null) {
                return const _Empty();
              }
            }
            return MapEntry(convertedKey as K, convertedValue as V);
          })
          .where((e) => e != const _Empty())
          .map((e) => e as MapEntry<K, V>);
      return Map.fromEntries(temp.nonNulls);
    }
  } catch (_) {}
  return null;
}

/// Let's you convert [input] to an [Iterable] type if possible, or returns null
/// if the conversion cannot be performed.
///
/// If [filterNulls] is true, the returned iterable will not contain any null
/// values. If [nullFallback] is provided, it will be used as a fallback value
/// for null values.
Iterable<T>? letIterableOrNull<T>(
  dynamic input, {
  bool filterNulls = false,
  dynamic nullFallback,
}) {
  final nullable = isNullable<T>();
  if (!nullable && input == null) return null;
  dynamic decoded;
  if (input is String) {
    decoded = letIterableFromCsv(input);
  } else {
    decoded = input;
  }
  if (decoded is Iterable) {
    try {
      final a = decoded.map((e) {
        final result = letOrNull<T>(e) ?? letOrNull<T>(nullFallback);
        if (filterNulls) {
          if (!nullable && result == null) {
            return const _Empty();
          }
        }
        return result;
      });
      final b = a.where((e) => e != const _Empty());
      var c = b.map((e) => e as T);
      if (filterNulls) {
        c = c.where((e) => e != null);
      }
      return c;
    } catch (_) {}
  }
  return [input];
}

/// Let's you convert [input] to a [List] type if possible, or returns null if
/// the conversion cannot be performed.
///
/// If [filterNulls] is true, the returned list will not contain any null
/// values. If [nullFallback] is provided, it will be used as a fallback value
/// for null values.
List<T>? letListOrNull<T>(
  dynamic input, {
  bool filterNulls = false,
  T? nullFallback,
}) {
  return letIterableOrNull<T>(
    input,
    filterNulls: filterNulls,
    nullFallback: nullFallback,
  )?.toList();
}

/// Let's you convert [input] to a [Set] type if possible, or returns null if
/// the conversion cannot be performed.
///
/// If [filterNulls] is true, the returned set will not contain any null
/// values. If [nullFallback] is provided, it will be used as a fallback value
/// for null values.
Set<T>? letSetOrNull<T>(
  dynamic input, {
  bool filterNulls = false,
  T? nullFallback,
}) {
  return letIterableOrNull<T>(
    input,
    filterNulls: filterNulls,
    nullFallback: nullFallback,
  )?.toSet();
}

/// Let's you convert [input] to an Iterable of Strings if possible, or returns
/// null if the conversion cannot be performed.
///
/// The input string can be comma-separated, or it can be a JSON array.
Iterable<String> letIterableFromCsv(String input) {
  var temp = input.trim();
  if (temp.isEmpty) return const [];
  if (temp.length > 1 &&
      ((temp.startsWith('[') && temp.endsWith(']')) ||
          (temp.startsWith('{') && temp.endsWith('}')) ||
          (temp.startsWith('(') && temp.endsWith(')')))) {
    temp = temp.substring(1, temp.length - 1);
  }
  return temp.split(',').map((final e) => e.trim());
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Used to filter out null values from a Map or Iterable.
class _Empty {
  const _Empty();
}
