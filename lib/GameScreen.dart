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
      appBar: AppBar(title: Text('Game Screen')),
      body: Column(
        spacing: 40,
        children: [
          Align(alignment: AlignmentGeometry.topCenter, child: clock),
          Center(
            child: GridView.count(
              shrinkWrap: true,
              crossAxisSpacing: 1,
              mainAxisSpacing: 2,
              crossAxisCount: 6,
              children: board,
            ),
          ),
        ],
      ),
    );
  }
}
