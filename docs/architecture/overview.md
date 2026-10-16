# iOS foundation architecture

## App boundaries

NIKNOLIG and NIKNOLIG Defense are separate iOS application targets, each with its own Xcode project, bundle identifier, entry point, UI, signing identity, and release lifecycle. The bundle identifiers currently match the Android monorepo (`com.niknolig.app` and `com.niknolig.defense`). Shared Swift packages provide libraries only; they do not share app identity, local storage access groups, credentials, or authorization.

This repository contains iOS projects and Swift packages only. It has no Android Gradle configuration or web application/build configuration. iOS validation is run by the dedicated `iOS validation` workflow; it tests the Swift packages and builds each iOS app as an unsigned simulator build. Android and web builds remain in their respective repositories and workflows.

The app targets are deliberately thin SwiftUI shells. They show the current security gate and contract-only health paths. They do not sign in, make network requests, pair devices, transfer data, or access sensors.

## Swift packages

- `SharedModels` defines the `HealthStatus` and `APIError` values in the current backend OpenAPI proposal. Unknown error codes fail decoding instead of being silently accepted.
- `SharedAPI` constructs HTTPS GET requests only for `/health/live` and `/health/ready`. The request builder has no default server, URLSession, credentials, or retry behavior. The backend specification labels its server URL as a placeholder and does not approve production integration.
- `SharedSecurity` provides an Apple Keychain generic-password adapter using `WhenUnlockedThisDeviceOnly`; non-Apple platforms fail explicitly. Its P0 status is always blocked. No token issuer, authentication flow, authorization policy, or audit event API has been specified, so none is implemented.

These packages use local Swift Package Manager dependencies so both apps can consume the same reviewed contracts without coupling their app targets.

## Privacy and device integration

No camera, microphone, location, Bluetooth, local-network, or depth-sensor usage description or permission request is included. Sensor hardware availability is not implied by a model name or an API being present. A future feature must be independently approved, disclose its purpose in context, request the narrowest OS permission only after user action, check capability at runtime, and stop on denial or revocation.

Device migration/linking is not implemented. The Android integration design requires explicit consent on both installations, fresh peer authentication and authorization, revocation, and no automatic session resumption. The iOS implementation must preserve those boundaries; an OS permission or a shared library is not user consent or backend authorization.

## Security and release gate

SecurityChain P0 is an unconditional blocker. The shared status in this foundation is a visible fail-closed marker, not evidence of compliance or an authorization decision. The concrete P0 criteria, threat-model approval, identity provider, token lifecycle, app-area roles, permitted actions, audit requirements, and recovery process are still missing. Do not enable authentication, backend operations, device switching, sensors, or production releases until those decisions are approved and independently verified.

Production signing and distribution are **OFFEN**. The Xcode targets have separate bundle identifiers and automatic-signing build settings, but no development team, provisioning profile, distribution certificate, App Store Connect configuration, or release workflow is assigned here. CI intentionally performs unsigned simulator builds. Do not add signing material or credentials to this repository.

## Build and device verification

See [build and device verification](build-and-device-verification.md) for the available SwiftPM checks, Apple-tooling requirements, and physical-device acceptance gates.
