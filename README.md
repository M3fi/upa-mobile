# upa-mobile

App móvil Flutter para estudiantes de la plataforma educativa gamificada Upa!.

## Stack

- **Framework:** Flutter (Dart >=3.2)
- **State Management:** BLoC (flutter_bloc)
- **Routing:** go_router
- **DI:** get_it
- **HTTP:** dio
- **WebSocket:** socket_io_client

## Desarrollo

```bash
flutter pub get
flutter run
```

## Generación de código

Los modelos de API se generan desde el contrato OpenAPI en `upa-contracts`:

```bash
# Desde el repo upa-contracts:
npm run codegen:dart -- /path/to/upa-mobile
```

O manualmente con `openapi-generator`:

```bash
openapi-generator generate \
  -i /path/to/upa-contracts/openapi/m0.openapi.yaml \
  -g dart-dio \
  -o lib/data/api \
  --additional-properties=pubName=upa_api
```

## Testing

```bash
flutter test
flutter analyze
```

## Build

```bash
flutter build apk        # Android
flutter build ios        # iOS
flutter build web        # Web
```

## Arquitectura

Clean Architecture con 3 capas:
- `data/` — Fuentes de datos, repositorios, modelos
- `domain/` — Entidades, interfaces, casos de uso
- `presentation/` — BLoCs, páginas, widgets
