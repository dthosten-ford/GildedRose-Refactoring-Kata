@testable import GildedRose
import XCTest

class GildedRoseTests: XCTestCase {
    var regularItem: Item { Item(name: "regular", sellIn: 10, quality: 15) }
    var sulfurasItem: Item { Item(name: "Sulfuras, Hand of Ragnaros", sellIn: 5, quality: 10) }
    var agedBrie: Item { Item(name: "Aged Brie", sellIn: 2, quality: 8) }
    var backstagePass: Item { Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 15, quality: 25)}
 
    func test_regularItem_qualityShouldDecreaseBy1() {
        let updatedItem: Item = update(item: regularItem)
        assertDifference(original: regularItem.quality, new: updatedItem.quality, expectedDifference: -1)
    }
    
    func test_regularItem_sellInShouldDecreaseBy1() {
        let updatedItem = update(item: regularItem)
        assertDifference(original: regularItem.sellIn, new: updatedItem.sellIn, expectedDifference: -1)
    }
    
    func test_sulfurasItem_sellInShouldBeUnchanged() {
        let updatedItem = update(item: sulfurasItem)
        assertDifference(original: sulfurasItem.sellIn, new: updatedItem.sellIn, expectedDifference: 0)
    }
    
    func test_sulfurasItem_qualityShouldBeUnchanged() {
        let updatedItem = update(item: sulfurasItem)
        assertDifference(original: sulfurasItem.quality, new: updatedItem.quality, expectedDifference: 0)
    }
    
    func test_agedBrie_qualityShouldIncreaseBy1() {
        let updatedItem = update(item: agedBrie)
        assertDifference(original: agedBrie.quality, new: updatedItem.quality, expectedDifference: 1)
    }
    
    func test_agedBrie_sellInShouldDecreaseBy1() {
        let updatedItem = update(item: agedBrie)
        assertDifference(original: agedBrie.sellIn, new: updatedItem.sellIn, expectedDifference: -1)
    }

    func test_backstagePass_qualityShouldIncreaseBy1() {
        let updatedItem = update(item: backstagePass)
        assertDifference(original: backstagePass.quality, new: updatedItem.quality, expectedDifference: 1)
    }
    
    func test_backstagePass_sellInShouldDecreaseBy1() {
        let updatedItem = update(item: backstagePass)
        assertDifference(original: backstagePass.sellIn, new: updatedItem.sellIn, expectedDifference: -1)
    }
    
    func test_expiredBackstagePass_qualityShouldbe0() {
        let expiredBackstagePass = backstagePass
        expiredBackstagePass.sellIn = 0
        let updatedItem = update(item: expiredBackstagePass)
        XCTAssertEqual(updatedItem.quality, 0)
    }

    func test_backstagePass_withTenDaysLeft_QualityShouldIncreaseBy2() {
        let backStagePass = backstagePass
        backstagePass.sellIn = 5
        let updatedItem = update(item: backstagePass)
        assertDifference(original: backstagePass.quality, new: updatedItem.quality, expectedDifference: 10)
    }
    
    fileprivate func update(item: Item) -> Item {
        let copy = Item(name: item.name, sellIn: item.sellIn, quality: item.quality)
        let items = [copy]
        let app = GildedRose(items: items)
        app.updateQuality()
        return items[0]
    }
}

fileprivate func assertDifference(
        original: Int,
        new: Int,
        expectedDifference: Int
) {
    let difference = new - original
    XCTAssertEqual(difference, expectedDifference)
}
