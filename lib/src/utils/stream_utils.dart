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

abstract final class StreamUtils {
  /// Waits for the first value from the [Stream] and returns it as a [Future].
  static Future<T> firstToFuture<T>(Stream<T> stream) {
    final completer = Completer<T>();
    StreamSubscription<T>? subscription;

    subscription = stream.listen(
      (data) {
        if (!completer.isCompleted) {
          completer.complete(data);
          subscription?.cancel();
        }
      },
      onError: (Object e) {
        if (!completer.isCompleted) {
          completer.completeError(e);
          subscription?.cancel();
        }
      },
      onDone: () {
        if (!completer.isCompleted) {
          completer.completeError(
            StateError(
              '[streamToFuture] Stream completed without emitting any values',
            ),
          );
        }
      },
      cancelOnError: true,
    );

    return completer.future;
  }

  /// Creates a [Stream] that polls a [callback] at a specified [interval].
  Stream<T> newPoller<T>(
    Future<T> Function() callback,
    Duration interval,
  ) {
    final controller = StreamController<T>();
    Future<void> $startPolling() async {
      try {
        while (!controller.isClosed) {
          try {
            final result = await callback();
            controller.add(result);
          } catch (e) {
            controller.addError(e);
          }
          await Future<void>.delayed(interval);
        }
      } catch (e) {
        if (!controller.isClosed) {
          controller.addError(e);
          controller.close();
        }
      }
    }

    $startPolling();
    return controller.stream;
  }
}
