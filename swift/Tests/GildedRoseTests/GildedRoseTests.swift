@testable import GildedRose
import XCTest

class GildedRoseTests: XCTestCase {

    func testRegularItem() {
        let items = [Item(name: "foo", sellIn: 10, quality: 900)]
        let app = GildedRose(items: items);
        app.updateQuality();
        XCTAssertEqual("foo", app.items[0].name);
        XCTAssertEqual(items.first?.quality, 899)
        XCTAssertEqual(items.first?.sellIn, 9)
    }
    
    func testExpiredItem() {
        let items = [Item(name: "foo", sellIn: 0, quality: 900)]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssertEqual(items.first?.quality, 898)
        XCTAssertEqual(items.first?.sellIn, -1)
    }
}
