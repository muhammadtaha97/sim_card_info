import '../models/signal_info.dart';

/// One dBm sample, timestamped so gaps (screen off, other tab) stay visible.
typedef SignalSample = ({DateTime at, int dbm});

/// Rolling in-session history of signal readings per subscription, feeding
/// the sparkline. In memory only: nothing is persisted, matching the app's
/// nothing-leaves-the-device stance — this is a live meter, not a logger.
class SignalHistory {
  SignalHistory({this.capacity = 120});

  /// Samples kept per subscription: 120 at the 3 s poll interval ≈ 6 minutes,
  /// enough to watch a walk around the house without unbounded growth.
  final int capacity;

  final Map<int, List<SignalSample>> _samples = {};

  void record(List<SignalInfo> signals, {DateTime? now}) {
    final at = now ?? DateTime.now();
    for (final signal in signals) {
      final dbm = signal.primaryCell?.dbm;
      if (dbm == null) continue;
      final list = _samples.putIfAbsent(signal.subscriptionId, () => []);
      list.add((at: at, dbm: dbm));
      if (list.length > capacity) list.removeRange(0, list.length - capacity);
    }
  }

  List<SignalSample> samplesFor(int subscriptionId) =>
      List.unmodifiable(_samples[subscriptionId] ?? const []);

  void clear() => _samples.clear();
}
