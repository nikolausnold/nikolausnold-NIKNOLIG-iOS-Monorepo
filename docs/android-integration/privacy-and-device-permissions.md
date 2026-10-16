# iOS privacy and device permission policy

The foundation currently requests no iOS permissions and includes no camera, microphone, location, network discovery, or sensor access code.

| Capability | Current foundation | Gate before future use |
| --- | --- | --- |
| Camera | Not requested or accessed | Approved feature and purpose; explicit user action; `NSCameraUsageDescription`; runtime authorization and stop on revocation. |
| Microphone | Not requested or accessed | Approved feature and purpose; explicit user action; `NSMicrophoneUsageDescription`; runtime authorization and stop on revocation. |
| Location | Not requested or accessed | Approved purpose and least-precise supported authorization; `NSLocationWhenInUseUsageDescription`; do not add background access without separate approval. |
| Depth/LiDAR | Not requested or accessed | Check supported capture/depth capability at runtime; never infer LiDAR from device name or generic depth support. Request camera permission only for an approved camera/depth feature. |
| Device change/linking | Not implemented | Explicit consent at source and target, verified peer identity, action-scoped authorization, revocation, and fresh authentication after interruption. |
| Sensitive local data | No app credentials or tokens are defined | Use the Keychain adapter for approved data; its generic-password items use `WhenUnlockedThisDeviceOnly`. Never place secrets in logs, defaults, or shared app groups. |

An OS permission only authorizes an OS capability. It is not consent to transfer data or permission for another app/device to act. No device change may occur without explicit user approval, and no connection may resume automatically after interruption.

SecurityChain P0 remains blocked. These safeguards prepare the boundary but do not certify an implementation or permit production behavior.
