# Changelog

## 1.0.1

### Added
- `printImage` method to the printer interface (`IPrinter`), allowing direct image printing from bytes.
- Documentation improvements for public classes and members.
- README updated with image printing usage and feature.
- Expanded topics in pubspec.yaml for better discoverability.

### Changed
- Lowered Dart SDK constraint to ">=3.4.0 <4.0.0" and Flutter to ">=3.22.0" for broader compatibility with dependencies.

### Fixed
- Linter warnings for missing documentation on public members.

## 1.0.0

Initial release with the following features:

### Added
- Multi-printer support:
  - Sunmi printer support for Android devices
  - Bluetooth printer integration
  - USB printer compatibility
  - Desktop system printer support
  - Mobile device printing
- Paper size options:
  - 80mm paper width
  - 58mm paper width
  - A4 paper size
- Platform support:
  - Android
  - iOS
  - Windows
  - Linux
  - macOS
- Printer models:
  - Bluetooth printer model with BLE support
  - USB printer model
- Factory pattern for printer creation
- Platform-specific implementations
- Comprehensive documentation and examples

### Platform-specific Features
- iOS: Swift support with use_frameworks!
- macOS: Print entitlements support
- Android: Bluetooth permissions handling
