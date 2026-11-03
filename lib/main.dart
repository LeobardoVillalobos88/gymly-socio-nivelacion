import 'package:flutter/material.dart';
import 'package:gymly_socio_nivelacion/data/repositorio_falso.dart';
import 'package:gymly_socio_nivelacion/ui/socios_screen.dart';

// El repositorio se crea una sola vez aquí, para que conserve su conteo
// de llamadas aunque la app se vuelva a construir.
void main() => runApp(GymlyApp(repositorio: RepositorioFalso()));

class GymlyApp extends StatelessWidget {
  const GymlyApp({super.key, required this.repositorio});

  final RepositorioFalso repositorio;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gymly Socio',
      theme: ThemeData(colorSchemeSeed: Colors.teal),
      home: SociosScreen(repositorio: repositorio),
    );
  }
}
