import 'dart:async';

import 'package:flutter/material.dart';

class Clock extends StatefulWidget {
  const Clock({super.key});


  @override
  State<Clock> createState() => ClockState();
}

class ClockState extends State<Clock> {
  final Stopwatch stopwatch = Stopwatch();
  late Duration time;
  late String timeString;
  late Timer? timer;

  @override
  void initState() {
    super.initState();
    timeString = timeToString();
    timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        updateTime();
      });
    });
    start();
  }

  String timeToString() {
    final int minutes = stopwatch.elapsed.inMinutes;
    final int seconds = stopwatch.elapsed.inSeconds % 60;
    final int milliseconds = (stopwatch.elapsed.inMilliseconds % 1000) ~/ 10;
    return timeString =
        '${minutes.toString()}:${seconds.toString()}:${milliseconds.toString()}';
  }

  void updateTime() {
    timeString = timeToString();
    time = stopwatch.elapsed;
  }

  void reset() {
    stopwatch.reset();
    updateTime();
  }

  void start() {
    if (!stopwatch.isRunning) {
    stopwatch.start();
    } else{
      stopwatch.stop();
      timer?.cancel();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(timeString, style: TextStyle(fontSize: 30));
  }
}
