import 'package:flutter/material.dart';
import 'package:microproyecto_si/gamescreen.dart';
import 'package:microproyecto_si/leaderboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const TitleScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TitleScreen extends StatelessWidget {
  const TitleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            SizedBox(
              width: 200,
              height: 100,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GameScreen()),
                  );
                },
                child: Text('Jugar', style: const TextStyle(fontSize: 50)),
              ),
            ),
            SizedBox(
              width: 150,
              height: 75,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Leaderboard()),
                  );
                },
                child: Text('Mejor puntuación', style: const TextStyle(fontSize: 15), textAlign: TextAlign.center,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
