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

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

typedef TSyncOrAsyncMapper<A, R> = FutureOr<R> Function(A a);

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Maps a synchronous or asynchronous list of values to a single value.
FutureOr<R> concurList<R>(
  List<FutureOr<dynamic>> items,
  FutureOr<R> Function(List<dynamic> resolvedItems) callback, {
  void Function(Object e)? onError,
}) {
  try {
    if (items.whereType<Future<dynamic>>().isNotEmpty) {
      return Future.wait(
        items.map((item) async => item),
      ).then((resolvedItems) {
        return callback(resolvedItems);
      });
    } else {
      return callback(items);
    }
  } catch (e) {
    onError?.call(e);
    rethrow;
  }
}

final mapSyncOrAsync = concur;

/// Maps a synchronous or asynchronous value to a single value.
FutureOr<R> concur<A, R>(
  FutureOr<A> a,
  FutureOr<R> Function(A a) callback, {
  void Function(Object e)? onError,
}) {
  try {
    if ([a].whereType<Future<dynamic>>().isNotEmpty) {
      return Future.wait(
        [a].map((e) async => e),
      ).then((values) {
        return callback(values[0]);
      });
    } else {
      return callback(
        a as A,
      );
    }
  } catch (e) {
    onError?.call(e);
    rethrow;
  }
}

/// Maps two synchronous or asynchronous values to a single value.
FutureOr<R> concur2<A, B, R>(
  FutureOr<A> a,
  FutureOr<B> b,
  FutureOr<R> Function(A a, B b) callback, {
  void Function(Object e)? onError,
}) {
  try {
    if ([a, b].whereType<Future<dynamic>>().isNotEmpty) {
      return Future.wait(
        [a, b].map((e) async => e),
      ).then((values) {
        return callback(values[0] as A, values[1] as B);
      });
    } else {
      return callback(
        a as A,
        b as B,
      );
    }
  } catch (e) {
    onError?.call(e);
    rethrow;
  }
}

/// Maps three synchronous or asynchronous values to a single value.
FutureOr<R> concur3<A, B, C, R>(
  FutureOr<A> a,
  FutureOr<B> b,
  FutureOr<C> c,
  FutureOr<R> Function(A a, B b, C c) callback, {
  void Function(Object e)? onError,
}) {
  try {
    if ([a, b, c].whereType<Future<dynamic>>().isNotEmpty) {
      return Future.wait(
        [a, b, c].map((e) async => e),
      ).then((values) {
        return callback(
          values[0] as A,
          values[1] as B,
          values[2] as C,
        );
      });
    } else {
      return callback(
        a as A,
        b as B,
        c as C,
      );
    }
  } catch (e) {
    onError?.call(e);
    rethrow;
  }
}

/// Maps four synchronous or asynchronous values to a single value.
FutureOr<R> concur4<A, B, C, D, R>(
  FutureOr<A> a,
  FutureOr<B> b,
  FutureOr<C> c,
  FutureOr<D> d,
  FutureOr<R> Function(A a, B b, C c, D d) callback, {
  void Function(Object e)? onError,
}) {
  try {
    if ([a, b, c, d].whereType<Future<dynamic>>().isNotEmpty) {
      return Future.wait(
        [a, b, c, d].map((e) async => e),
      ).then((values) {
        return callback(
          values[0] as A,
          values[1] as B,
          values[2] as C,
          values[3] as D,
        );
      });
    } else {
      return callback(a as A, b as B, c as C, d as D);
    }
  } catch (e) {
    onError?.call(e);
    rethrow;
  }
}

/// Maps five synchronous or asynchronous values to a single value.
FutureOr<R> concur5<A, B, C, D, E, R>(
  FutureOr<A> a,
  FutureOr<B> b,
  FutureOr<C> c,
  FutureOr<D> d,
  FutureOr<E> e,
  FutureOr<R> Function(A a, B b, C c, D d, E e) callback, {
  void Function(Object e)? onError,
}) {
  try {
    if ([a, b, c, d, e].whereType<Future<dynamic>>().isNotEmpty) {
      return Future.wait(
        [a, b, c, d, e].map((e) async => e),
      ).then((values) {
        return callback(
          values[0] as A,
          values[1] as B,
          values[2] as C,
          values[3] as D,
          values[4] as E,
        );
      });
    } else {
      return callback(a as A, b as B, c as C, d as D, e as E);
    }
  } catch (e) {
    onError?.call(e);
    rethrow;
  }
}

