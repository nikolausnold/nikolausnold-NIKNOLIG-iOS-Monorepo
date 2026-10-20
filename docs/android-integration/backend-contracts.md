# Android and backend contract alignment

## Source contract and current limits

The shared source of truth is the `nikolausnold/NIKNOLIG-Monorepo` backend contract. This mirror was checked against upstream commit [`f6d2665195f3b5c71f9e5a8a22f4d9500db8e209`](https://github.com/nikolausnold/NIKNOLIG-Monorepo/commit/f6d2665195f3b5c71f9e5a8a22f4d9500db8e209) on 2026-10-20:

- [`backend/openapi.yaml`](https://github.com/nikolausnold/NIKNOLIG-Monorepo/blob/f6d2665195f3b5c71f9e5a8a22f4d9500db8e209/backend/openapi.yaml) is OpenAPI 3.1.0, version 0.1.0. It defines only `GET /health/live` and `GET /health/ready`; `https://backend.invalid` is explicitly a placeholder, not a deployed/approved host. Its content is unchanged from the previously mirrored revision.
- Its `HealthStatus`, `ApiError`, and 14-value `ErrorCode` enum are mirrored by `SharedModels`. `SharedAPI` can build requests only for the two declared health paths and requires an HTTPS origin. It has no default endpoint and does not send requests.
- [`backend/contracts/`](https://github.com/nikolausnold/NIKNOLIG-Monorepo/tree/f6d2665195f3b5c71f9e5a8a22f4d9500db8e209/backend/contracts) also contains versioned consent, audit-event, sensor-capability, and sensor-summary JSON schemas (`contractVersion` 1.0). These are declarative proposal schemas, not operational endpoints or an iOS runtime implementation; they are not copied or treated as authorization grants here.
- [`backend/ai-support.openapi.yaml`](https://github.com/nikolausnold/NIKNOLIG-Monorepo/blob/f6d2665195f3b5c71f9e5a8a22f4d9500db8e209/backend/ai-support.openapi.yaml) is a separate, disabled preparation contract. It does not extend the health-only contract, authorize an iOS client, or enable a production AI service.
- The backend contract says there are no implemented or approved operational app, device, profile, or pairing APIs and that production integration is blocked pending SecurityChain-P0 and product/security review.

The contract owner must confirm the current revision and approve compatible contract changes before this mirror is expanded. Unknown error codes fail closed. No backend URLs, request/response operations, roles, or data-transfer capabilities have been invented.

## Android compatibility boundaries

The Android apps remain in their separate Gradle modules, `:niknolig` and `:niknolig-defense`; they were not modified. Their application IDs are `com.niknolig.app` and `com.niknolig.defense`; the iOS targets use those corresponding identifiers while retaining independent iOS app bundles and security domains. Android currently has a local Elektro-Engel preview in NIKNOLIG; it is not an AI/backend connection and is not implemented by these thin iOS shells. Android UI, Kotlin/Gradle code, permission declarations, and platform lifecycle behavior must not be copied as if they were shared contracts. The Android multidevice/sensor design is explicitly blocked and describes its JSON schemas as proposals rather than wired APIs. iOS must not infer permission or authorization from those schemas.

The Android monorepo's system registry still marks the iOS repository as pending, and its cross-platform plan describes the iOS repositories as future work. This repository now exists; that upstream inventory has not been changed as part of this iOS-only update.

## Future alignment procedure

For each alignment, record the checked Android monorepo commit and compare its canonical `backend/openapi.yaml` and versioned `backend/contracts/` against this iOS mirror. Keep product UI, local storage, app lifecycle, permissions, signing, and security adapters platform-specific; only adopt a shared contract after review by Android and backend owners. For an approved contract change, update the Swift mirror and run the same contract fixtures against the backend, Android, and iOS consumers. Do not promote Android-only previews or disabled preparation contracts into iOS runtime features. Until a reviewed shared contract changes, retain the current health-only iOS API surface.

## Missing backend dependencies

The following must be supplied and approved before operational integration:

1. SecurityChain-P0 specification, acceptance evidence, threat model, and release authority.
2. Authentication issuer/discovery, sign-in and refresh/revocation contract, token audience/claims, and device-bound identity lifecycle.
3. App-area roles, action-level authorization policy, and the permitted NIKNOLIG/Defense data flows.
4. Approved production base URL, versioning/compatibility policy, operational endpoints, schemas, error semantics, and rate limits.
5. Consent grant/deny/revoke/expiry endpoint semantics, audit delivery/retention, sensor data classes, and device-change protocol.
6. Supported OS/device matrix, recovery and key rotation rules, and security review for any transport or dependency.

Until all relevant dependencies are approved, do not connect production services, add authentication screens, store live credentials, pair devices, transfer private data, or request sensor permission.
