import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymly_socio_nivelacion/data/repositorio_falso.dart';
import 'package:gymly_socio_nivelacion/main.dart';

// IA: pruebas escritas con ayuda de Claude.

void main() {
  testWidgets('pasa por cargando, error y lista al reintentar', (tester) async {
    await tester.pumpWidget(GymlyApp(repositorio: RepositorioFalso()));

    // Cargando: la primera llamada todavía no termina.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Error: la primera llamada falla a los 2 segundos, con un mensaje legible.
    await tester.pump(const Duration(seconds: 2));
    expect(find.textContaining('No pudimos cargar los socios'), findsOneWidget);
    expect(find.textContaining('Exception'), findsNothing);
    expect(find.text('Reintentar'), findsOneWidget);

    // Reintento: vuelve a cargando y después muestra la lista.
    await tester.tap(find.text('Reintentar'));
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    expect(find.text('Socio Demo Uno'), findsOneWidget);
    expect(find.byType(Card), findsWidgets);
  });

  testWidgets(
    'no actualiza el estado si la pantalla se cerró durante la carga',
    (tester) async {
      await tester.pumpWidget(GymlyApp(repositorio: RepositorioFalso()));
      // Se quita la pantalla antes de que termine la carga.
      await tester.pumpWidget(const SizedBox());
      await tester.pump(const Duration(seconds: 2));

      expect(tester.takeException(), isNull);
    },
  );
}
