//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// Dart/Flutter (DF) Packages by DevCetra.com & contributors. See MIT LICENSE
// file in the root directory.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

/// A tool to convert a string to a [Duration].
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

  /// Tries to convert the [inputString] to a [Duration]. Accepts formats like
  /// `HH`, `HH:MM`, `HH:MM:SS`, and `HH:MM:SS.SSS`. Any components not specified
  /// are set to 0.
  ///
  /// Returns `null` if the conversion fails.
  Duration? toDurationOrNull() {
    if (this.inputString == null || this.inputString!.isEmpty) return null;
    final parts = this.inputString!.trim().split(':');
    var hours = 0;
    var minutes = 0;
    var seconds = 0;
    var milliseconds = 0;
    try {
      if (parts.length == 3) {
        // Format: HH:MM:SS[.SSS].
        hours = int.parse(parts[0]);
        minutes = int.parse(parts[1]);
        final secParts = parts[2].split('.');
        seconds = int.parse(secParts[0]);
        if (secParts.length > 1) {
          milliseconds = int.parse(secParts[1].padRight(3, '0').substring(0, 3));
        }
      } else if (parts.length == 2) {
        // Format: HH:MM.
        hours = int.parse(parts[0]);
        minutes = int.parse(parts[1]);
      } else if (parts.length == 1) {
        // Format: HH or SS[.SSS] if it's single number.
        final secParts = parts[0].split('.');
        if (secParts.length > 1 || parts[0].contains('.')) {
          seconds = int.parse(secParts[0]);
          if (secParts.length > 1) {
            milliseconds = int.parse(secParts[1].padRight(3, '0').substring(0, 3));
          }
        } else {
          hours = int.parse(parts[0]);
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
    return Duration(
      hours: hours,
      minutes: minutes,
      seconds: seconds,
      milliseconds: milliseconds,
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
      : super(
          'Failed to convert string to duration: invalid input string format.',
        );
}

/// Exception thrown by [ConvertStringToDuration] when a problem occurs.
class ConvertStringToDurationEx implements Exception {
  final String message;
  const ConvertStringToDurationEx(this.message);
  @override
  String toString() => message;
}
