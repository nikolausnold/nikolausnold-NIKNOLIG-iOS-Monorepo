# Android and backend contract alignment

## Source contract and current limits

The shared source of truth is the `nikolausnold/NIKNOLIG-Monorepo` backend contract at revision `158e20cf7f7d29689dbe09bbb692f29d71d91b69`:

- [`backend/openapi.yaml`](https://github.com/nikolausnold/NIKNOLIG-Monorepo/blob/158e20cf7f7d29689dbe09bbb692f29d71d91b69/backend/openapi.yaml) is OpenAPI 3.1.0, version 0.1.0. It defines only `GET /health/live` and `GET /health/ready`; `https://backend.invalid` is explicitly a placeholder, not a deployed/approved host.
- Its `HealthStatus`, `ApiError`, and 14-value `ErrorCode` enum are mirrored by `SharedModels`. `SharedAPI` can build requests only for the two declared health paths and requires an HTTPS origin. It has no default endpoint and does not send requests.
- [`backend/contracts/`](https://github.com/nikolausnold/NIKNOLIG-Monorepo/tree/158e20cf7f7d29689dbe09bbb692f29d71d91b69/backend/contracts) also contains versioned consent, audit-event, sensor-capability, and sensor-summary JSON schemas (`contractVersion` 1.0). These are declarative proposal schemas, not operational endpoints or an iOS runtime implementation; they are not copied or treated as authorization grants here.
- The backend contract says there are no implemented or approved operational app, device, profile, or pairing APIs and that production integration is blocked pending SecurityChain-P0 and product/security review.

The contract owner must confirm the current revision and approve compatible contract changes before this mirror is expanded. Unknown error codes fail closed. No backend URLs, request/response operations, roles, or data-transfer capabilities have been invented.

## Android compatibility boundaries

The Android apps remain in their separate repository and were not modified. Their current application IDs are `com.niknolig.app` and `com.niknolig.defense`; the iOS targets use those corresponding identifiers while retaining independent iOS app bundles and security domains. The Android multidevice/sensor design is explicitly blocked and describes its JSON schemas as proposals rather than wired APIs. iOS must not infer permission or authorization from those schemas.

Any shared contract change must be reviewed with Android and backend owners, versioned, and tested against both platforms. Until that occurs, the iOS packages mirror only the existing OpenAPI health and error types.

## Missing backend dependencies

The following must be supplied and approved before operational integration:

1. SecurityChain-P0 specification, acceptance evidence, threat model, and release authority.
2. Authentication issuer/discovery, sign-in and refresh/revocation contract, token audience/claims, and device-bound identity lifecycle.
3. App-area roles, action-level authorization policy, and the permitted NIKNOLIG/Defense data flows.
4. Approved production base URL, versioning/compatibility policy, operational endpoints, schemas, error semantics, and rate limits.
5. Consent grant/deny/revoke/expiry endpoint semantics, audit delivery/retention, sensor data classes, and device-change protocol.
6. Supported OS/device matrix, recovery and key rotation rules, and security review for any transport or dependency.

Until all relevant dependencies are approved, do not connect production services, add authentication screens, store live credentials, pair devices, transfer private data, or request sensor permission.
