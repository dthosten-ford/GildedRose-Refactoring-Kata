@testable import GildedRose
import XCTest

class GildedRoseTests: XCTestCase {
    
    var regularItem: Item { Item(name: "regular", sellIn: 25, quality: 25) }

    func test_regularItem_qualityShouldDecreaseByOne() {
        let items = [regularItem]
        let app = GildedRose(items: items)
        app.updateQuality();
        XCTAssertEqual(items[0].quality, regularItem.quality - 1)
    }
    
    func test_regualItem_sellInShouldBeSomething() {
        let items = [regularItem]
        let app = GildedRose(items: items)
        app.updateQuality();
        XCTAssertEqual(items[0].sellIn, regularItem.sellIn - 1)
    }
    
}
