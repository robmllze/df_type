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

import '/src/_index.g.dart';

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
  final _callbacks = <MapperFunction<dynamic, T>>[];

  /// List of exceptions caught during callback execution or added manually via
  /// [addException].
  final _exceptions = <Object>[];

  /// Adds an exception to the list of tracked exceptions.
  void addException(Object e) => _exceptions.add(e);

  /// Returns a copy of the list of tracked exceptions.
  List<Object> get exceptions => List.unmodifiable(_exceptions);

  /// Adds a single callback to the controller.
  void add(MapperFunction<dynamic, T> callback) {
    _callbacks.add(callback);
  }

  /// Adds multiple callbacks to the controller.
  void addAll(_CallbackList<T> callbacks) {
    _callbacks.addAll(callbacks);
  }

  /// Evaluates all registered callbacks.
  FutureOr<void> complete() {
    return completeWithResults<void>((results) {});
  }

  /// Evaluates all registered callbacks and returns the first result.
  FutureOr<T> completeWithFirst() => completeWithResults<T>(
        (r) => r is Future<List<T>> ? r.then((e) => e.first) : r.first,
      );

  /// Evaluates all registered callbacks and returns the last result.
  FutureOr<T> completeWithLast() => completeWithResults<T>(
        (r) => r is Future<List<T>> ? r.then((e) => e.last) : r.last,
      );

  /// Evaluates all registered callbacks and returns all the results.
  FutureOr<List<T>> completeWithAll() => completeWithResults((r) => r);

  /// Evaluates all registered callbacks and returns the results, as
  /// determined by the [consolodator] function.
  ///
  /// If any exceptions occur during the execution of callbacks, they are added
  /// to the [exceptions] list.
  FutureOr<R> completeWithResults<R>(
    FutureOr<R> Function(FutureOr<List<T>> values) consolodator,
  ) {
    final values = <FutureOr<T>>[];
    final executionQueue = ExecutionQueue();

    // Evaluate all callbacks and collect exceptions.
    for (final callback in _callbacks) {
      try {
        final test = executionQueue.add(callback);
        values.add(test);
        if (test is Future<T>) {
          test.catchError((Object e) {
            addException(e);
            return Future<T>.error(e);
          });
        }
      } catch (e) {
        addException(e);
      }
    }
    final last = executionQueue.last();
    if (last is Future) {
      return last.then(
        (_) => consolodator(Future.wait(values.map((e) async => await e))),
      );
    } else {
      return consolodator(values.map((e) => e as T).toList());
    }
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Type definition for a list of callback functions.
typedef _CallbackList<T> = List<MapperFunction<dynamic, T>>;
