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
        let item = Item(name: "Aged Brie", sellIn: 1, quality: 50)
        assertChangesAfterUpdate(item: item, expectedQuality: 50, expectedSellIn: 0)
    }

    func testSulfurasDoesNotChangeQualityOrSellIn() {
        let item = Item(name: "Sulfuras, Hand of Ragnaros", sellIn: 0, quality: 30)
        assertChangesAfterUpdate(item: item, expectedQuality: 30, expectedSellIn: 0)
    }
    
    func testBackstageIncreasingQualityByTwoWhenLessThanTenDays() {
        let item = Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 10, quality: 0)
        assertChangesAfterUpdate(item: item, expectedQuality: 2, expectedSellIn: 9)
    }
    
    func testBackstageIncreasingQualityByThreeWhenLessThanFiveDays() {
        let item = Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 5, quality: 0)
        assertChangesAfterUpdate(item: item, expectedQuality: 3, expectedSellIn: 4)
    }
    
    func testBackstageNoQualityAfterEventFinished() {
        let item = Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 0, quality: 90)
        assertChangesAfterUpdate(item: item, expectedQuality: 0, expectedSellIn: -1)
    }
    
    func testBackstageIncreasingQualityByTwoWhenSixDays() {
        let item = Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 6, quality: 0)
        assertChangesAfterUpdate(item: item, expectedQuality: 2, expectedSellIn: 5)
    }
    
    func testConjuredItemsDegradeInQualityTwiceAsFast() {
        let item = Item(name: "Conjured", sellIn: 5, quality: 50)
        assertChangesAfterUpdate(item: item, expectedQuality: 48, expectedSellIn: 4)
    }
    
    func testConjuredItemsDegradeTwiceAsFastAfterExpired() {
        let item = Item(name: "Conjured", sellIn: 0, quality: 50)
        assertChangesAfterUpdate(item: item, expectedQuality: 46, expectedSellIn: -1)
    }
}
