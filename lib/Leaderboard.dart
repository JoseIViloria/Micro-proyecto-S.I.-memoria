import 'package:flutter/material.dart';
import 'package:microproyecto_si/global.dart';

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
    _bestTimeFuture = Global.loadBestTimeString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            FutureBuilder<String>(
              future: _bestTimeFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text('Cargando...');
                } else if (snapshot.hasError) {
                  return const Text('Error al cargar el tiempo');
                } else {
                  return Text('Mejor tiempo: ${snapshot.data}');
                }
              },
            ),
            Text('Último tiempo de la sesión: ${Global.durationString}'),
            SizedBox(
              width: 500,
              height: 200,
              child: FloatingActionButton(
                onPressed: Global.deleteData,
                child: Text('Borrar todos los datos guardados'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
