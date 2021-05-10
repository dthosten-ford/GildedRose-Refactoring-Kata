@testable import GildedRose
import XCTest

class GildedRoseTests: XCTestCase {
    var itemsCollection: [Item] {
        [regularItem, sulfurasItem, agedBrie, conjuredItem, backstagePass]
    }
    var regularItem: Item { Item(name: "regular", sellIn: 10, quality: 15) }
    var sulfurasItem: Item { SulfurasItem(name: "Sulfuras, Hand of Ragnaros", sellIn: 5, quality: 10) }
    var agedBrie: Item { Item(name: "Aged Brie", sellIn: 2, quality: 8) }
    var conjuredItem: Item { Item(name: "conjured", sellIn: 20, quality: 21) }
    var backstagePass: Item { Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 15, quality: 25)}
    
    func test_maxQuality_toDontExceed50() {
        for item in itemsCollection {
            item.quality = 50
            let updatedItem = update(item: item)
            XCTAssertLessThanOrEqual(updatedItem.quality, 50, item.name)
        }
    }
    
    func test_quality_neverGoesBelow0() {
        for item in itemsCollection {
            item.quality = 0
            item.sellIn = 0
            let updatedItem = update(item: item)
            XCTAssertGreaterThanOrEqual(updatedItem.quality, 0, item.name)
        }
    }

    func test_sellIn_shouldDecreaseBy1() {
        for item in itemsCollection {
            let updatedItem = update(item: item)
            if (item is NonDecrementingSellIn){
                assertDifference(original: item.sellIn, new: updatedItem.sellIn, expectedDifference: 0, item.name)
            }
            else{
                assertDifference(original: item.sellIn, new: updatedItem.sellIn, expectedDifference: -1, item.name)
            }
            //alternate validation call to remove an If stmt (although not using the new protocol)
            assertSellIn(item, updatedItem)
        }
    }
 
    func assertSellIn(_ original : SulfurasItem, _ new: Item){
        assertDifference(original: original.sellIn, new: new.sellIn, expectedDifference: 0, original.name)
    }
    
    func assertSellIn(_ original : Item, _ new: Item){
        assertDifference(original: original.sellIn, new: new.sellIn, expectedDifference: -1, original.name)
    }
    
    //we are NOT able to overload by protocols, only Inheritance
//    func assertSellIn(_ original : NonDecrementingSellIn, _ new: NonDecrementingSellIn){
//        assertDifference(original: original.sellIn, new: new.sellIn, expectedDifference: 0, original.name)
//    }
    
    func test_regularItem_qualityShouldDecreaseBy1() {
        let updatedItem: Item = update(item: regularItem)
        assertDifference(original: regularItem.quality, new: updatedItem.quality, expectedDifference: -1)
    }
    //remove
    func test_regularItem_sellInShouldDecreaseBy1() {
        let updatedItem = update(item: regularItem)
        assertDifference(original: regularItem.sellIn, new: updatedItem.sellIn, expectedDifference: -1)
    }
    
    func test_expiredRegularItem_qualityDecreaseBy2() {
        let expiredRegularItem = regularItem
        expiredRegularItem.sellIn = 0
        let updatedItem: Item = update(item: expiredRegularItem)
        assertDifference(original: expiredRegularItem.quality, new: updatedItem.quality, expectedDifference: -2)
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
    
    func test_expiredAgedBrie_qualityShouldIncreaseBy2() {
        let expiredAgedBrie = agedBrie
        expiredAgedBrie.sellIn = 0
        let updatedItem = update(item: expiredAgedBrie)
        assertDifference(original: agedBrie.quality, new: updatedItem.quality, expectedDifference: 2)
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
        let backStagePassWithTenDaysLeft = backstagePass
        backStagePassWithTenDaysLeft.sellIn = 10
        let updatedItem = update(item: backStagePassWithTenDaysLeft)
        assertDifference(original: backStagePassWithTenDaysLeft.quality, new: updatedItem.quality, expectedDifference: 2)
    }
    
    func test_backstagePass_WithFiveDaysOrLess_QualityShouldIncreaseBy3() {
        let backStagePassWithFiveDaysOrLessLeft = backstagePass
        backStagePassWithFiveDaysOrLessLeft.sellIn = 4
        let updatedItem = update(item: backStagePassWithFiveDaysOrLessLeft)
        assertDifference(original: backStagePassWithFiveDaysOrLessLeft.quality, new: updatedItem.quality, expectedDifference: 3)
    }
    
    func test_backstagePass_WithQualityAlmostMax_ShouldNotIncreaseAbove50() {
        let backstagePassWitAlmostMaxQuality = backstagePass
        backstagePassWitAlmostMaxQuality.quality = 49
        backstagePassWitAlmostMaxQuality.sellIn = 9
        let updateItem = update(item: backstagePassWitAlmostMaxQuality)
        XCTAssertEqual(updateItem.quality, 50)
    }
    
    func test_nonExpiredConjuredItem_QualityShouldDecreaseBy2() {
        let updatedItem = update(item: conjuredItem)
        assertDifference(
            original: conjuredItem.quality,
            new: updatedItem.quality,
            expectedDifference: -2
        )
    }

    func test_nonExpiredConjuredItem_sellInShouldDecreaseBy1() {
        let updatedItem = update(item: conjuredItem)
        assertDifference(original: conjuredItem.sellIn,
                         new: updatedItem.sellIn,
                         expectedDifference: -1)
    }

    func test_expiredConjuredItem_QualityShouldDecreaseBy4() {
        let expiredItem = conjuredItem
        expiredItem.sellIn = 0
        let updatedItem = update(item: expiredItem)
        assertDifference(original: expiredItem.quality,
                         new: updatedItem.quality,
                         expectedDifference: -4)
    }
    
    func test_expiredConjuredItem_QualityShouldNotBeLessThan0() {
        let expiredItem = conjuredItem
        expiredItem.sellIn = 0
        expiredItem.quality = 3
        let updatedItem = update(item: expiredItem)
        XCTAssertEqual(updatedItem.quality, 0)
    }
    
    func test_conjuredItem_QualityShouldNotBeLessThan0() {
        let item = conjuredItem
        item.quality = 1
        
        let updatedItem = update(item: item)
        XCTAssertEqual(updatedItem.quality, 0)
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
    expectedDifference: Int,
    _ message: String = "",
    file: StaticString = #filePath,
    line: UInt = #line
) {
    let difference = new - original
    XCTAssertEqual(difference, expectedDifference, message, file: file, line: line)
}
