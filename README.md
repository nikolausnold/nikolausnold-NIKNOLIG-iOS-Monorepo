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

iOS app updates are prepared in this monorepo; Android app updates belong in [NIKNOLIG-Monorepo](https://github.com/nikolausnold/NIKNOLIG-Monorepo). NIKNOLIG and NIKNOLIG Defense must both be considered when updating shared dependencies or contracts. This setup does not modify or automate the Android or standalone repositories.

App publication requires the founder's explicit confirmation through the respective founder-controlled store account. Nothing here signs, uploads, or publishes an app. See [update checks and publication gates](docs/architecture/build-and-device-verification.md#update-checks-and-publication-gates) for required repository settings and the manual readiness workflow.
