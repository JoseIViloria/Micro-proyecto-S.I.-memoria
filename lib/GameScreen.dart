import 'package:flutter/material.dart';
import 'dart:math';
import 'package:microproyecto_si/Card.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

List<Widget> generateBoard() {
  List<Widget> a = List.generate(36, (index) {
    int id = index % 18;
    return CardWidget(id, 'image/${(index % 16) + 1}.png');
  });
  a.shuffle(Random());
  return a;
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Game Screen')),
      body: GridView.count(
        crossAxisSpacing: 1,
        mainAxisSpacing: 2,
        crossAxisCount: 6,
        children: generateBoard(),
      ),
    );
  }
}
