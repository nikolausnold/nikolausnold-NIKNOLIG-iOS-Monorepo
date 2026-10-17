import Foundation
import XCTest

final class IOSBuildConfigurationTests: XCTestCase {
    func testWorkflowBuildSchemesExistInTheirProjects() throws {
        let root = URL(fileURLWithPath: #filePath)
            .deletingLastPathComponent()
            .deletingLastPathComponent()
        let workflow = try String(
            contentsOf: root.appendingPathComponent(".github/workflows/ios-validation.yml"),
            encoding: .utf8
        )
        let pattern = try NSRegularExpression(pattern: #"(?m)^[ \t]+project: (.+)\n[ \t]+scheme: (.+)$"#)
        let matches = pattern.matches(in: workflow, range: NSRange(workflow.startIndex..., in: workflow))
        XCTAssertEqual(matches.count, 2)

        for match in matches {
            let projectRange = try XCTUnwrap(Range(match.range(at: 1), in: workflow))
            let schemeRange = try XCTUnwrap(Range(match.range(at: 2), in: workflow))
            let project = String(workflow[projectRange])
            let scheme = String(workflow[schemeRange])
            let schemeURL = root.appendingPathComponent(project)
                .appendingPathComponent("xcshareddata/xcschemes")
                .appendingPathComponent("\(scheme).xcscheme")
            XCTAssertTrue(FileManager.default.fileExists(atPath: schemeURL.path), "Missing shared scheme: \(schemeURL.path)")
        }
    }
}
