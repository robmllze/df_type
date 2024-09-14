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

import 'dart:async' show FutureOr;

import 'map_future_or.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension FutureOrExtension<T extends Object> on FutureOr<T> {
  FutureOr<R> thenOr<R extends Object?>(
    MapperFunction<T, R> callback, {
    void Function(Object e)? onError,
  }) {
    return mapFutureOr<T, R>(
      this,
      callback,
      onError: onError,
    );
  }

  T get asResolved {
    try {
      return asResolvedOrNull!;
    } catch (e) {
      throw StateError('[asResolved] The value is not resolved.');
    }
  }

  T? get asResolvedOrNull => this is T ? this as T : null;

  Future<T> get asFuture {
    try {
      return asFutureOrNull!;
    } catch (e) {
      throw StateError('[asFuture] The value is not a Future.');
    }
  }

  Future<T>? get asFutureOrNull => this is Future<T> ? this as Future<T> : null;
}
