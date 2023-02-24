@testable import NPAPI
import XCTest

final class NPAPISwiftTests: XCTestCase {
  func testSongName() async {
    let prod = try? NPAPI()
    let res = await prod?.getNPSong()
    print(res!)

    XCTAssert(res?.name != "")
  }
}
