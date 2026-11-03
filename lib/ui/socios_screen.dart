import 'package:flutter/material.dart';
import 'package:gymly_socio_nivelacion/core/resultado.dart';
import 'package:gymly_socio_nivelacion/data/repositorio_falso.dart';
import 'package:gymly_socio_nivelacion/models/socio.dart';

// IA: Claude escribió esta pantalla siguiendo mis decisiones (entidad Socio,
// datos de la tarjeta y texto del mensaje de error).

/// Lista de socios que muestra un estado a la vez: cargando, lista o error.
class SociosScreen extends StatefulWidget {
  const SociosScreen({super.key, required this.repositorio});

  final RepositorioFalso repositorio;

  @override
  State<SociosScreen> createState() => _SociosScreenState();
}

class _SociosScreenState extends State<SociosScreen> {
  Resultado<List<Socio>> _estado = const Cargando();

  @override
  void initState() {
    super.initState();
    _cargar();
  }

  Future<void> _cargar() async {
    try {
      final socios = await widget.repositorio.obtener();
      // Mientras se esperaba, la pantalla pudo cerrarse; si ya no existe,
      // no hay nada que redibujar.
      if (!mounted) return;
      setState(() => _estado = Exito(socios));
    } on Exception {
      if (!mounted) return;
      setState(
        () => _estado = const Error(
          'No pudimos cargar los socios. Revisa tu conexión e inténtalo de nuevo.',
        ),
      );
    }
  }

  void _reintentar() {
    setState(() => _estado = const Cargando());
    _cargar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Socios del gimnasio')),
      // Resultado es sellado: el switch cubre los tres estados sin default.
      body: switch (_estado) {
        Cargando() => const Center(child: CircularProgressIndicator()),
        Exito(datos: final socios) => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: socios.length,
          itemBuilder: (context, i) => _TarjetaSocio(socio: socios[i]),
        ),
        Error(mensaje: final mensaje) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.wifi_off, size: 48),
                const SizedBox(height: 16),
                Text(mensaje, textAlign: TextAlign.center),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: _reintentar,
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          ),
        ),
      },
    );
  }
}

/// Tarjeta con el número, nombre, teléfono y estado de un socio.
class _TarjetaSocio extends StatelessWidget {
  const _TarjetaSocio({required this.socio});

  final Socio socio;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Text('${socio.id}')),
        title: Text(socio.nombre),
        subtitle: Text(socio.telefono ?? 'Sin teléfono registrado'),
        trailing: Text(socio.activo ? 'Activo' : 'Inactivo'),
      ),
    );
  }
}
