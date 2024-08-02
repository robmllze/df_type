# DF Type

Dart & Flutter Packages by DevCetra.com & contributors.

[![pub package](https://img.shields.io/pub/v/df_type.svg)](https://pub.dev/packages/df_type)

## Summary

A package designed to simplify and enhance interactions with Dart types. For a full feature set, please refer to the [API reference](https://pub.dev/documentation/df_type/).

## Usage Example

```dart
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

  final Duration duration = const ConvertStringToDuration('11:11:00.00').toDuration();
  print(duration); // 11:11:00.000000
```

## Installation

Use this package as a dependency by adding it to your `pubspec.yaml` file (see [here](https://pub.dev/packages/df_type/install)).

## Contributing and Discussions

This is an open-source project, and contributions are welcome from everyone, regardless of experience level. Contributing to projects is a great way to learn, share knowledge, and showcase your skills to the community. Join the discussions to ask questions, report bugs, suggest features, share ideas, or find out how you can contribute.

### Join GitHub Discussions:

💬 https://github.com/robmllze/df_type/discussions/

### Join Reddit Discussions:

💬 https://www.reddit.com/r/df_type/

### Chief Maintainer:

📧 Email _Robert Mollentze_ at robmllze@gmail.com

## License

This project is released under the MIT License. See [LICENSE](https://raw.githubusercontent.com/robmllze/df_type/main/LICENSE) for more information.
