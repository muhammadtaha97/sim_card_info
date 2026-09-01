import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

/// Crash reporting that is safe to install before Firebase exists.
///
/// The handlers go in before Firebase, so a crash during startup — the one
/// most worth catching — is still reported. Reports raised before Firebase is
/// up are held and flushed once it is, or dropped if it never comes up.
///
/// Crashlytics has no web implementation, hence the [kIsWeb] guard.
abstract final class CrashReporter {
  static final Completer<bool> _readyCompleter = Completer<bool>();
  static final List<_PendingError> _pending = [];

  /// Cap on held reports, so a crash loop before Firebase is ready cannot grow
  /// this without bound.
  static const _maxPending = 20;

  static Future<bool> get ready => _readyCompleter.future;

  /// Routes Flutter framework and raw platform errors here.
  ///
  /// Call from main() as early as possible — before Firebase, before runApp.
  static void install() {
    if (kIsWeb) return;

    final flutterOnError = FlutterError.onError;
    FlutterError.onError = (details) {
      flutterOnError?.call(details);
      _record(details.exception, details.stack, fatal: true, reason: null);
    };

    // Errors that escape the Dart isolate rather than the framework: async
    // gaps with no zone handler, platform channel failures. FlutterError.onError
    // never sees these, which is why both hooks are needed.
    PlatformDispatcher.instance.onError = (error, stack) {
      _record(error, stack, fatal: true, reason: null);
      return true;
    };
  }

  static void markReady({required bool available}) {
    if (_readyCompleter.isCompleted) return;
    _readyCompleter.complete(available);
    if (!available) {
      _pending.clear();
      return;
    }
    for (final error in _pending) {
      _send(error);
    }
    _pending.clear();
  }

  /// Reports a caught error that did not crash the app.
  ///
  /// [reason] is free text attached to the report. Never put document content,
  /// a key name or a file name in it — what failed and where in the code is
  /// enough to act on, and a pasted document routinely contains secrets.
  static void recordError(Object error, StackTrace? stack, {String? reason}) =>
      _record(error, stack, fatal: false, reason: reason);

  static void _record(
    Object error,
    StackTrace? stack, {
    required bool fatal,
    required String? reason,
  }) {
    if (kIsWeb) return;
    final pending = _PendingError(error, stack, fatal: fatal, reason: reason);
    if (!_readyCompleter.isCompleted) {
      if (_pending.length < _maxPending) _pending.add(pending);
      return;
    }
    _send(pending);
  }

  static void _send(_PendingError error) {
    // ready is already complete here, so this resolves synchronously enough to
    // avoid reordering reports.
    ready.then((available) {
      if (!available) return;
      try {
        FirebaseCrashlytics.instance.recordError(
          error.error,
          error.stack,
          reason: error.reason,
          fatal: error.fatal,
        );
      } catch (failure) {
        debugPrint('Crashlytics report failed: $failure');
      }
    });
  }
}

class _PendingError {
  final Object error;
  final StackTrace? stack;
  final bool fatal;
  final String? reason;

  const _PendingError(
    this.error,
    this.stack, {
    required this.fatal,
    required this.reason,
  });
}
