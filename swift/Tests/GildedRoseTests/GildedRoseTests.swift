@testable import GildedRose
import XCTest

class GildedRoseTests: XCTestCase {
    var regularItem: Item { Item(name: "regular", sellIn: 25, quality: 25) }
    var sulfurasItem: Item { Item(name: "Sulfuras, Hand of Ragnaros", sellIn: 25, quality: 25) }

    fileprivate func update(item: Item) -> Item {
        let items = [item]
        let app = GildedRose(items: items)
        app.updateQuality()
        return items[0]
    }
    
    func test_regularItem_qualityShouldDecreaseBy1() {
        XCTAssertEqual(update(item: regularItem).quality, regularItem.quality - 1)
    }
    
    func test_regularItem_sellInShouldDecreaseBy1() {
        let items = [regularItem]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssertEqual(items[0].sellIn, regularItem.sellIn - 1)
    }
    
    func test_sulfurasItem_sellInShouldBeUnchanged() {
        let items = [sulfurasItem]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssertEqual(items[0].sellIn, sulfurasItem.sellIn)
    }
    
    func test_sulfurasItem_qualityShouldBeUnchanged() {
        let items = [sulfurasItem]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssertEqual(items[0].quality, sulfurasItem.quality)
    }
}
