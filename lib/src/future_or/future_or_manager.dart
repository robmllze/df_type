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

/// A controller for managing [FutureOr] operations and capturing exceptions.
class FutureOrController<T> {
  FutureOrController._();

  /// Factory constructor to create a [FutureOrController] with optional callbacks.
  factory FutureOrController([_CallbackList<T> callbacks = const []]) {
    final instance = FutureOrController<T>._();
    instance.addAll(callbacks);
    return instance;
  }

  /// List of callbacks to be managed by the controller.
  final _callbacks = <_Callback<T>>[];

  /// List of exceptions caught during callback execution or added manually via
  /// [addException].
  final _exceptions = <Object>[];

  /// Adds an exception to the list of tracked exceptions.
  void addException(Object e) => _exceptions.add(e);

  /// Returns a copy of the list of tracked exceptions.
  List<Object> get exceptions => List.of(_exceptions);

  /// Adds a single callback to the controller.
  void add(_Callback<T> callback) {
    _callbacks.add(callback);
  }

  /// Adds multiple callbacks to the controller.
  void addAll(_CallbackList<T> callbacks) {
    _callbacks.addAll(callbacks);
  }

  /// Evaluates all registered callbacks and returns the results as a list.
  ///
  /// If any exceptions occur during the execution of callbacks, they are added
  /// to the [exceptions] list. The returned result will be a list of values
  /// from the callbacks, wrapped in either a [Future] or the actual value.
  /// Make sure to check the [exceptions] list after calling this method to
  /// determine if any errors occurred.
  FutureOr<List<T>> complete() {
    final values = <FutureOr<T>>[];

    // Evaluate all callbacks and collect exceptions.
    for (final callback in _callbacks) {
      try {
        final value = callback();
        if (value is Future<T>) {
          values.add(
            value.catchError((Object e) {
              addException(e);
              return Future<T>.error(e);
            }),
          );
        } else {
          values.add(value);
        }
      } catch (e) {
        addException(e);
      }
    }

    // Determine if any results are asynchronous.
    final hasFutures = values.any((e) => e is Future<T>);
    if (hasFutures) {
      final asFutures = values.map((e) => e is Future<T> ? e : Future<T>.value(e));
      return Future.wait(asFutures);
    } else {
      final asNonFutures = values.map((e) => e as T).toList();
      return asNonFutures;
    }
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Type definition for a callback function that returns a [FutureOr] result.
typedef _Callback<T> = FutureOr<T> Function();

/// Type definition for a list of callback functions.
typedef _CallbackList<T> = List<_Callback<T>>;
