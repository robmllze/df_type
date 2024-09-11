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

import 'execution_queue.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension ThenOrOnFutureOrX<T> on FutureOr<T> {
  FutureOr<R> thenOr<R>(
    MapperFunction<T, R> callback, {
    void Function(Object e)? onError,
  }) {
    return _thenOr<T, R>(
      this,
      callback,
      onError,
    );
  }
}

FutureOr<R> _thenOr<T, R>(
  FutureOr<T> value,
  MapperFunction<T, R> callback,
  void Function(Object e)? onError,
) {
  if (value is Future<T>) {
    return value.then(
      callback,
      onError: onError,
    );
  } else {
    try {
      return callback(value);
    } catch (e) {
      onError?.call(e);
      rethrow;
    }
  }
}
