# Build and device verification

## Tooling and commands

Swift Package Manager can build and test the contract/security libraries on platforms with Swift 6:

```sh
swift test
```

The `.github/workflows/ios-validation.yml` workflow runs these tests and builds each iOS app independently on macOS. Simulator CI builds disable code signing and do not publish or release an app.

The iOS application projects require macOS, Xcode with an iOS SDK, and iOS 17 or later deployment support. From the repository root, build the separate simulator targets with:

```sh
xcodebuild -project apps/niknolig-ios/NIKNOLIG.xcodeproj -scheme NIKNOLIG -destination 'generic/platform=iOS Simulator' build
xcodebuild -project apps/niknolig-defense-ios/NIKNOLIGDefense.xcodeproj -scheme NIKNOLIGDefense -destination 'generic/platform=iOS Simulator' build
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
