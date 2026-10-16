# Build and device verification

## Tooling and commands

Swift Package Manager can build and test the contract/security libraries on platforms with Swift 6:

```sh
swift test
```

The iOS application projects require macOS, Xcode with an iOS SDK, and iOS 17 or later deployment support. From the repository root, build the separate simulator targets with:

```sh
xcodebuild -project apps/niknolig-ios/NIKNOLIG.xcodeproj -scheme NIKNOLIG -destination 'generic/platform=iOS Simulator' build
xcodebuild -project apps/niknolig-defense-ios/NIKNOLIGDefense.xcodeproj -scheme 'NIKNOLIG Defense' -destination 'generic/platform=iOS Simulator' build
```

An Xcode build is not a release approval. To install on a physical device, select an appropriate development team and provisioning profile in Xcode, then verify each app independently on supported iPhone and iPad hardware. No signing credentials or device registration are included in this repository.

## Verification required on Apple hardware

Before calling the apps build-ready, run both Xcode builds and Swift tests on macOS, then verify on supported physical devices:

- install, launch, background, resume, and uninstall each app independently;
- confirm each app retains its distinct bundle identity and cannot read the other app's Keychain items;
- verify Keychain read/write/delete behavior, lock-state behavior, and that items do not migrate through backup;
- confirm no sensor or location permission prompt occurs in the foundation;
- if any later feature adds a sensor, test explicit consent, OS permission denial/revocation, capability absence, interruption, and immediate stop behavior;
- verify device-change flows require the approved consent and fresh authentication on both sides before any transfer;
- record OS version, device model, app build, test result, and redacted evidence without logging secrets or private payloads.

Physical-device results are not available in this Linux run and must not be inferred from SwiftPM tests.

## Update checks and publication gates

The `iOS validation` workflow runs `swift test` and unsigned simulator builds of both apps for every pull request and pushes to the default branch. Dependabot opens weekly update pull requests for GitHub Actions and the root and local Swift package manifests. Local path dependencies remain local; updating dependencies must not silently replace them with external packages or change the approved Android/backend contract.

Before merging dependency updates, configure a default-branch ruleset in [repository settings](https://github.com/nikolausnold/nikolausnold-NIKNOLIG-iOS-Monorepo/settings/rules) requiring pull requests and the `Swift tests and both iOS apps` status check, with no bypass for update bots. Require checks on the current PR revision. Workflow files alone do not enforce merge protection. Automatic merging is not enabled by this change; successful checks are a prerequisite, not permission to bypass review.

For manual release readiness, open [iOS validation](https://github.com/nikolausnold/nikolausnold-NIKNOLIG-iOS-Monorepo/actions/workflows/ios-validation.yml), choose the default branch, and explicitly confirm the readiness check. Only the GitHub account `nikolausnold` may start or rerun this manual path. It repeats the package tests and builds both apps in Release configuration for the simulator. This is not an archive, device acceptance, store-account authentication, or publication approval.

Release responsibilities:

- Prepare iOS updates for NIKNOLIG and NIKNOLIG Defense here and Android updates in [NIKNOLIG-Monorepo](https://github.com/nikolausnold/NIKNOLIG-Monorepo). Review the standalone NIKNOLIG and Defense repositories when coordinating changes; they are not fetched, synchronized, or released by this workflow.
- Coordinate shared API and dependency compatibility across both monorepos before approval; passing iOS checks alone is not evidence that Android passed.
- Keep SecurityChain-P0, backend approval, signing, and the physical-device acceptance requirements above as release blockers.
- Obtain the founder's explicit approval for each app/version/platform through the founder-controlled [App Store Connect](https://appstoreconnect.apple.com/) or [Google Play Console](https://play.google.com/console/) account. GitHub readiness confirmation never substitutes for that approval.
- No store credentials are configured here. A future store-upload workflow must use separately configured protected release environments with founder-only approval before accessing signing or store secrets. Do not enable publishing until those protections and store-account ownership have been verified.
