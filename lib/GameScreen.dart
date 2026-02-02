import 'package:flutter/material.dart';
import 'dart:math';
import 'package:microproyecto_si/cardWidget.dart';
import 'package:microproyecto_si/clock.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

List<Widget> generateBoard() {
  List<Widget> a = List.generate(36, (index) {
    int id = (index % 18) + 1;
    return CardWidget(id, 'image/$id.png', (BuildContext context) {
      if (checkWin(board)) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('¡Has ganado!'),
              content: Text('¡Felicidades, has emparejado todas las cartas!'),
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
  });
  a.shuffle(Random());
  return a;
}

List<Widget> board = generateBoard();
Clock clock = Clock();

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
  return win;
}

class _GameScreenState extends State<GameScreen> {
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
