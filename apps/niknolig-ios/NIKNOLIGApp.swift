import SharedAPI
import SharedSecurity
import SwiftUI

@main
struct NIKNOLIGApp: App {
    var body: some Scene {
        WindowGroup {
            FoundationHomeView(
                appName: "NIKNOLIG",
                bundleIdentifier: "com.niknolig.app"
            )
        }
    }
}

private struct FoundationHomeView: View {
    let appName: String
    let bundleIdentifier: String

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(appName)
                .font(.largeTitle.bold())
            Text("iOS foundation")
                .font(.title2)
            Label(
                "SecurityChain P0: \(SecurityReadiness.securityChainP0.rawValue)",
                systemImage: "lock.shield"
            )
            .accessibilityIdentifier("security-p0-status")
            Text("No sign-in, device linking, backend data, or sensor access is enabled.")
            Text("Contract paths: \(HealthEndpoint.allCases.map(\.path).joined(separator: ", "))")
                .font(.footnote)
            Text("App identity: \(bundleIdentifier)")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
    }
}
