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

import '../df_type.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// A queue that executes functions in order, one at a time.
///
/// Each function is wrapped in a [_Queueable] object that contains a completer
/// and the function itself. When a new function is added to the queue via the
/// [add] method, it is wrapped in a new [_Queueable] object and added to the
/// end of the queue. If the first function in the queue is finished executing,
/// the [_execute] method runs the next function in the queue. The [_execute]
/// method continues to execute functions until it reaches a function that is
/// still running, or until the queue is empty.
///
/// Functions can be buffered by providing a `buffer` duration. When a function
/// is added to the queue with a buffer, the function is wrapped in a new
/// function that waits for the buffer to complete before executing the
/// original function. This is useful for batching up changes to a Firestore
/// document, for example.
class FunctionQueue {
  //
  //
  //

  final _queue = <_Queueable<dynamic>>[];

  //
  //
  //

  /// Adds a new function to the queue and returns a completer for the result.
  ///
  /// If the [buffer] parameter is provided, the function is wrapped in a new
  /// function that waits for the buffer duration before executing the
  /// original function.
  FutureOr<T> add<T>(
    FutureOr<T> Function() f, {
    Duration? buffer,
  }) {
    final q = _Queueable<T>(
      buffer == null
          ? f
          : () async => (await Future.wait<T>([
                Future.value(f()),
                Future.delayed(buffer),
              ]))
                  .first,
    );
    _queue.add(q);
    final temp = _execute();
    if (temp is Future) {
      return temp.then((_) => q._completer.futureOr);
    } else {
      return q._completer.futureOr;
    }
  }

  //
  //
  //

  bool get isEmpty => _queue.isEmpty;

  bool get isNotEmpty => _queue.isNotEmpty;

  //
  //
  //

  FutureOr<void> wait() {
    if (isNotEmpty) {
      return add(() {});
    }
  }

  //
  //
  //

  /// Executes the next function in the queue, if the queue is not empty and
  /// no other function is currently running.
  FutureOr<void> _execute() {
    for (final l in _queue
      ..removeWhere(
        (e) => e._status == _QueueableStatus.RAN,
      )) {
      final status = l._status;
      if (status == _QueueableStatus.RUNNING) break;
      if (status == _QueueableStatus.READY) {
        l._status = _QueueableStatus.RUNNING;
        final temp = l._function();
        if (temp is Future) {
          return temp.then((value) {
            l._completer.complete(value);
            l._status = _QueueableStatus.RAN;
            return _execute();
          });
        } else {
          l._completer.complete(temp);
          l._status = _QueueableStatus.RAN;
          return _execute();
        }
      }
    }
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

// This class represents a single function that has been added to the queue.
// It contains a completer that will be used to return the result of the
// function, as well as a status that indicates whether the function has
// been run yet.
class _Queueable<T> {
  final _completer = CompleterOr<T>();
  var _status = _QueueableStatus.READY;
  final FutureOr<T> Function() _function;
  _Queueable(this._function);
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

enum _QueueableStatus { READY, RUNNING, RAN }
