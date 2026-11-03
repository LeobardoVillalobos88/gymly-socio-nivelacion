# gymly-socio-nivelacion

Pantalla de socios de **Gymly Socio** (control de membresías y acceso de un gimnasio) con tres estados: cargando, lista y error con reintento. Es la Tarea 3 de nivelación de Desarrollo Móvil Integral (UTEZ, 10.° C).

El trabajo está en la rama [`feat/lista-tres-estados`](https://github.com/LeobardoVillalobos88/gymly-socio-nivelacion/tree/feat/lista-tres-estados).

## Cómo funciona

- `lib/core/resultado.dart`: clase sellada `Resultado<T>` con `Cargando`, `Exito` y `Error`.
- `lib/models/socio.dart`: entidad `Socio`.
- `lib/data/repositorio_falso.dart`: simula al servidor. Tarda 2 segundos y la primera llamada falla, para poder ver el error y el reintento.
- `lib/ui/socios_screen.dart`: pantalla `StatefulWidget` que muestra un estado a la vez con un `switch` exhaustivo.

## Ejecutar y probar

```bash
flutter pub get
flutter run
flutter test
```

Al abrir la app aparece primero el indicador de carga y después el error. Al tocar **Reintentar** carga de nuevo y muestra la lista.

## Evidencia y uso de IA

- Capturas de los tres estados: [`docs/evidencia/`](docs/evidencia/).
- Declaración de uso de IA: [`docs/ia-t3.md`](docs/ia-t3.md).
