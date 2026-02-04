import 'package:flutter/material.dart';
import 'package:microproyecto_si/global.dart';


/// Pantalla de Récords.
/// Aquí es donde el jugador puede ver su mejor tiempo histórico
/// y compararlo con el de su última partida
class Leaderboard extends StatefulWidget {
  const Leaderboard({super.key});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  late Future<String> _bestTimeFuture;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    setState(() {
      _bestTimeFuture = Global.loadBestTimeString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Barra transparente
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [ 
              Color.fromARGB(255, 251, 252, 255), 
              Color.fromARGB(255, 55, 58, 255), 
              ], 

          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 100), // Espacio para bajar el contenido de la AppBar
            
            // Título con emoji
            const Text(
              '🏆 RÉCORDS 🏆',
              style: TextStyle(
                fontSize: 70,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                color: Colors.black87,
                shadows: [
                  Shadow(
                    blurRadius: 2.0,
                    color: Colors.black12,
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 50), // Espacio entre título y tiempos

            // Mejor tiempo (FutureBuilder)
            FutureBuilder<String>(
              future: _bestTimeFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text(
                    'Error al cargar el tiempo',
                    style: TextStyle(color: Colors.red),
                  );
                } else {
                  return Column(
                    children: [
                      const Text(
                        "Mejor tiempo:",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        snapshot.data ?? 'No existe',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  );
                }
              },
            ),

            const SizedBox(height: 30),

            // Último tiempo de la sesión
            const Text(
              "Último tiempo de la sesión:",
              style: TextStyle(
                fontSize: 22,
                fontStyle: FontStyle.italic, 
                fontFamily: 'Serif', 
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              Global.durationString.isNotEmpty ? Global.durationString : "--:--",
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),

            const Spacer(), 

            // Botón para borrar récord
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0), // Margen inferior
              child: ElevatedButton(
                onPressed: () async {
                  await Global.deleteData(); 
                  _loadData(); 
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Datos borrados correctamente')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple.shade100, 
                  foregroundColor: Colors.purple.shade900, 
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), 
                  ),
                  elevation: 5, 
                ),
                child: const Text(
                  'Borrar todos los datos guardados',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}