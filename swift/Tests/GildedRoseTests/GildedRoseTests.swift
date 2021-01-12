@testable import GildedRose
import XCTest

class GildedRoseTests: XCTestCase {

    private func assertChangesAfterUpdate(item: Item, expectedQuality: Int, expectedSellIn: Int) {
        let app = GildedRose(items: [item])
        app.updateQuality()
        XCTAssertEqual(item.name, app.items[0].name)
        XCTAssertEqual(item.quality, expectedQuality)
        XCTAssertEqual(item.sellIn, expectedSellIn)
    }

    func testRegularItem() {
        let item = Item(name: "foo", sellIn: 10, quality: 900)
        assertChangesAfterUpdate(item: item, expectedQuality: 899, expectedSellIn: 9)
    }
    
    func testExpiredItem() {
        let item = Item(name: "foo", sellIn: 0, quality: 900)
        assertChangesAfterUpdate(item: item, expectedQuality: 898, expectedSellIn: -1)
    }

    func testForNegativeQuality() {
        let item = Item(name: "foo", sellIn: 1, quality: 0)
        assertChangesAfterUpdate(item: item, expectedQuality: 0, expectedSellIn: 0)
    }

    func testAgedBrie() {
        let item = Item(name: "Aged Brie", sellIn: 1, quality: 0)
        assertChangesAfterUpdate(item: item, expectedQuality: 1, expectedSellIn: 0)
    }

    func testMaxQuality() {
        let items = [Item(name: "Aged Brie", sellIn: 1, quality: 50)]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssertEqual(items.first?.quality, 50)
    }

    func testSulfurasDoesNotChangeQualityOrSellIn() {
        let items = [Item(name: "Sulfuras, Hand of Ragnaros", sellIn: 0, quality: 30)]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssertEqual(items.first?.quality, 30)
        XCTAssertEqual(items.first?.sellIn, 0)
    }
    
    func testBackstageIncreasingQualityByTwoWhenLessThanTenDays() {
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 10, quality: 0)]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssertEqual(items.first?.quality, 2)
        XCTAssertEqual(items.first?.sellIn, 9)
    }
    
    func testBackstageIncreasingQualityByThreeWhenLessThanFiveDays() {
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 5, quality: 0)]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssertEqual(items.first?.quality, 3)
        XCTAssertEqual(items.first?.sellIn, 4)
    }
    
    func testBackstageNoQualityAfterEventFinished() {
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 0, quality: 90)]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssertEqual(items.first?.quality, 0)
        XCTAssertEqual(items.first?.sellIn, -1)
    }
}
