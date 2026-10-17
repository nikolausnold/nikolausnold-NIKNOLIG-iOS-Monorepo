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

## iOS and Android separation

This is the authoritative native iOS source and build repository for both apps. Android source, Gradle projects, APK/AAB artifacts, signing keys, dependency updates, and Google Play releases stay outside this repository.

| Platform | Source and build responsibility | Publication |
| --- | --- | --- |
| iOS: NIKNOLIG and NIKNOLIG Defense | This monorepo; Swift/SwiftUI, SwiftPM and Xcode | App Store Connect, separately approved by the founder |
| Android: NIKNOLIG and NIKNOLIG Defense | [NIKNOLIG-Monorepo](https://github.com/nikolausnold/NIKNOLIG-Monorepo), with the standalone [NIKNOLIG](https://github.com/nikolausnold/NIKNOLIG) and [NIKNOLIG-Defense](https://github.com/nikolausnold/NIKNOLIG-Defense) sources | Google Play Console, separately approved by the founder |

The newly created [NIKNOLIG-iOS-](https://github.com/nikolausnold/NIKNOLIG-iOS-) and [NIKNOLIG-Defense-iOS-](https://github.com/nikolausnold/NIKNOLIG-Defense-iOS-) repositories still contain Android Gradle app configurations as checked on 2026-10-16. Their names do not make those projects native iOS sources. They are not build inputs, dependencies, or publication targets of this monorepo. No files have been moved to or changed in those repositories.

Only reviewed, versioned backend contracts are coordinated across platforms; application code, dependency resolution, credentials, build artifacts, and release approvals remain separate. See [platform boundaries](docs/architecture/overview.md#platform-boundaries).

## Available validation

Run the cross-package tests from the repository root:

```sh
swift test
```

On macOS with Xcode and the iOS SDK installed, build each app for a simulator:

```sh
xcodebuild -project apps/niknolig-ios/NIKNOLIG.xcodeproj -scheme NIKNOLIG -destination 'generic/platform=iOS Simulator' build
xcodebuild -project apps/niknolig-defense-ios/NIKNOLIGDefense.xcodeproj -scheme NIKNOLIGDefense -destination 'generic/platform=iOS Simulator' build
```

The current Linux environment cannot run `xcodebuild` or validate the apps on physical iOS devices. See [build and device verification](docs/architecture/build-and-device-verification.md) and [backend integration status](docs/android-integration/backend-contracts.md). SecurityChain P0 remains a release blocker.

## Updates and release approval

Dependabot checks GitHub Actions and Swift package dependencies weekly and opens update pull requests. The Swift packages currently use local dependencies only; there are no external Swift versions to update yet. Every pull request runs shared-package tests and simulator builds for both apps on macOS.

iOS app and dependency updates are prepared and checked in this monorepo for both iOS apps. Android app and dependency updates are prepared and checked separately in [NIKNOLIG-Monorepo](https://github.com/nikolausnold/NIKNOLIG-Monorepo). A shared contract change requires compatibility review on each platform, not a shared dependency update or release. This setup does not modify or automate the Android or standalone repositories.

App publication requires the founder's explicit confirmation through the respective founder-controlled store account. Nothing here signs, uploads, or publishes an app. See [update checks and publication gates](docs/architecture/build-and-device-verification.md#update-checks-and-publication-gates) for required repository settings and the manual readiness workflow.
