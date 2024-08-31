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

import 'dart:async';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// A controller for managing [FutureOr] operations and their exceptions.
class FutureOrController {
  //
  //
  //

  FutureOrController._();

  factory FutureOrController([List<FutureOr<void>> values = const []]) {
    final instance = FutureOrController._();
    instance.addAll(values);
    return instance;
  }

  /// Returns a copy of the list of futures added via [add] or [addAll].
  List<Future<void>> get futures => List.of(_futures);
  final _futures = <Future<void>>[];

  /// Returns a copy of the list of exceptions thrown by the futures or
  /// added manually via [addException].
  List<Object> get exceptions => List.of(_exceptions);
  final _exceptions = <Object>[];

  /// Adds [value] to [futures] if it is a [Future].
  void add(FutureOr<void> value) {
    if (value is Future<void>) {
      _futures.add(
        value.catchError((Object e) {
          _exceptions.add(e);
          return Future<void>.error(e);
        }),
      );
    }
  }

  /// Adds any element in [values] that is a [Future] to [futures].
  void addAll(Iterable<FutureOr<void>> values) {
    for (final value in values) {
      add(value);
    }
  }

  /// Adds [e] to [exceptions].
  void addException(Object e) => _exceptions.add(e);

  /// Awaits the completion of all [futures] and throws the first exception
  /// found in [exceptions], if any.
  ///
  /// If there are [futures], returns a [Future] that completes once all are
  /// finished.
  ///
  /// If no [futures] are present, it returns synchronously.
  ///
  /// The [onComplete] callback is invoked after all [_futures] have completed.
  FutureOr<T?> complete<T>([T Function()? onComplete]) {
    if (_futures.isNotEmpty) {
      return Future.wait(_futures).then((_) {
        if (_exceptions.isNotEmpty) {
          throw _exceptions.first;
        }
        return onComplete?.call();
      });
    } else if (_exceptions.isNotEmpty) {
      throw _exceptions.first;
    }
    return onComplete?.call();
  }
}
