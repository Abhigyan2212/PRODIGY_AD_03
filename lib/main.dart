import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const StopwatchApp());
}

class StopwatchApp extends StatelessWidget {
  const StopwatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StopWatch App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StopwatchHome(),
    );
  }
}

class StopwatchHome extends StatefulWidget {
  const StopwatchHome({super.key});

  @override
  _StopwatchHomeState createState() => _StopwatchHomeState();
}

class _StopwatchHomeState extends State<StopwatchHome> {
  late Stopwatch _stopwatch;
  late Timer _timer;
  final List<String> _lapTimes = [];

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
  }

  void _startStopwatch() {
    _stopwatch.start();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {});
    });
  }

  void _stopStopwatch() {
    _stopwatch.stop();
    _timer.cancel();
  }

  void _resetStopwatch() {
    _stopStopwatch();
    _stopwatch.reset();
    setState(() {
      _lapTimes.clear();
    });
  }

  void _recordLapTime() {
    final duration = _stopwatch.elapsed;
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    final milliseconds = (duration.inMilliseconds.remainder(1000) ~/ 10).toString().padLeft(2, '0');
    setState(() {
      _lapTimes.add('$minutes:$seconds:$milliseconds');
    });
  }

  @override
  Widget build(BuildContext context) {
    final duration = _stopwatch.elapsed;
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    final milliseconds = (duration.inMilliseconds.remainder(1000) ~/ 10).toString().padLeft(2, '0');

    return Scaffold(
      appBar: AppBar(
        title: const Text('StopWatch App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$minutes:$seconds:$milliseconds',
              style: const TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _stopwatch.isRunning ? null : _startStopwatch,
                  child: const Text('Start'),
                ),
                const SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: _stopwatch.isRunning ? _stopStopwatch : null,
                  child: const Text('Stop'),
                ),
                const SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: _resetStopwatch,
                  child: const Text('Reset'),
                ),
                const SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: _stopwatch.isRunning ? _recordLapTime : null,
                  child: const Text('Lap'),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: _lapTimes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Lap ${index + 1}'),
                    trailing: Text(_lapTimes[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
