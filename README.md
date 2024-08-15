# DF Type

Dart & Flutter Packages by DevCetra.com & contributors.

[![pub package](https://img.shields.io/pub/v/df_type.svg)](https://pub.dev/packages/df_type)
[![MIT License](https://img.shields.io/badge/License-MIT-blue.svg)](https://raw.githubusercontent.com/robmllze/df_type/main/LICENSE)
[![Buy Me a Coffee](https://img.shields.io/badge/-buy_me_a%C2%A0coffee-gray?logo=buy-me-a-coffee)](https://www.buymeacoffee.com/robmllze)

## Summary

A package designed to simplify and enhance interactions with Dart types. For a full feature set, please refer to the [API reference](https://pub.dev/documentation/df_type/).

## Usage Example

```dart
enum Alphabet { A, B, C }

// Convert a String to an enum.
print(Alphabet.values.valueOf('A') == Alphabet.A); // true
print(Alphabet.values.valueOf('a') == Alphabet.A); // true
print(Alphabet.values.valueOf('b')); // Alphabet.B
print(Alphabet.values.valueOf('qwerty') == null); // true

// Check if a type is nullable or not.
print(isNullable<String>()); // false
print(isNullable<String?>()); // true
print(isNullable<Null>()); // true

// Check if a type can be compared by value.
print(isEquatable<double>()); // true
print(isEquatable<Null>()); // true
print(isEquatable<Map>()); // false
print(isEquatable<Equatable>()); // true

// Only let a value be of a certain type, or return null.
print(letAsOrNull<String>(DateTime.now())); // null
print(letAsOrNull<DateTime>(DateTime.now())); // returns the value
print(letAsOrNull<DateTime?>(DateTime.now())); // returns the value
print(letAsOrNull<DateTime?>(null)); // null

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

// Convert a String to a Duration.
final Duration duration = const ConvertStringToDuration('11:11:00.00').toDuration();
print(duration); // 11:11:00.000000
```

## Installation

Use this package as a dependency by adding it to your `pubspec.yaml` file (see [here](https://pub.dev/packages/df_type/install)).

---

## Contributing and Discussions

This is an open-source project, and we warmly welcome contributions from everyone, regardless of experience level. Whether you're a seasoned developer or just starting out, contributing to this project is a fantastic way to learn, share your knowledge, and make a meaningful impact on the community.

### Ways you can contribute:

- **Join the discussions and ask questions:** Your curiosity can lead to valuable insights and improvements.
- **Buy me a coffee:** If you'd like to support the project financially, consider [buying me a coffee](https://www.buymeacoffee.com/robmllze). Your support helps cover the costs of development and keeps the project growing.
- **Share your ideas:** Every perspective matters, and your ideas can spark innovation.
- **Report bugs:** Help us identify and fix issues to make the project more robust.
- **Suggest improvements or new features:** Your ideas can help shape the future of the project.
- **Help clarify documentation:** Good documentation is key to accessibility. You can make it easier for others to get started by improving or expanding our documentation.
- **Write articles:** Share your knowledge by writing tutorials, guides, or blog posts about your experiences with the project. It's a great way to contribute and help others learn.

No matter how you choose to contribute, your involvement is greatly appreciated and valued!

---

### Join Reddit Discussions:

💬 https://www.reddit.com/r/df_type/

### Join GitHub Discussions:

💬 https://github.com/robmllze/df_type/discussions/

### Chief Maintainer:

📧 Email _Robert Mollentze_ at robmllze@gmail.com

### Dontations:

If you're enjoying this package and find it valuable, consider showing your appreciation with a small donation. Every bit helps in supporting future development. You can donate here:

https://www.buymeacoffee.com/robmllze

---

## License

This project is released under the MIT License. See [LICENSE](https://raw.githubusercontent.com/robmllze/df_type/main/LICENSE) for more information.
