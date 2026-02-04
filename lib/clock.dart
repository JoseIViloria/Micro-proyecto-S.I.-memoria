import 'dart:async';
import 'package:flutter/material.dart';

//Clase para poder mostrar y registrar el tiempo de una partida
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

//Generación de un nuevo estado del reloj.
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

//método que muestra el tiempo actual como un String
  String timeToString() {
    final int minutes = stopwatch.elapsed.inMinutes;
    final int seconds = stopwatch.elapsed.inSeconds % 60;
    final int milliseconds = (stopwatch.elapsed.inMilliseconds % 1000) ~/ 10;
    return timeString =
        '${minutes.toString()}:${seconds.toString()}:${milliseconds.toString()}';
  }

//método para actualizar el tiempo
  void updateTime() {
    timeString = timeToString();
    time = stopwatch.elapsed;
  }

//Resetea el reloj
  void reset() {
    stopwatch.reset();
    updateTime();
  }

//Inicia el reloj. Lo detiene si el temporizador ya comenzó
  void start() {
    if (!stopwatch.isRunning) {
    stopwatch.start();
    } else{
      stopwatch.stop();
      timer?.cancel();
    }
  }
  
//Borra el widget
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
