@testable import GildedRose
import XCTest

class GildedRoseTests: XCTestCase {
    var regularItem: Item { Item(name: "regular", sellIn: 25, quality: 25) }
    var sulfurasItem: Item { Item(name: "Sulfuras, Hand of Ragnaros", sellIn: 25, quality: 25) }
    var agedBrie: Item { Item(name: "Aged Brie", sellIn: 25, quality: 25) }
 
    func test_regularItem_qualityShouldDecreaseBy1() {
        XCTAssertEqual(update(item: regularItem).quality, regularItem.quality - 1)
    }
    
    func test_regularItem_sellInShouldDecreaseBy1() {
        let updatedItem = update(item: regularItem)
        XCTAssertEqual(updatedItem.sellIn, regularItem.sellIn - 1)
    }
    
    func test_sulfurasItem_sellInShouldBeUnchanged() {
        let updatedItem = update(item: sulfurasItem)
        XCTAssertEqual(updatedItem.sellIn, sulfurasItem.sellIn)
    }
    
    func test_sulfurasItem_qualityShouldBeUnchanged() {
        let updatedItem = update(item: sulfurasItem)
        XCTAssertEqual(updatedItem.quality, sulfurasItem.quality)
    }
    
    func test_agedBrie_qualityShouldIncreaseBy1() {
        let updatedItem = update(item: agedBrie)
        XCTAssertEqual(updatedItem.quality, agedBrie.quality + 1)
    }
    
    fileprivate func update(item: Item) -> Item {
        let items = [item]
        let app = GildedRose(items: items)
        app.updateQuality()
        return items[0]
    }
}
