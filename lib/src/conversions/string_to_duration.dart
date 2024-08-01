//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// Dart/Flutter (DF) Packages by DevCetra.com & contributors. See MIT LICENSE
// file in the root directory.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

class ConvertStringToDuration {
  //
  //
  //

  final String? inputString;

  //
  //
  //

  const ConvertStringToDuration(this.inputString);

  //
  //
  //

  /// Tries convert the [inputString] to a [Duration]. It assumes the
  /// [inputString] format is `HH:MM:SS.SSS`. Returns `null` if the conversion
  /// failed.
  Duration? toDurationOrNull() {
    if (this.inputString == null) return null;
    final a = this.inputString!.trim().split(':');
    if (a.length != 3) return null;
    final b = a[2].split('.');
    if (b.length != 2) return null;
    final c = [...a.sublist(0, 2), ...b];
    if (c.length != 4) return null;
    final hours = int.tryParse(c[0]);
    if (hours == null) return null;
    final minutes = int.tryParse(c[1]);
    if (minutes == null) return null;
    final seconds = int.tryParse(c[2]);
    if (seconds == null) return null;
    final microseconds = int.tryParse(c[3]);
    if (microseconds == null) return null;
    return Duration(
      hours: hours,
      minutes: minutes,
      seconds: seconds,
      microseconds: microseconds,
    );
  }

  /// Tries convert the [inputString] to a [Duration]. It assumes the
  /// [inputString] format is `HH:MM:SS.SSS`. Throws [ConvertStringToDurationEx]
  /// on error.
  Duration toDuration() {
    if (this.inputString == null) {
      throw const _StringIsNullEx();
    }
    try {
      final duration = this.toDurationOrNull()!;
      return duration;
    } catch (_) {
      throw const _InvalidInputStringFormatEx();
    }
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Exception thrown by [ConvertStringToDuration] when the input is null.
final class _StringIsNullEx extends ConvertStringToDurationEx {
  const _StringIsNullEx() : super('Failed to convert string to duration: string is null.');
}

/// Exception thrown by [ConvertStringToDuration] when the input string format is invalid.
final class _InvalidInputStringFormatEx extends ConvertStringToDurationEx {
  const _InvalidInputStringFormatEx()
      : super('Failed to convert string to duration: invalid input string format.');
}

/// Exception thrown by [ConvertStringToDuration] when a problem occurs.
class ConvertStringToDurationEx implements Exception {
  final String message;
  const ConvertStringToDurationEx(this.message);
  @override
  String toString() => message;
}