/// Maps six synchronous or asynchronous values to a single value.
FutureOr<R> concur6<A, B, C, D, E, F, R>(
  FutureOr<A> a,
  FutureOr<B> b,
  FutureOr<C> c,
  FutureOr<D> d,
  FutureOr<E> e,
  FutureOr<F> f,
  FutureOr<R> Function(A a, B b, C c, D d, E e, F f) callback, {
  void Function(Object e)? onError,
}) {
  try {
    if ([a, b, c, d, e, f].whereType<Future<dynamic>>().isNotEmpty) {
      return Future.wait(
        [a, b, c, d, e, f].map((e) async => e),
      ).then((values) {
        return callback(
          values[0] as A,
          values[1] as B,
          values[2] as C,
          values[3] as D,
          values[4] as E,
          values[5] as F,
        );
      });
    } else {
      return callback(a as A, b as B, c as C, d as D, e as E, f as F);
    }
  } catch (e) {
    onError?.call(e);
    rethrow;
  }
}

/// Maps seven synchronous or asynchronous values to a single value.
FutureOr<R> concur7<A, B, C, D, E, F, G, R>(
  FutureOr<A> a,
  FutureOr<B> b,
  FutureOr<C> c,
  FutureOr<D> d,
  FutureOr<E> e,
  FutureOr<F> f,
  FutureOr<G> g,
  FutureOr<R> Function(A a, B b, C c, D d, E e, F f, G g) callback, {
  void Function(Object e)? onError,
}) {
  try {
    if ([a, b, c, d, e, f, g].whereType<Future<dynamic>>().isNotEmpty) {
      return Future.wait(
        [a, b, c, d, e, f, g].map((e) async => e),
      ).then((values) {
        return callback(
          values[0] as A,
          values[1] as B,
          values[2] as C,
          values[3] as D,
          values[4] as E,
          values[5] as F,
          values[6] as G,
        );
      });
    } else {
      return callback(a as A, b as B, c as C, d as D, e as E, f as F, g as G);
    }
  } catch (e) {
    onError?.call(e);
    rethrow;
  }
}

/// Maps eight synchronous or asynchronous values to a single value.
FutureOr<R> concur8<A, B, C, D, E, F, G, H, R>(
  FutureOr<A> a,
  FutureOr<B> b,
  FutureOr<C> c,
  FutureOr<D> d,
  FutureOr<E> e,
  FutureOr<F> f,
  FutureOr<G> g,
  FutureOr<H> h,
  FutureOr<R> Function(A a, B b, C c, D d, E e, F f, G g, H h) callback, {
  void Function(Object e)? onError,
}) {
  try {
    if ([a, b, c, d, e, f, g, h].whereType<Future<dynamic>>().isNotEmpty) {
      return Future.wait(
        [a, b, c, d, e, f, g, h].map((e) async => e),
      ).then((values) {
        return callback(
          values[0] as A,
          values[1] as B,
          values[2] as C,
          values[3] as D,
          values[4] as E,
          values[5] as F,
          values[6] as G,
          values[7] as H,
        );
      });
    } else {
      return callback(
        a as A,
        b as B,
        c as C,
        d as D,
        e as E,
        f as F,
        g as G,
        h as H,
      );
    }
  } catch (e) {
    onError?.call(e);
    rethrow;
  }
}

/// Maps nine synchronous or asynchronous values to a single value.
FutureOr<R> concur9<A, B, C, D, E, F, G, H, I, R>(
  FutureOr<A> a,
  FutureOr<B> b,
  FutureOr<C> c,
  FutureOr<D> d,
  FutureOr<E> e,
  FutureOr<F> f,
  FutureOr<G> g,
  FutureOr<H> h,
  FutureOr<I> i,
  FutureOr<R> Function(A a, B b, C c, D d, E e, F f, G g, H h, I i) callback, {
  void Function(Object e)? onError,
}) {
  try {
    if ([a, b, c, d, e, f, g, h, i].whereType<Future<dynamic>>().isNotEmpty) {
      return Future.wait(
        [a, b, c, d, e, f, g, h, i].map((e) async => e),
      ).then((values) {
        return callback(
          values[0] as A,
          values[1] as B,
          values[2] as C,
          values[3] as D,
          values[4] as E,
          values[5] as F,
          values[6] as G,
          values[7] as H,
          values[8] as I,
        );
      });
    } else {
      return callback(
        a as A,
        b as B,
        c as C,
        d as D,
        e as E,
        f as F,
        g as G,
        h as H,
        i as I,
      );
    }
  } catch (e) {
    onError?.call(e);
    rethrow;
  }
}
