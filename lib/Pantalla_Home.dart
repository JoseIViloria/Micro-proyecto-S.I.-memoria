import 'package:flutter/material.dart';
import 'GameScreen.dart';    // Importamos la pantalla del juego
import 'Leaderboard.dart';   // Importamos la pantalla de récords

class PantallaInicio extends StatelessWidget {
  const PantallaInicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // --- FONDO DEGRADADO ---
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,    
            end: Alignment.bottomCenter,   
            colors: [
              Color.fromARGB(255, 251, 252, 255), 
              Color.fromARGB(255, 55, 58, 255), 
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centrar todo verticalmente
            children: [
              
              // --- LOGO SUPERIOR ---
              const Icon(
                Icons.extension, // Icono de rompecabezas
                size: 200,
                color: Colors.white,
              ),
              
              const SizedBox(height: 20), // Espacio vacío

              // --- TÍTULO DEL JUEGO ---
              const Text(
                'MEMORY-KIDS',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 5, // Separación entre letras
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black45, // Sombra negra suave
                      offset: Offset(3.0, 3.0),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 10),
              
              const Text(
                'Desafía tu mente, encuentra los pares y rompe tus récords',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
              
              const SizedBox(height: 60), // Espacio entre los botones

              // --- BOTÓN 1: JUGAR ---
              BotonMenu(
                texto: "JUGAR",
                icono: Icons.play_arrow_rounded,
                colorFondo: Colors.orangeAccent,
                colorTexto: Colors.white,
                alPresionar: () {
                  // Navegar a la pantalla del juego
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GameScreen()),
                  );
                },
              ),

              const SizedBox(height: 20), // Espacio entre botones

              // --- BOTÓN 2 RÉCORDS ---
              BotonMenu(
                texto: "RÉCORDS",
                icono: Icons.emoji_events_rounded,
                colorFondo: Colors.white,
                colorTexto: Colors.black87,
                alPresionar: () {
                  // Navegar a la pantalla de puntuaciones
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Leaderboard()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- WIDGET PERSONALIZADO PARA LOS BOTONES ---
class BotonMenu extends StatelessWidget {
  final String texto;
  final IconData icono;
  final VoidCallback alPresionar;
  final Color colorFondo;
  final Color colorTexto;

  const BotonMenu({
    super.key,
    required this.texto,
    required this.icono,
    required this.alPresionar,
    this.colorFondo = Colors.white,
    this.colorTexto = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorFondo,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: alPresionar,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icono, size: 30, color: colorTexto),
            const SizedBox(width: 15),
            Text(
              texto,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colorTexto,
              ),
            ),
          ],
        ),
      ),
    );
  }
}