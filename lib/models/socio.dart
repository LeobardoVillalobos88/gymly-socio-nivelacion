// IA: entidad de Gymly Socio que Claude propuso en la T1 de nivelación.

/// Persona inscrita en el gimnasio.
class Socio {
  const Socio({
    required this.id,
    required this.nombre,
    // Opcional: no todos los socios dan su número; solo se usa para avisos.
    this.telefono,
    this.activo = true,
  });

  final int id;
  final String nombre;
  final String? telefono;
  final bool activo;
}
