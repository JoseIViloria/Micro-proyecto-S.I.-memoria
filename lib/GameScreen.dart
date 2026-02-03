import 'package:flutter/material.dart';
import 'dart:math';
import 'package:microproyecto_si/cardWidget.dart';
import 'package:microproyecto_si/clock.dart';
import 'package:microproyecto_si/global.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

List<Widget> generateBoard(Function(BuildContext) onTap) {
  List<Widget> a = List.generate(36, (index) {
    int id = (index % 18) + 1;
    return CardWidget(id, 'image/$id.png', onTap);
  });
  a.shuffle(Random());
  return a;
}

GlobalKey<ClockState> clockKey = GlobalKey<ClockState>();
Clock clock = Clock(key: clockKey);

bool checkWin(List<Widget> board) {
  bool win = true;
  for (var card in board) {
    if (card is CardWidget) {
      if (!card.paired) {
        win = false;
        break;
      }
    }
  }
  if (win) {
    clockKey.currentState?.start();
    Global.playTime = clockKey.currentState!.time;
    Global.durationString = clockKey.currentState!.timeToString();
    Global.saveData();
  }
  return win;
}

class _GameScreenState extends State<GameScreen> {
  late List<Widget> board;

  @override
  void initState() {
    super.initState();
    board = generateBoard((BuildContext context) {
      if (checkWin(board)) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('¡Has ganado!'),
              content: Text('¡Felicidades, tu tiempo fue de: ${Global.durationString}!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: const Color.fromARGB(255, 191, 182, 255), 
      appBar: AppBar(
        title: const Text(
          '¡¡¡ENCUENTRA LOS PARES!!!',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orangeAccent, // Barra naranja
        iconTheme: const IconThemeData(color: Colors.white), // Flecha blanca en la barra
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Un margen para que no toque los bordes
        child: Row(
          children: [
            // Reloj a la izquierda
            Expanded(
              flex: 1, 
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'TIEMPO',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 20), // Caja decorativa para el reloj
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white54, width: 2),
                    ),
                    child: clock, // widget del reloj
                  ),
                ],
              ),
            ),

        

          Expanded(
            flex: 2,
            child: Center(
              child: AspectRatio(
                aspectRatio: 1.0, 
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(), 
                  crossAxisSpacing: 10, 
                  mainAxisSpacing: 10,
                  crossAxisCount: 6,
                  children: board,
              ),
            ),
          ),
          )

        ],
        ),
      ),
    );
  }
}
