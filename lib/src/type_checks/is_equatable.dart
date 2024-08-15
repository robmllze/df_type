//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// Dart/Flutter (DF) Packages by DevCetra.com & contributors. Use of this
// source code is governed by an MIT-style license that can be found in the
// LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import 'package:equatable/equatable.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Checks if T is any of the following types, which are directly comparable
/// using the `==` operator and are passed by value:
///
/// - BigInt
/// - bool
/// - DateTime
/// - double
/// - Duration
/// - Enum
/// - int
/// - Null
/// - num
/// - Pattern
/// - RegExp
/// - Runes
/// - StackTrace
/// - String
/// - Symbol
/// - Type
/// - Uri
///
/// Additionally, if T implements Equatable, it is also considered comparable.
///
/// Returns `true` if T is one of these types or implements Equatable.
bool isEquatable<T>() {
  return <Type>{
    BigInt,
    bool,
    DateTime,
    double,
    Duration,
    Enum,
    int,
    Null,
    num,
    Pattern,
    RegExp,
    Runes,
    StackTrace,
    String,
    Symbol,
    Type,
    Uri,
    Equatable,
  }.contains(T);
}
