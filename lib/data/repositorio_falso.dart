import 'package:gymly_socio_nivelacion/models/socio.dart';

// IA: basado en el esqueleto del profesor; Claude lo adaptó a Socio.

/// Simula al servidor: tarda 2 segundos y la primera llamada falla,
/// para poder probar el estado de error y el reintento.
class RepositorioFalso {
  int _llamadas = 0;

  Future<List<Socio>> obtener() async {
    await Future.delayed(const Duration(seconds: 2));
    _llamadas++;
    if (_llamadas == 1) throw Exception('Sin conexión');
    return const [
      Socio(id: 1, nombre: 'Socio Demo Uno', telefono: '777-000-0001'),
      Socio(id: 2, nombre: 'Socio Demo Dos'),
      Socio(
        id: 3,
        nombre: 'Socio Demo Tres',
        telefono: '777-000-0003',
        activo: false,
      ),
      Socio(id: 4, nombre: 'Socio Demo Cuatro', telefono: '777-000-0004'),
      Socio(id: 5, nombre: 'Socio Demo Cinco'),
      Socio(id: 6, nombre: 'Socio Demo Seis', telefono: '777-000-0006'),
    ];
  }
}
