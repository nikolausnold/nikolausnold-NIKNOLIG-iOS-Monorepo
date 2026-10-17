import Foundation
import XCTest

final class WorkflowSchemeTests: XCTestCase {
    func testWorkflowBuildSchemesAreShared() throws {
        let root = URL(fileURLWithPath: #filePath)
            .deletingLastPathComponent()
            .deletingLastPathComponent()
        let workflow = try String(
            contentsOf: root.appendingPathComponent(".github/workflows/ios-validation.yml"),
            encoding: .utf8
        )
        let entries = try NSRegularExpression(
            pattern: #"(?m)^\s+project: ([^\r\n]+)\r?\n\s+scheme: ([^\r\n]+)"#
        )
        let matches = entries.matches(in: workflow, range: NSRange(workflow.startIndex..., in: workflow))
        XCTAssertEqual(matches.count, 2, "Both iOS apps must have build matrix entries")

        for match in matches {
            let project = String(workflow[try XCTUnwrap(Range(match.range(at: 1), in: workflow))])
            let scheme = String(workflow[try XCTUnwrap(Range(match.range(at: 2), in: workflow))])
            let sharedScheme = root.appendingPathComponent(project)
                .appendingPathComponent("xcshareddata/xcschemes")
                .appendingPathComponent("\(scheme).xcscheme")
            XCTAssertTrue(
                FileManager.default.fileExists(atPath: sharedScheme.path),
                "CI scheme '\(scheme)' must match a shared .xcscheme filename in \(project)"
            )
        }
    }
}
