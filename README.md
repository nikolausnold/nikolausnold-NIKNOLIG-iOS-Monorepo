# NIKNOLIG iOS Monorepo

Independent SwiftUI foundations for NIKNOLIG and NIKNOLIG Defense, with local Swift packages for backend contract models, health request construction, and Keychain-backed storage.

## Repository map

- `apps/niknolig-ios/` — NIKNOLIG iOS app project and shared Xcode scheme.
- `apps/niknolig-defense-ios/` — separate Defense iOS app project and scheme.
- `packages/shared-api/` — only the two health paths currently present in the backend OpenAPI proposal.
- `packages/shared-models/` — health and API error models aligned to that contract.
- `packages/shared-security/` — Apple Keychain adapter and a fail-closed SecurityChain-P0 status.
- `docs/` — architecture, backend alignment, privacy, and device build/acceptance gates.
- `tests/` — Swift package contract and fail-closed behavior tests.
- `.github/workflows/ios-validation.yml` — iOS-only Swift package tests and unsigned builds for both iOS apps.

## Available validation

Run the cross-package tests from the repository root:

```sh
swift test
```

On macOS with Xcode and the iOS SDK installed, build each app for a simulator:

```sh
xcodebuild -project apps/niknolig-ios/NIKNOLIG.xcodeproj -scheme NIKNOLIG -destination 'generic/platform=iOS Simulator' build
xcodebuild -project apps/niknolig-defense-ios/NIKNOLIGDefense.xcodeproj -scheme 'NIKNOLIG Defense' -destination 'generic/platform=iOS Simulator' build
```

The current Linux environment cannot run `xcodebuild` or validate the apps on physical iOS devices. See [build and device verification](docs/architecture/build-and-device-verification.md) and [backend integration status](docs/android-integration/backend-contracts.md). SecurityChain P0 remains a release blocker.

Production backend/Supabase allocation, authentication, server authorization, RLS/tenant-isolation verification, and production signing/release are **OFFEN**. The current app shells do not make backend requests or implement those capabilities.
