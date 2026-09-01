import 'dart:async';
import 'dart:io';

/// Result of one latency probe.
class LatencyResult {
  const LatencyResult({required this.host, this.milliseconds});

  final String host;

  /// Best round trip of the attempts, or null when the host was unreachable.
  final int? milliseconds;
}

/// TCP connect-time latency to a few well-known anycast endpoints.
///
/// A connect handshake, not ICMP: raw sockets need privileges an app does not
/// have, and a TCP SYN/ACK round trip is the same order of magnitude. Three
/// attempts per host, best one kept — the first connect on a cold radio pays
/// the RRC wake-up cost and would make the link look slower than it is.
class LatencyService {
  static const probes = [
    (name: 'Cloudflare DNS', host: '1.1.1.1', port: 53),
    (name: 'Google DNS', host: '8.8.8.8', port: 53),
    (name: 'google.com', host: 'google.com', port: 443),
  ];

  static const _attempts = 3;
  static const _timeout = Duration(seconds: 3);

  Future<List<LatencyResult>> run() => Future.wait(
        probes.map(
          (probe) => _probe(probe.name, probe.host, probe.port),
        ),
      );

  Future<LatencyResult> _probe(String name, String host, int port) async {
    int? best;
    for (var attempt = 0; attempt < _attempts; attempt++) {
      final stopwatch = Stopwatch()..start();
      try {
        final socket = await Socket.connect(host, port, timeout: _timeout);
        stopwatch.stop();
        socket.destroy();
        final ms = stopwatch.elapsedMilliseconds;
        if (best == null || ms < best) best = ms;
      } on Object {
        // Unreachable this attempt; the others may still land.
      }
    }
    return LatencyResult(host: name, milliseconds: best);
  }
}
