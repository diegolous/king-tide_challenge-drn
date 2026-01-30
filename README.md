# Futurama Characters Flutter App

Flutter app for the King Tide technical challenge. Shows Futurama characters, details, and series info using Futurama API + OMDb. Built with Clean Architecture + MobX, offline caching, and a reusable design system.

## Specs Coverage (Quick)

- APIs: Futurama (GraphQL) + OMDb (REST)
- ListView/Grid: list rendered with builder (grid for responsive layout)
- Filters: gender/species/status
- Navigation: card → detail (episodes/series info)
- MobX state management
- APK uploaded to Firebase Distribution (done)
- Widget: home screen widget for Android + iOS

## Architecture (Brief)

Feature‑based Clean Architecture: **Presentation → Domain → Data**  
MobX stores manage UI state; Use Cases hold business logic; Repositories abstract data sources; GetIt handles DI.

## Design System

All UI uses design tokens (colors/spacing/typography) and reusable molecules/organisms. Shared UI patterns (badges, info rows) live in the design system to keep features thin and consistent.

## Home Screen Widget

- **Android**: Interactive widget with a refresh action (favorites count).
- **iOS (WidgetKit)**: Timeline‑based updates only. Apple does not allow arbitrary background refresh buttons, so updates happen via timeline refresh + app launches.

## Why These Decisions (4‑day scope, done in 3)

- Prioritized: core spec compliance, clean architecture, offline caching, filters, details, favorites, widget, and i18n.
- Used a design system early to keep UI consistent and reduce duplication.
- Chose GridView for responsive layouts (tablet/desktop/web) while still using builder‑based lists.
- Deferred deep test coverage and some platform‑specific polish to fit the timebox.

## With More Time

- More tests (store + repository + widget tests).
- Replace remaining hardcoded data‑layer messages with localized UI errors.
- Deeper accessibility pass (semantics, contrast, large text).
- Improve widget visuals and richer personalization.
- CI/CD for Firebase App Distribution per flavor.

## Configuration

### API Keys Setup

This project uses build-time configuration for API keys:

1. **Copy the template file**:
   ```bash
   cp config/development.template.json config/development.json
   cp config/development.template.json config/staging.json
   cp config/development.template.json config/production.json
   ```

2. **Update the files** with your API keys:
   - `OMDB_API_KEY`: Get your key from https://www.omdbapi.com/apikey.aspx

See [config/README.md](config/README.md) for more details.

## Run

### Command Line

**Development:**
```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run --dart-define-from-file=config/development.json --flavor dev
```

**Staging:**
```bash
flutter build apk --dart-define-from-file=config/staging.json --flavor stg
```

**Production:**
```bash
flutter build apk --dart-define-from-file=config/production.json --flavor prod --obfuscate --split-debug-info=build/app/outputs/symbols
```

## Links

- Repo: <https://github.com/diegolous/king-tide_challenge-drn>
- Firebase App Distribution (APK): <https://appdistribution.firebase.dev/i/12b431be922988f7>
- Web demo: https://king-tide-challenge-drn.web.app
