import 'package:flutter/material.dart';

import 'Pantalla_Home.dart'; 


//Main del proyecto. Manda a la pantalla de inicio
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      title: 'Memory-Kids',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      
      home: const PantallaInicio(), 
    );
  }
}