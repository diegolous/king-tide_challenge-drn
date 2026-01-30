# Configuration Files

This directory contains environment-specific configuration files that are loaded at build time using `--dart-define-from-file`.

## Setup

1. Copy `development.template.json` to create your environment-specific config files:
   ```bash
   cp development.template.json development.json
   cp development.template.json staging.json
   cp development.template.json production.json
   ```

2. Update each file with the appropriate values for that environment.

## Configuration Values

- **OMDB_API_KEY**: API key for The Open Movie Database (https://www.omdbapi.com)
- **ENVIRONMENT**: Environment name (development, staging, or production)

## Usage

### Development
```bash
flutter run --dart-define-from-file=config/development.json --flavor dev
```

### Staging
```bash
flutter build apk --dart-define-from-file=config/staging.json --flavor stg
```

### Production
```bash
flutter build apk --dart-define-from-file=config/production.json --flavor prod --obfuscate --split-debug-info=build/app/outputs/symbols
```

## VSCode Launch Configurations

All launch configurations in `.vscode/launch.json` automatically load the appropriate config file for each flavor.

## Security Notes

- **Never commit** `development.json`, `staging.json`, or `production.json` to version control
- Only the `.template.json` file should be committed
- These files are excluded via `.gitignore`
- API keys are injected at build time and compiled into the app binary
