import 'package:flutter/material.dart';

class Leaderboard extends StatelessWidget {
  const Leaderboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Leaderboard Screen',
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}