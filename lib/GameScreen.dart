import 'package:flutter/material.dart';
import 'dart:math';
import 'package:microproyecto_si/cardWidget.dart';
import 'package:microproyecto_si/clock.dart';
import 'package:microproyecto_si/global.dart';


/// Clase principal de la pantalla del juego.
/// Su trabajo es contener y mostrar los elementos visuales necesarios para jugar,
/// como el tablero de cartas y el temporizador.
class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}


/// Función encargada de preparar las cartas.
/// Crea las 36 cartas necesarias, asegura que cada una tenga su pareja idéntica
/// y las baraja al azar para que cada partida sea diferente.
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

/// Esta función revisa constantemente si todas las cartas del tablero ya tienen pareja;
/// si todas están emparejadas, detiene el reloj y guarda el récord.
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


/// Clase que contiene el diseño de la pantalla.
/// Controla cómo se ve todo (colores, diseño), actualiza lo que pasa en el juego
/// y muestra la mini ventana de victoria.
class _GameScreenState extends State<GameScreen> {
  late List<Widget> board;

  @override
  void initState() {
    super.initState();
    board = generateBoard((BuildContext context) {
      if (checkWin(board)) {
                showDialog(
          context: context,
          barrierDismissible: false, // Evita que se cierre si se toca fuera del recuadro
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // Bordes redondeados bonitos
              ),
              title: const Column(
                children: [
                  Text('🏆', style: TextStyle(fontSize: 60)), // Trofeo Gigante
                  SizedBox(height: 10),
                  Text(
                    '¡Felicidades!',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min, // Se ajusta al tamaño del contenido
                children: [
                  const Text(
                    'Tu tiempo ha sido:',
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    Global.durationString,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo, // 
                      fontFamily: 'Serif', // Fuente del texto
                    ),
                  ),
                ],
              ),
              actions: [
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent, // Color del botón
                      foregroundColor: Colors.white, // Color del texto
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context); // Cierra el diálogo (la alerta)
                      Navigator.pop(context); // Cierra el juego y vuelve al Home
                    },
                    child: const Text(
                      'Volver al menú',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
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
