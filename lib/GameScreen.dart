import 'package:flutter/material.dart';
import 'dart:math';
import 'package:microproyecto_si/cardWidget.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

List<Widget> generateBoard() {
  List<Widget> a = List.generate(36, (index) {
    int id = (index%18)+1;
    return CardWidget(id, 'image/$id.png', () => checkBoard(board));
  });
  a.shuffle(Random());
  return a;
}

List<Widget> board = generateBoard();

void checkBoard(List<Widget> board) {
  bool win = true;
  for (var x in board){
    if (x is CardWidget && x.emparejado == false){
      win = false;
      break;}
  }
  if (win){
    print('ok');
  }
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Game Screen')),
      body: Center(
        child: GridView.count(
          shrinkWrap: true,
          crossAxisSpacing: 1,
          mainAxisSpacing: 2,
          crossAxisCount: 6,
          children: board,
        ),
      ),
    );
  }
}
