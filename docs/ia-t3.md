# Declaración de uso de IA · Nivelación T3

**Alumno:** Leobardo Daniel Bertadillo Villalobos · **Matrícula:** I20233TN098 · **Grupo:** 10.° C
**Herramienta:** Claude Opus 5.5 (Anthropic).

## Cómo trabajamos

Yo tomé las decisiones de diseño de la pantalla. Claude escribió el código siguiendo esas decisiones, me explicó cada parte y lo probamos juntos en mi celular. Las partes hechas con IA están marcadas en el código con comentarios `// IA:`.

## Mis decisiones

- Hacer la tarea en un repositorio propio (`gymly-socio-nivelacion`) en lugar del repositorio del equipo, como lo permitió el profesor, y trabajar en la rama `feat/lista-tres-estados`, sin tocar `main`.
- Mostrar la entidad **Socio** de mi proyecto, la misma de mi T1.
- Datos de cada tarjeta: número, nombre, teléfono y estado. Primero elegí solo nombre y teléfono; después decidí regresar a los cuatro.
- Texto del estado de error: «No pudimos cargar los socios. Revisa tu conexión e inténtalo de nuevo.»
- Evidencia: tres capturas PNG tomadas en mi celular, en lugar de un GIF.
- Hacer los commits espaciados, con mensajes convencionales.

## Prompts principales

1. Le compartí el enunciado y le pedí hacer la tarea en un repositorio aparte, sin tocar el del equipo.
2. Le pedí que me hiciera de una vez todas las preguntas de diseño para decidir yo y que él escribiera y corrigiera el código.
3. «Mejor deja también el número y el estado» (cambio de los datos de la tarjeta).

## Qué acepté, qué cambié o rechacé

- **Acepté:**
  - Reusar mi `Resultado<T>` de la T1 en `lib/core/`.
  - Basar el repositorio falso en el esqueleto del profesor: tarda 2 segundos, la primera llamada falla y regresa 6 socios de ejemplo.
  - Usar un `switch` sin `default` en el `build`.
  - Revisar `if (!mounted) return;` antes de cada `setState` que va después de un `await`.
  - Crear el repositorio una sola vez en `main()`, para que el conteo de llamadas no se reinicie si la app se vuelve a construir.
- **Cambié:** los datos de la tarjeta (de nombre y teléfono a los cuatro datos).
- **Rechacé:** el GIF como evidencia y trabajar en el repositorio del equipo.

## Cómo lo probé

- `flutter analyze` termina sin problemas.
- `flutter test` corre dos pruebas de widget, y las dos pasan:
  1. La pantalla pasa por cargando, luego error con mensaje legible (sin el texto de la excepción) y, al tocar **Reintentar**, vuelve a cargando y termina en la lista.
  2. Si la pantalla se cierra durante la carga, no hay excepción. Comprobamos que esta prueba falla con `setState() called after dispose()` si se quita `if (!mounted) return;`.
- En mi celular (Xiaomi, Android 16) revisé los tres estados y el reintento. Las capturas están en `docs/evidencia/`.

## Lo que sé explicar

- **Estados de `Resultado`:** `Cargando` mientras espera al repositorio; `Exito` trae la lista de socios; `Error` trae el mensaje que se muestra. Como la clase es `sealed`, el compilador conoce los tres casos y el `switch` no necesita `default`. Si faltara uno, no compilaría.
- **Ciclo `setState` → `build`:** `setState` cambia `_estado` y le avisa a Flutter que vuelva a llamar a `build`, que dibuja según el estado nuevo.
- **`mounted`:** durante el `await` de 2 segundos la pantalla puede cerrarse. Si ya no está montada, `setState` lanzaría un error, así que antes se revisa `mounted`.
