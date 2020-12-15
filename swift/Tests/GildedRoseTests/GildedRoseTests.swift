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

    func testForNegativeQuality() {
        let items = [Item(name: "foo", sellIn: 1, quality: 0)]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssertEqual(items.first?.quality, 0)
    }

    func testAgedBrie() {
        let items = [Item(name: "Aged Brie", sellIn: 1, quality: 0)]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssertEqual(items.first?.quality, 1)
        XCTAssertEqual(items.first?.sellIn, 0)
    }

    func testMaxQuality() {
        let items = [Item(name: "Aged Brie", sellIn: 1, quality: 50)]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssertEqual(items.first?.quality, 50)
    }

    func testSulfuras() {
        let items = [Item(name: "Sulfuras", sellIn: 0, quality: 30)]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssertEqual(items.first?.quality, 30)
        XCTAssertEqual(items.first?.sellIn, 1)
    }
}
